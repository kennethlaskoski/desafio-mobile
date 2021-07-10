//
//  ConvertModel.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import Foundation

class ConvertModel: ObservableObject {
  @Published var amount: Decimal = 1.0
  @Published var from = Currency(with: ("USD", "United States Dollar"))
  @Published var to = Currency(with: ("BRL", "Brazilian Real"))

  var result: Decimal {
    amount * 1.0
  }
}

// MARK: View presentation
extension ConvertModel {
  private static var formatter: NumberFormatter = {
    var formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }()

  var formatter: NumberFormatter {
    ConvertModel.formatter
  }
}
