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
      ConvertView()
        .navigationTitle("Convert")
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
      ContentView()
        .preferredColorScheme(.dark)
    }
    .environmentObject(CurrencyModel())
  }
}
