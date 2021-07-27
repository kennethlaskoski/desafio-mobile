//
//  iOSView.swift
//  Currency
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import SwiftUI

struct iOSView: View {
  var body: some View {
    NavigationView {
      ConvertView()
        .navigationTitle("Convert")
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct iOSView_Previews: PreviewProvider {
  static var model: CurrencyData = {
    var model = CurrencyData()
    model.refreshNames()
    return model
  }()

  static var previews: some View {
    Group {
      iOSView()
        .preferredColorScheme(.light)
      iOSView()
        .preferredColorScheme(.dark)
    }
    .environmentObject(model)
  }
}
