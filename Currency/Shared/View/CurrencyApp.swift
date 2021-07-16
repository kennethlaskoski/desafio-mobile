//
//  CurrencyApp.swift
//  Shared
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

@main
struct CurrencyApp: App {
  @StateObject var model = CurrencyModel()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(model)
    }
  }
}
