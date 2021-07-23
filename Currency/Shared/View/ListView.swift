//
//  ListView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

struct ListView: View {
  @EnvironmentObject var model: CurrencyModel
  @Binding var current: Currency

  var body: some View {
    VStack {
      List(model.currencies) { currency in
        Button {
          current = currency
        }
        label: {
          HStack {
            CurrencyView(currency: currency)

            Spacer()

            Label("", systemImage: currency == current ? "checkmark.circle.fill" : "circle")
              .labelStyle(IconOnlyLabelStyle())
          }
        }
      }
      .navigationTitle("Currencies")
    }
  }
}

struct CurrencyListView_Previews: PreviewProvider {
  @State static var current: Currency = .dollar
  static var previews: some View {
    ListView(current: $current)
    .environmentObject(CurrencyModel())
  }
}
