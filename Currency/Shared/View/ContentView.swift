//
//  ContentView.swift
//  Shared
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
    CurrencyConvertView()
    CurrencyListView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
