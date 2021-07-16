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
  private let parent: CurrencyModel

  init(from parent: CurrencyModel) {
    self.parent = parent
  }

  @Published private var lastRefresh: Date?
  var currencies: [Currency] {
    parent.currencies.map { $1 }.sorted { lhs, rhs in lhs.id < rhs.id }
  }

  private var cancellable: AnyCancellable?
}

// MARK: View presentation
extension ListModel {
  private static let dateFormatter: DateFormatter = {
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
          if let currency = self.parent.currencies[key] {
            self.parent.currencies[key] = Currency(id: key, name: value, quote: currency.quote)
          } else {
            self.parent.currencies[key] = Currency(id: key, name: value, quote: 1.0)
          }
        }
      )
  }
}
