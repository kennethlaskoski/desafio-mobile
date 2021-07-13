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
  var currencies: [Quote] {
    Quote.quotes.map { (symbol, coefficient) in
      Quote(symbol: symbol, converter: UnitConverterLinear(coefficient: coefficient))
    }.sorted(by: { lhs, rhs in lhs.id < rhs.id })
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
            Quote.quotes.merge(
              Quote.names.keys.map { symbol in
                (symbol, 1.0)
              }
            ) { current, _ in
              current
            }
            self.lastRefresh = Date()
          case .failure(let error):
            print(error)
          }
          self.cancellable?.cancel()
        },

        receiveValue: { list in
          Quote.names.merge(list) { (_, new) in new }
        }
      )
  }
}
