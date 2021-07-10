//
//  ContentView.swift
//  Shared
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

struct ContentView: View {
  @StateObject var model: ViewModel = ViewModel()

  @StateObject var listModel = ListModel()
  @State private var listPresented = false

  var body: some View {
    CurrencyConvertView(presentList: $listPresented)

      .fullScreenCover(
        isPresented: $listPresented,
        content: {
          ListView()
            .environmentObject(listModel)
        }
      )
      .environmentObject(model)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
