//
//  Currency.swift
//  Currency
//
//  Created by Kenneth Laskoski on 08/07/21.
//

// MARK: Currency model
struct Currency: Identifiable, Equatable {
  typealias Representation = (id: ID, name: String)

  private(set) var data: Representation

  var id: String { data.id }
  var name: String { data.name }

  init(with data: Representation) {
    self.data = data
  }

  init(id: ID, name: String) {
    self.init(with: (id, name))
  }

  static func == (lhs: Currency, rhs: Currency) -> Bool {
    lhs.data == rhs.data
  }
}

// MARK: Currency list model
extension Currency {
  typealias ListRepresentation = [ID : String]

  private(set) static var list: ListRepresentation = [:]

  init?(with id: ID) {
    guard let name = Currency.list[id] else {
      return nil
    }
    self.init(with: (id, name))
  }

  static func resetList(with data: ListRepresentation) {
    list = data
  }
}
