//
//  Currency.swift
//  Currency
//
//  Created by Kenneth Laskoski on 16/07/21.
//

import Foundation

struct Currency: Identifiable, Equatable {
  let id: String
  var name: String = "unknown"
  var quote: Double = 1.0
}

extension Currency {
  static let dollar = Currency(id: "USD", name: "United States Dollar", quote: 1.0)
}

extension Currency {
  var unit: Money {
    Money(symbol: id, converter: UnitConverterLinear(coefficient: 1.0 / quote))
  }
}
