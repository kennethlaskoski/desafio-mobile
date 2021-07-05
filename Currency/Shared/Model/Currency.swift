//
//  Currency.swift
//  Currency
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import Foundation

struct Currency: Codable {
  let code: String
  let name: String
}

extension Currency: Identifiable {
  var id: String { code }
}
