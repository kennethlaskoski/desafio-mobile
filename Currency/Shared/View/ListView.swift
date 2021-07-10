//
//  ListView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

struct ListView: View {
  @EnvironmentObject var model: ListModel
  @Binding var selected: Currency

  var body: some View {
    VStack {
      List(model.currencies) { currency in
        let match = currency == selected
        Button {
          selected = currency
        }
        label: {
          HStack {
            CurrencyView(currency: currency)

            Spacer()

            Label("", systemImage: match ? "checkmark.circle.fill" : "circle")

          }
        }
      }
      .navigationTitle("Currencies")

      Button {
        model.refreshList()
      }
      label: {
        HStack {
          Text("Last refresh: \(model.lastRefresh)")
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

struct CurrencyListView_Previews: PreviewProvider {
  static var previews: some View {
    let currency = Currency(id: "!!!", name: "none")
    ListView(selected: .constant(currency))
      .environmentObject(ListModel())
  }
}
