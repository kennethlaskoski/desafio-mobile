//
//  CurrencyNameView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 10/07/21.
//

import SwiftUI

struct CurrencyNameView: View {
  let currency: Currency

  var body: some View {
    HStack(spacing: 13.0) {
      Text(currency.id)
        .font(.system(.callout, design: .monospaced))

      Text(currency.name)
        .font(.callout)
        .lineLimit(1)
        .truncationMode(.middle)
        .allowsTightening(true)
    }
  }
}

struct CurrencyView_Previews: PreviewProvider {
  static var previews: some View {
    CurrencyNameView(currency: .dollar)
  }
}
