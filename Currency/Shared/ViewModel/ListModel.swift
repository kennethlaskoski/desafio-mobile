//
//  CurrencyList.swift
//  Currency
//
//  Created by Kenneth Laskoski on 09/07/21.
//

import Combine
import Foundation

// MARK: View data
class ListModel: ObservableObject {
  @Published private var lastRefresh: Date?
  var quotes: [Quote.ID: Quote] = [Quote.dollar.id: .dollar]
  var currencies: [Quote] {
    quotes.map { (_, quote) in quote }
  }

  private var cancellable: AnyCancellable?
}

// MARK: View presentation
extension ListModel {
  private static var dateFormatter: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
  }()

  var formattedLastRefresh: String {
    lastRefresh == nil ? "never" : ListModel.dateFormatter.string(from: lastRefresh!)
  }
}

// MARK: API Connection
extension ListModel {

  func refreshList() {
    cancellable = CurrencyLayer.listPublisher()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished:
            let newQuotes = Currency.names.keys.map { symbol in
              (
                symbol,
                Quote(
                  symbol: symbol,
                  converter: UnitConverterLinear(coefficient: 1.0)
                )
              )
            }
            self.quotes.merge(newQuotes) { current, _ in
              current
            }
            self.lastRefresh = Date()
          case .failure(let error):
            print(error)
          }
          self.cancellable?.cancel()
        },

        receiveValue: { list in
          Currency.names.merge(list) { (_, new) in new }
        }
      )
  }
}
