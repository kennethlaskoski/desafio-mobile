//
//  ListView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

struct ListView: View {
  @EnvironmentObject var model: ListModel
  @Binding var selected: Quote

  var body: some View {
    VStack {
      List(model.currencies) { quote in
        let match = quote == selected
        Button {
          selected = quote
        }
        label: {
          HStack {
            CurrencyView(currency: quote.currency)

            Spacer()

            Label("", systemImage: match ? "checkmark.circle.fill" : "circle")
              .labelStyle(IconOnlyLabelStyle())
          }
        }
      }
      .navigationTitle("Currencies")
    }
  }
}

struct CurrencyListView_Previews: PreviewProvider {
  static var previews: some View {
    ListView(selected: .constant(.dollar))
      .environmentObject(ListModel())
  }
}
