//
//  CurrencyListView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

struct CurrencyListView: View {
  var body: some View {
    List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
      Text("TLC")
        .padding(.trailing)
      Text("Currency name")
      Spacer()
    }
  }
}

struct CurrencyListView_Previews: PreviewProvider {
  static var previews: some View {
    CurrencyListView()
  }
}
