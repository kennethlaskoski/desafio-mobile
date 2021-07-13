//
//  Currency.swift
//  Currency
//
//  Created by Kenneth Laskoski on 08/07/21.
//

import Foundation

struct Currency: Identifiable, Equatable {
  let id: String
  let name: String
}

typealias Quote = Money

extension Quote: Identifiable {
  var id: String { symbol }
}

extension Quote {
  static var quotes: [ID: Double] = [Quote.dollar.id: 1.0]
  static var names: [ID: String] = [Money.dollar.id: "United States Dollar"]
}

extension Quote {
  var currency: Currency {
    return Currency(id: symbol, name: Quote.names[symbol] ?? "unknown")
  }
}
