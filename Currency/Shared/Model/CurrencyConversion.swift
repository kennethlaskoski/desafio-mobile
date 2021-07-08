//
//  CurrencyConversion.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import Foundation

class CurrencyConversion: ObservableObject {
  @Published var amount: Decimal
  @Published var quote: CurrencyQuote

  init(amount: Decimal = 1.0, quote: CurrencyQuote) {
    self.amount = amount
    self.quote = quote
  }

  var result: Decimal {
    amount * quote.rate
  }
}
