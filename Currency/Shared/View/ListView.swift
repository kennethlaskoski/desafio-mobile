//
//  ListView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

struct ListView: View {
  @EnvironmentObject var model: ListModel

  var body: some View {
    VStack {
      List(model.currencies) { currency in
        CurrencyView(currency: currency)
      }

      Button(
        action: {
          model.refreshList()
        },
        label: {
          Text("Last retrieved on: \(model.lastRefresh)")
        }
      )
    }
  }
}

struct CurrencyView: View {
  let currency: Currency

  var body: some View {
    HStack {
      Text(currency.id)
        .font(.system(.body, design: .monospaced))
        .padding(.trailing, 5.0)

      Text(currency.name)
    }
  }
}

struct CurrencyListView_Previews: PreviewProvider {
  static var previews: some View {
    ListView()
      .environmentObject(ListModel())
  }
}
