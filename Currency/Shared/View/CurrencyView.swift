//
//  CurrencyView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 10/07/21.
//

import SwiftUI

struct CurrencyView: View {
  let currency: Currency

  var body: some View {
    HStack {
      Text(currency.id)
        .font(.system(.body, design: .monospaced))
        .padding(.trailing, 5.0)

      Text(currency.name)
    }
  }
}

struct CurrencyView_Previews: PreviewProvider {
  static var previews: some View {
    let currency = Currency(id: "!!!", name: "none")
    CurrencyView(currency: currency)
  }
}
