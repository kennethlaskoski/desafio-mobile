//
//  ContentView.swift
//  Shared
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var model: CurrencyModel

  var body: some View {
    NavigationView {
      ConvertView(model: model.convertViewModel)
        .navigationTitle("Convert")
    }
    .navigationViewStyle(StackNavigationViewStyle())
    // set accent color to dollar green
    .accentColor(Color(.sRGB, red: 26.0 / 256.0, green: 101.0 / 256.0, blue: 42.0 / 256.0, opacity: 1.0))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(CurrencyModel())
  }
}
