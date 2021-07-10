//
//  ViewModel.swift
//  Currency
//
//  Created by Kenneth Laskoski on 08/07/21.
//

import Foundation

class ViewModel: ObservableObject {
  @Published var conversion = CurrencyConversion(
    amount: 1.0,
    from: Currency(with: ("USD", "US Dollar")),
    to: Currency(with: ("BRL", "Brazilian Real"))
  )
}
