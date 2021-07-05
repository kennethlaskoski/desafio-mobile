//
//  CurrencyListView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

struct CurrencyListView: View {
  @StateObject var currencyLayer = CurrencyLayer()

  var body: some View {
    List(currencyLayer.currencies) { currency in
      Text(currency.code)
        .padding(.trailing)
      Text(currency.name)
      Spacer()
    }
  }
}

struct CurrencyListView_Previews: PreviewProvider {
  static var previews: some View {
    CurrencyListView()
  }
}
