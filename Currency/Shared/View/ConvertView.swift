//
//  ConvertView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import SwiftUI

struct ConvertView: View {
  @EnvironmentObject var model: CurrencyModel

  var body: some View {
    VStack {
      VStack {
        SourceView()
        ResultView()
      }
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .padding(.horizontal)
      .padding(.bottom)
      .padding()

      Spacer()

      Button {
        model.refreshQuotes()
      }
      label: {
        HStack {
          Text("Last refresh: \(model.formattedLastQuotesRefresh)")
            .font(.subheadline)
          Spacer()
          Label("Refresh", systemImage: "arrow.triangle.2.circlepath")
            .font(.headline)
        }
        .padding(.vertical, 5.0)
        .padding(.horizontal)
      }
    }
  }
}

struct SourceView: View {
  @EnvironmentObject var model: CurrencyModel

  var body: some View {
    VStack {
      TextField(
        "Amount",
        value: $model.convertModel.amount,
        formatter: model.formatter
      )
      .padding(.vertical)
      .allowsTightening(true)

      CurrencyButton(currency: $model.convertModel.sourceCurrency)

      Text("x \(model.formattedQuote) =")
        .font(.subheadline)
        .padding(.bottom)
    }
  }
}

struct ResultView: View {
  @EnvironmentObject var model: CurrencyModel

  var body: some View {
    VStack {
      Text(model.formattedResult)
        .font(.largeTitle)
        .padding(.bottom)

      CurrencyButton(currency: $model.convertModel.resultCurrency)
    }
  }
}

struct CurrencyButton: View {
  @EnvironmentObject var model: CurrencyModel
  @Binding var currency: Currency
  @State private var presentList = false

  var body: some View {
    VStack(alignment: .leading) {
      NavigationLink(
        destination: ListView(current: $currency),
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
  static var model = CurrencyModel()
  static var previews: some View {
    ConvertView()
      .environmentObject(model)
  }
}
