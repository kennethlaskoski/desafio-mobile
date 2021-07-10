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
  @Published var currencies: [Currency] = []
  private var lastListRefresh: Date?

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
            case .finished: break
            case .failure(let error): print(error)
          }
          self.cancellable?.cancel()
        },

        receiveValue: { data in
          Currency.resetList(with: data)
          self.lastListRefresh = Date()
          self.currencies = data.map { pair in
            Currency(with: pair)
          }.sorted(by: { lhs, rhs in lhs.id < rhs.id })
        }
      )
  }
}
