//
//  CurrencyApp.swift
//  Shared
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

@main
struct CurrencyApp: App {
  var model: CurrencyModel

  init() {
    model = CurrencyModel()
    model.refreshNames()
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(model)
    }
  }
}
