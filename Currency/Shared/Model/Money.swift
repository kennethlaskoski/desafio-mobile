//
//  Money.swift
//  Currency
//
//  Created by Kenneth Laskoski on 10/07/21.
//

import Foundation

// We define the dimension
// for finacial quantities
final class Money: Dimension {

  // With the dollar as
  // our reference unit
  static let dollar = Money(
    symbol: "USD",
    converter: UnitConverterLinear(coefficient: 1.0)
  )

  override class func baseUnit() -> Money {
    return dollar
  }
}

// Various names for financial amounts
typealias Price = Measurement<Money>
typealias Value = Measurement<Money>
