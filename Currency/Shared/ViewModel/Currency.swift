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

extension Currency {
  static var names: [ID: String] = [Money.dollar.symbol: "United States Dollar"]
}

extension Money {
  var currency: Currency {
    return Currency(id: symbol, name: Currency.names[symbol]!)
  }
}

extension Money: Identifiable {
  var id: String { symbol }
}
