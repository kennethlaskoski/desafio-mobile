//
//  CurrencyConvertView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import SwiftUI

struct CurrencyConvertView: View {
  @State var inValue = "1,00"

  var body: some View {
    VStack {
      HStack {
        CurrencyButton()
        TextField("Value", text: $inValue)
      }
      HStack {
        CurrencyButton()
        Text("1,00")
        Spacer()
      }
    }
  }
}

struct CurrencyButton: View {
  var body: some View {
    Button("USD") {}
      .padding()
  }
}

struct CurrencyConvertView_Previews: PreviewProvider {
  static var previews: some View {
    CurrencyConvertView()
  }
}
