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
        value: $model.source.value,
        formatter: model.formatter
      )

      CurrencyButton(unit: $model.sourceUnit)
    }
  }
}

struct QuoteView: View {
  @EnvironmentObject var model: ConvertModel

  var body: some View {
    VStack {
      Text("X")
      Text(model.formattedQuote)
      CurrencyButton(unit: $model.quote)
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
  @Binding var unit: Money
  @State private var presentList = false

  var body: some View {
    VStack(alignment: .leading) {
      NavigationLink(
        destination: ListView(selected: $unit),
        isActive: $presentList
      ) { EmptyView() }

      Button {
        presentList = true
      }
      label: {
        HStack {
          CurrencyView(currency: unit.currency)
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
