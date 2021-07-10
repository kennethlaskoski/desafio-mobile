//
//  ConvertView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import SwiftUI

struct ConvertView: View {
  var body: some View {
    VStack {
      SourceView()
      QuoteView()
      ResultView()
    }
    .textFieldStyle(RoundedBorderTextFieldStyle())
    .padding()
  }
}

struct SourceView: View {
  @EnvironmentObject var model: ConvertModel

  var body: some View {
    VStack {
      TextField(
        "Amount",
        value: $model.sourceAmount,
        formatter: model.formatter
      )

      CurrencyButton(currency: $model.sourceCurrency)
    }
  }
}

struct QuoteView: View {
  @EnvironmentObject var model: ConvertModel

  var body: some View {
    VStack {
      Text("X")
      Text(model.formattedQuoteAmount)
      CurrencyButton(currency: $model.quoteCurrency)
    }
  }
}

struct ResultView: View {
  @EnvironmentObject var model: ConvertModel

  var body: some View {
    VStack {
      Text("=")
      Text(model.formattedResult)
    }
  }
}

struct CurrencyButton: View {
  @Binding var currency: Currency
  @State private var presentList = false

  var body: some View {
    VStack(alignment: .leading) {
      NavigationLink(
        destination: ListView(selected: $currency),
        isActive: $presentList
      ) { EmptyView() }

      Button {
        presentList = true
      }
      label: {
        HStack {
          CurrencyView(currency: currency)
          Spacer()
        }
        .foregroundColor(.white)
        .padding(.vertical, 5.0)
        .padding(.leading, 8.0)
        .background(Color.accentColor)
        .cornerRadius(5.0, antialiased: true)
      }
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
