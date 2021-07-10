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
  @Published private var lastListRefresh: Date?
  var currencies: [Currency] {
    Currency.names.map { pair in
        Currency(id: pair.key, name: pair.value)
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

  var lastRefresh: String {
    lastListRefresh == nil ? "never" : ListModel.dateFormatter.string(from: lastListRefresh!)
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
            self.lastListRefresh = Date()
          case .failure(let error):
            print(error)
          }
          self.cancellable?.cancel()
        },

        receiveValue: { list in
          Currency.names = list
        }
      )
  }
}
