//
//  ConvertModel.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import Combine
import Foundation

class ConvertModel: ObservableObject {
  @Published private var lastRefresh: Date?
  private static let defaultSource = Value(value: 1.0, unit: .dollar)

  @Published var source = defaultSource
  var sourceUnit: Money {
    get { source.unit }
    set { source = Value(value: source.value, unit: newValue) }
  }
  var rate: Value {
    Value(value: 1.0, unit: source.unit).converted(to: resultUnit)
  }
  @Published var resultUnit = defaultSource.unit
  var result: Value { source.converted(to: resultUnit) }

  var cancellable: AnyCancellable?
}

// MARK: View presentation
extension ConvertModel {
  private static var formatter: NumberFormatter = {
    var formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }()

  var formatter: NumberFormatter {
    ConvertModel.formatter
  }

  private static var rateFormatter: NumberFormatter = {
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
  private static var dateFormatter: DateFormatter = {
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

  func refreshQuotes() {
    cancellable = CurrencyLayer.livePublisher()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished:
            self.resultUnit = Quote(
              symbol: self.resultUnit.symbol,
              converter: UnitConverterLinear(coefficient: Quote.quotes[self.resultUnit.symbol] ?? 1.0)
            )
            self.lastRefresh = Date()
          case .failure(let error):
            print(error)
          }
          self.cancellable?.cancel()
        },

        receiveValue: { list in
          let mapped = list.map { id, value in
            (String(id.dropFirst(3)), 1.0 / value)
          }
          Quote.quotes.merge(mapped) {
            (_, new) in new
          }
        }
      )
  }
}
