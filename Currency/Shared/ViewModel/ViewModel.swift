//
//  ViewModel.swift
//  Currency
//
//  Created by Kenneth Laskoski on 08/07/21.
//

import Combine
import Foundation

class ViewModel: ObservableObject {
  @Published var currencies: [Currency] = []
  @Published var conversion = CurrencyConversion(
    amount: 1.0,
    from: Currency(("USD", "US Dollar")),
    to: Currency(("BRL", "Brazilian Real"))
  )

  var listCancellable: AnyCancellable?
  init() {
    listCancellable = refreshList()
  }

  struct Currency {
    private let data: (code: String, name: String)
    init(code: String, name: String) {
      data = (code, name)
    }
  }

  struct Money {
    private let data: (quantity: Decimal, currency: Currency)
    init(quantity: Decimal, currency: Currency) {
      data = (quantity, currency)
    }
  }

  struct Quote {
    private let data: (date: Date, amount: Money)
    init(date: Date, amount: Money) {
      data = (date, amount)
    }
  }
}

extension ViewModel.Currency: Currency {
  var code: String { data.code }
  var name: String { data.name }

  init(_ pair: (key: String, value: String)) {
    data = (pair.key, pair.value)
  }
}

extension ViewModel.Currency: Identifiable {
  var id: String { code }
}

extension ViewModel.Money: Money {
  var quantity: Decimal { data.quantity }
  var currency: Currency { data.currency }
}

extension ViewModel.Quote: Quote {
  var date: Date { data.date }
  var amount: Money { data.amount }
}

extension ViewModel {
  func refreshList() -> AnyCancellable? {
    return CurrencyLayer.listPublisher()
    .receive(on: DispatchQueue.main)
    .sink(
      receiveCompletion: { error in
        print(error)
      },
      receiveValue: { data in
        self.currencies = data.map { pair in
          Currency(pair)
        }.sorted(by: { lhs, rhs in lhs.code < rhs.code })
      }
    )
  }
}
