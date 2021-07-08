//
//  Currency.swift
//  Currency
//
//  Created by Kenneth Laskoski on 08/07/21.
//

import Foundation

struct Currency: Codable {
  let code: String
  let name: String
}

extension Currency: Identifiable {
  var id: String { code }
}

extension Currency {
  static var formatter: NumberFormatter = {
    var formatter = NumberFormatter()
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }()
}
