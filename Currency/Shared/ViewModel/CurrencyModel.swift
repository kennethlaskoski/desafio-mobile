//
//  CurrencyModel.swift
//  Currency
//
//  Created by Kenneth Laskoski on 15/07/21.
//

import Combine
import Foundation

class CurrencyModel: ObservableObject {
  @Published private var lastNamesRefresh: Date?
  @Published private var lastQuotesRefresh: Date?

  @Published var currencies: [Currency] = [.dollar]
  @Published var convertModel = ConvertModel()

  private let api = CurrencyLayer()
  private var listCancellable: AnyCancellable?
  private var liveCancellable: AnyCancellable?
}

fileprivate extension Currency {
  static var names: [String: String] = [
    dollar.id: "United States Dollar",
  ]
  static var quotes: [String: Double] = [
    dollar.id: 1.0,
  ]
}

extension Currency {
  static let dollar = Currency(id: "USD")

  var name: String { Currency.names[id] ?? "unknown" }
  var quote: Double { Currency.quotes[id] ?? 1.0 }
  var unit: Money {
    Money(symbol: id, converter: UnitConverterLinear(coefficient: 1.0 / quote))
  }
}

extension CurrencyModel {
  private static let formatter: NumberFormatter = {
    var formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }()

  var formatter: NumberFormatter {
    CurrencyModel.formatter
  }

  var formattedResult: String {
    String("\(formatter.string(from: convertModel.result.value as NSNumber)!) \(convertModel.result.unit.symbol)")
  }

  private static let rateFormatter: NumberFormatter = {
    var formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 6
    formatter.maximumFractionDigits = 6
    return formatter
  }()

  var rateFormatter: NumberFormatter {
    CurrencyModel.rateFormatter
  }

  var formattedQuote: String {
    return String("\(rateFormatter.string(from: convertModel.rate.value as NSNumber)!) \(convertModel.rate.unit.symbol)")
  }

  private static let dateFormatter: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
  }()

  var formattedLastNamesRefresh: String {
    lastNamesRefresh == nil ? "never" : CurrencyModel.dateFormatter.string(from: lastNamesRefresh!)
  }

  var formattedLastQuotesRefresh: String {
    lastQuotesRefresh == nil ? "never" : CurrencyModel.dateFormatter.string(from: lastQuotesRefresh!)
  }
}

extension CurrencyModel {
  func refreshNames() {
    listCancellable = api.listPublisher()
      .flatMap { list in
        list.publisher
      }
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished:
            self.currencies = Currency.names.keys
              .sorted(by: <)
              .map { Currency(id: $0) }

            self.lastNamesRefresh = Date()

          case .failure(let error):
            print(error)
          }

          self.listCancellable?.cancel()
        },

        receiveValue: { key, value in
          Currency.names[key] = value
        }
      )
  }

  func refreshQuotes() {
    liveCancellable = api.livePublisher()
      .flatMap { list in
        list.publisher
      }
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished:
            self.lastQuotesRefresh = Date()
          case .failure(let error):
            print(error)
          }
          self.liveCancellable?.cancel()
        },

        receiveValue: { key, value in
          let id = String(key.dropFirst(3))
          Currency.quotes[id] = value
        }
      )
  }
}
