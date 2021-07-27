//
//  CurrencyApp.swift
//  Shared
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

@main
struct CurrencyApp: App {
  var data: CurrencyData

  init() {
    data = CurrencyData()
    data.refreshNames()
  }

  var body: some Scene {
    WindowGroup {
      Group {
        #if os(macOS)
        macOSView()
        #else
        iOSView()
        #endif
      }
      .environmentObject(data)
    }
  }
}
