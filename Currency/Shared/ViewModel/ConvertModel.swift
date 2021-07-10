//
//  ConvertModel.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import Foundation

class ConvertModel: ObservableObject {
  private static let defaultSource = Money(quantity: 1.0, currency: Currency(id:"USD", name: "United States Dollar"))

  @Published var source = defaultSource
  @Published var quote = Quote(date: Date(), amount: defaultSource)

  var result: Money {
    source * quote
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
    formatter.string(from: quote.amount.quantity as NSNumber)!
  }

  var formattedResult: String {
    formatter.string(from: result.quantity as NSNumber)!
  }
}

// MARK: View binding
extension ConvertModel {
  var sourceAmount: Double {
    get { source.quantity }
    set { source = Money(quantity: newValue, currency: source.currency) }
  }

  var sourceCurrency: Currency {
    get { source.currency }
    set { source = Money(quantity: source.quantity, currency: newValue) }
  }
}

extension ConvertModel {
  var quoteCurrency: Currency {
    get { quote.amount.currency }
    set { quote = Quote(date: quote.date, amount: Money(quantity: quote.amount.quantity, currency: newValue)) }
  }
}
