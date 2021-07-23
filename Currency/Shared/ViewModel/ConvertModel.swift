//
//  ConvertModel.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import Foundation

struct ConvertModel {
  var amount = 1.0
  var sourceCurrency: Currency = .dollar
  var resultCurrency: Currency = .dollar

  var rate: Amount<Money> {
    Amount(value: 1.0, unit: sourceCurrency.unit).converted(to: resultCurrency.unit)
  }

  var result: Amount<Money> {
    Amount(value: amount, unit: sourceCurrency.unit).converted(to: resultCurrency.unit)
  }
}
