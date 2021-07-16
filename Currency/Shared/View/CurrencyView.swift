//
//  CurrencyView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 10/07/21.
//

import SwiftUI

struct CurrencyView: View {
  @Binding var currency: Currency

  var body: some View {
    HStack(spacing: 13.0) {
      Text(currency.id)
        .font(.system(.callout, design: .monospaced))

      Text(currency.name)
        .font(.callout)
    }
  }
}

struct CurrencyView_Previews: PreviewProvider {
  static var previews: some View {
    CurrencyView(currency: .constant(.dollar))
  }
}
