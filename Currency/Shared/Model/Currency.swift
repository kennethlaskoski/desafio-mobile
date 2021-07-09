//
//  Currency.swift
//  Currency
//
//  Created by Kenneth Laskoski on 08/07/21.
//

import Foundation

protocol Currency {
  var code: String { get }
  var name: String { get }
}

protocol Money {
  var quantity: Decimal { get }
  var currency: Currency { get }
}

protocol Quote {
  var date: Date { get }
  var amount: Money { get }
}
