//
//  Quote.swift
//  Currency
//
//  Created by Kenneth Laskoski on 09/07/21.
//

import Foundation

struct Quote {
  let date: Date
  let amount: Money

  static func * (lhs: Money, rhs: Quote) -> Money {
    Money(quantity: lhs.quantity * rhs.amount.quantity, currency: rhs.amount.currency)
  }
}
