//
//  ConvertModel.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import Combine
import Foundation

class ConvertModel: ObservableObject {
  private let parent: CurrencyModel
  private let api = CurrencyLayer()

  init(from parent: CurrencyModel) {
    self.parent = parent
  }

  @Published private var lastRefresh: Date?
  @Published var amount = 1.0
  @Published var sourceCurrency: Currency = .dollar
  @Published var resultCurrency: Currency = .dollar

  var rate: Amount {
    Amount(value: 1.0, unit: sourceCurrency.unit).converted(to: resultCurrency.unit)
  }
  var result: Amount {
    Amount(value: amount, unit: sourceCurrency.unit).converted(to: resultCurrency.unit)
  }

  var cancellable: AnyCancellable?
}

// MARK: View presentation
extension ConvertModel {
  private static let formatter: NumberFormatter = {
    var formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }()

  var formatter: NumberFormatter {
    ConvertModel.formatter
  }

  private static let rateFormatter: NumberFormatter = {
    var formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 6
    formatter.maximumFractionDigits = 6
    return formatter
  }()

  var rateFormatter: NumberFormatter {
    ConvertModel.rateFormatter
  }

  var formattedQuote: String {
    return String("\(rateFormatter.string(from: rate.value as NSNumber)!) \(rate.unit.symbol)")
  }

  var formattedResult: String {
    String("\(formatter.string(from: result.value as NSNumber)!) \(result.unit.symbol)")
  }
}

extension ConvertModel {
  private static let dateFormatter: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
  }()

  var formattedLastRefresh: String {
    lastRefresh == nil ? "never" : ConvertModel.dateFormatter.string(from: lastRefresh!)
  }
}

// MARK: API Connection
extension ConvertModel {

  func refreshLive() {
    cancellable = api.livePublisher()
      .flatMap { list in
        list.publisher
      }
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished:
            self.lastRefresh = Date()
          case .failure(let error):
            print(error)
          }
          self.cancellable?.cancel()
        },

        receiveValue: { key, value in
          let key = String(key.dropFirst(3))
          if let currency = self.parent.currencies[key] {
            self.parent.currencies[key] = Currency(id: key, name: currency.name, quote: value)
          } else {
            self.parent.currencies[key] = Currency(id: key, name: "unknown", quote: value)
          }
        }
      )
  }
}
