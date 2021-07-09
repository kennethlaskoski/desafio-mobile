//
//  CurrencyListView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

struct CurrencyListView: View {
  @StateObject var model = ViewModel()

  var body: some View {
    VStack {
      List(model.currencies) { currency in
        CurrencyView(currency: currency)
      }
    }
  }
}

struct CurrencyView: View {
  let currency: Currency

  var body: some View {
    HStack {
      Text(currency.code)
        .font(.system(.body, design: .monospaced))
        .padding(.trailing, 5.0)

      Text(currency.name)
    }
  }
}

struct CurrencyListView_Previews: PreviewProvider {
  static var previews: some View {
    CurrencyListView()
  }
}
