//
//  ConvertModel.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import Foundation

class ConvertModel: ObservableObject {
  private static let defaultSource = Value(value: 1.0, unit: .dollar)

  @Published var source = defaultSource
  @Published var quote = defaultSource.unit

  var result: Value {
    source.converted(to: quote)
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

  var formattedQuote: String {
    let rate = quote.converter.value(fromBaseUnitValue: source.unit.converter.baseUnitValue(fromValue: 1.0))
    return formatter.string(from: rate as NSNumber)!
  }

  var formattedResult: String {
    formatter.string(from: result.value as NSNumber)!
  }
}

// MARK: View binding
extension ConvertModel {
  var sourceUnit: Money {
    get { source.unit }
    set { source = Value(value: source.value, unit: newValue) }
  }
}
