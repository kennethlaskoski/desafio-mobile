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
    NavigationView {
      ConvertView()
        .navigationTitle("Convert")
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .environmentObject(listModel)
    .environmentObject(convertModel)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
