//
//  ConvertView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import SwiftUI

struct ConvertView: View {
  @EnvironmentObject var model: ConvertModel

  var body: some View {
    VStack(alignment: .leading) {
      TextField(
        "Amount",
        value: $model.amount,
        formatter: model.formatter
      )

      QuoteView(
        from: $model.from,
        to: $model.to
      )
    }
    .textFieldStyle(RoundedBorderTextFieldStyle())
    .padding()
  }
}

struct QuoteView: View {
  @Binding var from: Currency
  @Binding var to: Currency

  var body: some View {
    VStack {
      CurrencyButton(currency: $from)
      CurrencyButton(currency: $to)
    }
  }
}

struct CurrencyButton: View {
  @Binding var currency: Currency

  var body: some View {
    VStack(alignment: .leading) {
      NavigationLink(
        destination: ListView(selected: $currency),
        label: {
          HStack {
            CurrencyView(currency: currency)
              .foregroundColor(.white)
              .padding(.vertical, 5.0)
              .padding(.leading, 8.0)
            Spacer()
          }
          .background(Color.accentColor)
          .cornerRadius(5.0, antialiased: true)
        }
      )
    }
  }
}

struct CurrencyConvertView_Previews: PreviewProvider {
  static var previews: some View {
    let model = ConvertModel()
    ConvertView()
    .environmentObject(model)
  }
}
