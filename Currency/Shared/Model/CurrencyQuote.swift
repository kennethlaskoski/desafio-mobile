//
//  CurrencyQuote.swift
//  Currency
//
//  Created by Kenneth Laskoski on 08/07/21.
//

import Foundation

struct CurrencyQuote {
  let rate: Decimal = 1.0
  let from: Currency
  let to: Currency

  init(from: Currency, to: Currency) {
    self.from = from
    self.to = to
  }
}
