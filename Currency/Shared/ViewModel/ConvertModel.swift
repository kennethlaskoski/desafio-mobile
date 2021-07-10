//
//  ConvertModel.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import Foundation

class ConvertModel: ObservableObject {
  private static let defaultSource = Money(value: 1.0, unit: .dollar)

  @Published var source = defaultSource
  @Published var quote = defaultSource

  var result: Money {
    source.converted(to: quote.unit)
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

  var formattedQuoteAmount: String {
    formatter.string(from: quote.value as NSNumber)!
  }

  var formattedResult: String {
    formatter.string(from: result.value as NSNumber)!
  }
}

// MARK: View binding
extension ConvertModel {
  var sourceAmount: Double {
    get { source.value }
    set { source = Money(value: newValue, unit: source.unit) }
  }

  var sourceCurrency: Currency {
    get { source.unit.currency! }
    set { source = Money(value: source.value, unit: Finance(symbol: newValue.id)) }
  }
}

extension ConvertModel {
  var quoteCurrency: Currency {
    get { quote.unit.currency! }
    set { quote = Quote(value: quote.value, unit: Finance(symbol: newValue.id)) }
  }
}
