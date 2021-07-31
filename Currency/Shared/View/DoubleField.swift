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
  let buttonTitle: LocalizedStringKey

  @State private var text = ""
  @State private var isEditing = false

  var body: some View {
    HStack {
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
          self.isEditing = isEditing
        }
      )
      .keyboardType(.decimalPad)
      .onAppear {
        text = formatter.string(
          from: NSNumber(value: value)
        ) ?? ""
      }

      Button {
        UIApplication.shared.sendAction(
          #selector(UIResponder.resignFirstResponder),
          to: nil, from: nil, for: nil
        )
      }
      label: {
        Text(buttonTitle)
          .padding(.vertical, 8.0)
          .padding(.horizontal, 6.0)
      }
    }
  }
}

struct DoubleFieldPreview: View {
  @State private var test = 1.0
  var body: some View {
    DoubleField(
      title: "Amount",
      value: $test,
      formatter: NumberFormatter(),
      buttonTitle: "Convert"
    )

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
