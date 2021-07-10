//
//  Quote.swift
//  Currency
//
//  Created by Kenneth Laskoski on 09/07/21.
//

import Foundation

struct Money {
  let quantity: Decimal
  let currency: Currency
}

struct Quote {
  let date: Date
  let amount: Money
}
