//
//  ContentView.swift
//  Shared
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

struct ContentView: View {
  @StateObject var listModel = ListModel()
  @StateObject var convertModel = ConvertModel()

  var body: some View {
    VStack {
      NavigationView {
        ConvertView()
          .navigationTitle("Convert")
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environmentObject(listModel)
      .environmentObject(convertModel)
    }
    .accentColor(Color(.sRGB, red: 26.0 / 256.0, green: 101.0 / 256.0, blue: 42.0 / 256.0, opacity: 1.0))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
