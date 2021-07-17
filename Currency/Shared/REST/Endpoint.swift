//
//  Endpoint.swift
//  Currency
//
//  Created by Kenneth Laskoski on 17/07/21.
//

import Foundation

struct Endpoint<Base: API> {
  let base: Base
  let path: String
  let queryItems: [URLQueryItem]?

  init(_ path: String, for base: Base, queryItems: [URLQueryItem]? = nil) {
    self.base = base
    self.path = path
    self.queryItems = queryItems
  }

  var url: URL {
    var components = base.components
    components.path = path.isEmpty ? "" : "/\(path)"
    if let thisItems = queryItems {
      if var baseItems = components.queryItems {
        baseItems.append(contentsOf: thisItems)
      } else {
        components.queryItems = thisItems
      }
    }
    return components.url!
  }
}
