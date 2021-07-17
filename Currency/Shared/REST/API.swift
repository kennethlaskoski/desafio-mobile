//
//  API.swift
//  Currency
//
//  Created by Kenneth Laskoski on 17/07/21.
//

import Foundation

protocol API {
  // An API is just a
  // internet address
  var components: URLComponents { get }

  // in its preferred
  // internet session
  var session: URLSession { get }
}

// We set the shared url session
// as our default implementation
extension API {
  var session: URLSession { URLSession.shared }
}
