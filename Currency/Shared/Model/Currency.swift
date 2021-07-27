//
//  Currency.swift
//  Currency
//
//  Created by Kenneth Laskoski on 16/07/21.
//

import Foundation

protocol Asset: Identifiable, Equatable {
  var id: String { get }
  var name: String { get }
}

struct Currency: Asset {
  let id: String
}
