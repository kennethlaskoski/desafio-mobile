//
//  Finance.swift
//  Currency
//
//  Created by Kenneth Laskoski on 10/07/21.
//

import Foundation

// We define the dimension
// for finacial quantities
final class Finance: Dimension {

  // With the dollar as
  // our reference unit
  static let dollar = Finance(
    symbol: "USD",
    converter: UnitConverterLinear(coefficient: 1.0)
  )

  override class func baseUnit() -> Finance {
    return dollar
  }
}

// We write a lookup
extension Currency {
  typealias NamesMap = [ID : String]

  static var names: NamesMap = [
    "USD": "United States Dollar",
    "BRL": "Brazilian Real",
    "GBP": "British Pound Sterling",
    "EUR": "Euro",
  ]

  init?(with id: ID) {
    guard let name = Currency.names[id] else {
      return nil
    }
    self.init(id: id, name: name)
  }
}

// Making the currency
// just a denomination
extension Finance {
  var currency: Currency? {
    Currency(with: symbol)
  }
}
