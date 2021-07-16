//
//  CurrencyModel.swift
//  Currency (iOS)
//
//  Created by Kenneth Laskoski on 15/07/21.
//

import Foundation

class CurrencyModel: ObservableObject {
  @Published var currencies: [String: Currency] = [
    "USD": .dollar,
  ]

  var listViewModel: ListModel!
  var convertViewModel: ConvertModel!

  init() {
    listViewModel = ListModel(from: self)
    convertViewModel = ConvertModel(from: self)
  }
}
