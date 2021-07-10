//
//  Currency.swift
//  Currency
//
//  Created by Kenneth Laskoski on 08/07/21.
//

// MARK: Currency model
struct Currency: Identifiable, Equatable {
  typealias ListRepresentation = [ID : String]

  let id: String
  let name: String

  init(id: ID, name: String) {
    self.id = id
    self.name = name
  }
}
