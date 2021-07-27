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

extension ConvertModel {
  private static let formatter: NumberFormatter = {
    var formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.isLenient = true
    formatter.currencySymbol = ""
//    formatter.minimumFractionDigits = 2
//    formatter.maximumFractionDigits = 2
    return formatter
  }()

  var formatter: NumberFormatter {
    ConvertModel.formatter
  }

  var formattedResult: String {
    String("\(formatter.string(from: result.value as NSNumber)!) \(result.unit.symbol)")
  }

  private static let rateFormatter: NumberFormatter = {
    var formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 6
    formatter.maximumFractionDigits = 6
    return formatter
  }()

  var rateFormatter: NumberFormatter {
    ConvertModel.rateFormatter
  }

  var formattedQuote: String {
    return String("\(rateFormatter.string(from: rate.value as NSNumber)!) \(rate.unit.symbol)")
  }
}
