//
//  CurrencyConversion.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import Foundation

extension ViewModel {
  struct CurrencyConversion {
    var amount: Decimal
    var from: Currency
    var to: Currency

    var result: Decimal {
      amount * 1.0
    }
  }
}

extension ViewModel {
  static var numberFormatter: NumberFormatter = {
    var formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }()
}
