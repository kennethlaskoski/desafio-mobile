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

      Spacer()

      Button {
        listModel.refreshList()
        convertModel.refreshQuotes()
      }
      label: {
        HStack {
          Text("Last refresh: \(convertModel.formattedLastRefresh)")
            .font(.subheadline)
          Spacer()
          Label("Refresh", systemImage: "arrow.triangle.2.circlepath")
            .font(.headline)
        }
        .padding(.vertical, 5.0)
        .padding(.horizontal)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
