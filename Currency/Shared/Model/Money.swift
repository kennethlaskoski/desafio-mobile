//
//  Money.swift
//  Currency
//
//  Created by Kenneth Laskoski on 08/07/21.
//

import Foundation

// We define the dimension
// for finacial quantities
final class Money: Dimension {

  // With the dollar as our
  // default reference unit
  static let dollar = Money(symbol: "USD", converter: UnitConverterLinear(coefficient: 1.0))

  static var reference: Money = .dollar
  override class func baseUnit() -> Money { reference }
}

typealias Amount = Measurement
