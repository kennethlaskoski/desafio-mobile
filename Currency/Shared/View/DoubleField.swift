//
//  DoubleField.swift
//  Currency
//
//  Created by Kenneth Laskoski on 29/07/21.
//

import SwiftUI

struct DoubleField: View {
  let title: LocalizedStringKey
  @Binding var value: Double
  let formatter: NumberFormatter

  @State private var text = ""

  var body: some View {
    TextField(
      title,
      text: $text,
      onEditingChanged: { isEditing in
        if !isEditing {
          if let newValue = formatter.number(from: text) {
            value = newValue.doubleValue
            text = formatter.string(
              from: NSNumber(value: value)
            ) ?? ""
          } else {
            text = formatter.string(
              from: NSNumber(value: value)
            ) ?? ""
          }
        }
      }
    )
    .onAppear {
      text = formatter.string(
        from: NSNumber(value: value)
      ) ?? ""
    }
  }
}

struct DoubleFieldPreview: View {
  @State private var test = 1.0
  var body: some View {
    DoubleField(
      title: "Amount",
      value: $test,
      formatter: NumberFormatter()
    )

    Button {
      UIApplication.shared.sendAction(
        #selector(UIResponder.resignFirstResponder),
        to: nil, from: nil, for: nil)
    }
    label: {
      Text("=")
        .font(.system(size: 72.0))
        .padding(.horizontal, 27.0)
        .padding(.top, -18.0)
        .padding(.bottom, -6.0)
        .overlay(
          RoundedRectangle(cornerRadius:9.0)
            .stroke(lineWidth: 3.0)
        )
    }
    .padding(.vertical)

    Text("Value: \(test)")
  }
}

struct DoubleField_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      DoubleFieldPreview()
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
    }
  }
}
