//
//  CurrencyConvertView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import SwiftUI

struct CurrencyConvertView: View {
  @Binding var presentList: Bool
  @EnvironmentObject var model: ViewModel

  var body: some View {
    VStack(alignment: .leading) {
      Text("Convert")
        .font(.largeTitle)
        .bold()

      TextField(
        "Amount",
        value: $model.conversion.amount,
        formatter: ViewModel.numberFormatter
      )

      QuoteView(
        presentList: $presentList,
        from: model.conversion.from,
        to: model.conversion.to
      )
    }
    .textFieldStyle(RoundedBorderTextFieldStyle())
    .padding()
  }
}

struct QuoteView: View {
  @Binding var presentList: Bool
  var from: Currency
  var to: Currency

  var body: some View {
    VStack {
      CurrencyButton(
        presentList: $presentList,
        currency: from
      )

      CurrencyButton(
        presentList: $presentList,
        currency: to
      )
    }
  }
}

struct CurrencyButton: View {
  @Binding var presentList: Bool
  let currency: Currency

  var body: some View {
    VStack(alignment: .leading) {
      Button(
        action: {
          presentList.toggle()
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
    let model = ViewModel()
    CurrencyConvertView(
      presentList: .constant(false)
    )
    .environmentObject(model)
  }
}
