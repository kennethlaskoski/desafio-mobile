//
//  Currency.swift
//  Currency
//
//  Created by Kenneth Laskoski on 08/07/21.
//

import Foundation

struct Currency: Identifiable, Equatable {
  typealias ID = String

  let id: ID
  let name: String
}
