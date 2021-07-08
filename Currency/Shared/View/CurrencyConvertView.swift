//
//  CurrencyConvertView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import SwiftUI

struct CurrencyConvertView: View {
  @StateObject var conversion = CurrencyConversion(
    quote: CurrencyQuote(
      from: Currency(code: "USD", name: "US Dollar"),
      to: Currency(code: "BRL", name: "Brazilian Real")
    )
  )

  var body: some View {
    VStack(alignment: .leading) {
      Text("Convert")
        .font(.largeTitle)
        .bold()

      TextField(
        "Amount",
        value: $conversion.amount,
        formatter: Currency.formatter
      )

      CurrencyQuoteView(quote: conversion.quote)
    }
    .textFieldStyle(RoundedBorderTextFieldStyle())
    .padding()
  }
}

struct CurrencyQuoteView: View {
  var quote: CurrencyQuote

  var body: some View {
    VStack {
      CurrencyButton(
        currency: quote.from
      )

      CurrencyButton(
        currency: quote.to
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
