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
  private var lastListRefresh: Date?
  @Published var currencies: [Currency] = [
    Currency(id: "USD", name: "United States Dollar"),
    Currency(id: "BRL", name: "Brazilian Real"),
    Currency(id: "GBP", name: "British Pound Sterling"),
    Currency(id: "EUR", name: "Euro"),
  ]

  private var buffer: Currency.ListRepresentation = [:]
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
  private func resetList() {
    lastListRefresh = Date()
    currencies = self.buffer.map { pair in
      Currency(id: pair.key, name: pair.value)
    }.sorted(by: { lhs, rhs in lhs.id < rhs.id })
  }

  func refreshList() {
    cancellable = CurrencyLayer.listPublisher()
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished:
            self.resetList()
          case .failure(let error):
            print(error)
          }
          self.cancellable?.cancel()
        },

        receiveValue: { list in
          self.buffer = list
        }
      )
  }
}
