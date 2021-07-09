//
//  CurrencyConvertView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import SwiftUI

struct CurrencyConvertView: View {
  @StateObject var model = ViewModel()

  var body: some View {
    VStack(alignment: .leading) {
      Text("Convert")
        .font(.largeTitle)
        .bold()

      TextField(
        "Amount",
        value: $model.conversion.amount,
        formatter: ViewModel.formatter
      )

      QuoteView(
        from: model.conversion.from,
        to: model.conversion.to
      )
    }
    .textFieldStyle(RoundedBorderTextFieldStyle())
    .padding()
  }
}

struct QuoteView: View {
  var from: Currency
  var to: Currency

  var body: some View {
    VStack {
      CurrencyButton(
        currency: from
      )

      CurrencyButton(
        currency: to
      )
    }
  }
}

struct CurrencyButton: View {
  let currency: Currency

  var body: some View {
    VStack(alignment: .leading) {
      Button(
        action: {

        },

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
          .shadow(color: .secondary, radius: 5.0, x: 3.0, y: 5.0)
        }
      )
    }
  }
}

struct CurrencyConvertView_Previews: PreviewProvider {
  static var previews: some View {
    CurrencyConvertView()
  }
}
