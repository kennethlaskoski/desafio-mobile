//
//  CurrencyApp.swift
//  Shared
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

@main
struct CurrencyApp: App {
  @StateObject var listModel = ListModel()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(listModel)
    }
  }
}
