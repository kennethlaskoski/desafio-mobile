//
//  ListView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

struct ListView: View {
  @ObservedObject var model: ListModel
  @Binding var current: Currency

  var body: some View {
    VStack {
      List(model.currencies) { currency in
        Button {
          current = currency
        }
        label: {
          HStack {
            CurrencyView(currency: .constant(currency))

            Spacer()

            Label("", systemImage: currency == current ? "checkmark.circle.fill" : "circle")
              .labelStyle(IconOnlyLabelStyle())
          }
        }
      }
      .navigationTitle("Currencies")

      Spacer()

      Button {
        model.refreshList()
      }
      label: {
        HStack {
          Text("Last refresh: \(model.formattedLastRefresh)")
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
  @State static var current: Currency = .dollar
  static var previews: some View {
    ListView(
      model: CurrencyModel().listViewModel,
      current: $current
    )
    .environmentObject(CurrencyModel().listViewModel)
  }
}
