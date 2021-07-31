//
//  ConvertView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 07/07/21.
//

import SwiftUI

struct ConvertView: View {
  @EnvironmentObject var currencyModel: CurrencyData
  @State private var convertModel = ConvertModel()

  var body: some View {
    VStack {
      VStack {
        SourceView(convertModel: $convertModel)
        ResultView(convertModel: $convertModel)
      }
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .padding(.horizontal)
      .padding(.bottom)
      .padding()

      Spacer()

      Button {
        currencyModel.refresh()
      }
      label: {
        HStack {
          Text("Last refresh: \(currencyModel.formattedLastRefresh)")
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
  @EnvironmentObject var currencyModel: CurrencyData
  @Binding var convertModel: ConvertModel

  var body: some View {
    VStack {
      HStack {
        DoubleField(
          title: "Amount",
          value: $convertModel.amount,
          formatter: convertModel.formatter,
          buttonTitle: "Convert"
        )
      }
      .padding(.vertical)

      CurrencyButton(currency: $convertModel.sourceCurrency)

      Text("x \(convertModel.formattedQuote) =")
        .font(.subheadline)
        .padding(.bottom)
    }
  }
}

struct ResultView: View {
  @EnvironmentObject var currencyModel: CurrencyData
  @Binding var convertModel: ConvertModel

  var body: some View {
    VStack {
      Text(convertModel.formattedResult)
        .font(.largeTitle)
        .padding(.bottom)
        .allowsTightening(true)

      CurrencyButton(currency: $convertModel.resultCurrency)
    }
  }
}

struct CurrencyButton: View {
  @EnvironmentObject var currencyModel: CurrencyData
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
          CurrencyNameView(currency: currency)
          Spacer()
        }
        .padding(.vertical, 5.0)
        .padding(.leading, 8.0)
        .foregroundColor(.white)
        .background(Color.accentColor)
        .cornerRadius(5.0, antialiased: true)
      }
    }
  }
}

struct ConvertView_Previews: PreviewProvider {
  static var model = CurrencyData()
  static var previews: some View {
    ConvertView()
      .environmentObject(model)
  }
}
