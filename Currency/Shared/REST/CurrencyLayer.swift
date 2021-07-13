//
//  CurrencyLayer.swift
//  Currency
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import Combine
import Foundation

// MARK: - Common URL components
struct CurrencyLayer {
  private static let session = URLSession.shared
  private static let urlComponents: URLComponents = {
    var components = URLComponents()
    components.scheme = "http"
    components.host = "api.currencylayer.com"
    components.queryItems = [URLQueryItem(name: "access_key", value: "672e3cdb941c218df034c5b44112c19b")]
    return components
  }()
}

// MARK: - Endpoints
extension CurrencyLayer {
  struct Endpoint {
    let url: URL
    let session: URLSession?

    init(_ name: String, queryItems: [URLQueryItem]? = nil, on session: URLSession? = nil) {
      var components = CurrencyLayer.urlComponents
      components.path = name.isEmpty ? "" : "/\(name)"
      if let newItems = queryItems {
        components.queryItems!.append(contentsOf: newItems)
      }

      url = components.url!
      self.session = session
    }
  }
}

// list endpoint
extension CurrencyLayer.Endpoint {
  static let listSession = URLSession(
    configuration: URLSessionConfiguration.ephemeral
  )

  static var list: Self {
    return CurrencyLayer.Endpoint("list", on: listSession)
  }
}

// live endpoint
extension CurrencyLayer.Endpoint {
  static var live: Self {
    CurrencyLayer.Endpoint("live")
  }
}

// MARK: - Data representation

// error representation
extension CurrencyLayer {
  struct Error: Codable {
    let code: Int
    let info: String
  }

  struct ErrorData: Codable {
    let success: Bool
    let error: Error
  }
}

extension CurrencyLayer.Error: Error {}

// currency list representation
extension Currency {
  typealias ListRepresentation = [ID: String]
}

extension CurrencyLayer {
  struct ListData: Codable {
    let success: Bool
    let terms: String
    let privacy: String
    let currencies: Currency.ListRepresentation
  }
}

// quote list representation
extension Quote {
  typealias ListRepresentation = [ID: Double]
}

extension CurrencyLayer {
  struct LiveData: Codable {
    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: Int
    let source: String
    let quotes: Quote.ListRepresentation
  }
}

// MARK: - Publishers

// list publisher
extension CurrencyLayer {
  static func listPublisher() -> AnyPublisher<Currency.ListRepresentation, Swift.Error> {
    let endpoint = Endpoint.list
    let session  = endpoint.session ?? CurrencyLayer.session
    return session.dataTaskPublisher(for: endpoint.url)
      .tryMap() { element -> Data in
        guard let httpResponse = element.response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
          throw URLError(.badServerResponse)
        }
        print(String(decoding: element.data, as: UTF8.self))
        return element.data
      }
      .decode(type: ListData.self, decoder: JSONDecoder())
      .tryMap() { listData -> Currency.ListRepresentation in
        return listData.currencies
      }
      .eraseToAnyPublisher()
  }
}

// live publisher
extension CurrencyLayer {
  static func livePublisher() -> AnyPublisher<Quote.ListRepresentation, Swift.Error> {
    let endpoint = Endpoint.live
    let session  = endpoint.session ?? CurrencyLayer.session
    return session.dataTaskPublisher(for: endpoint.url)
      .tryMap() { element -> Data in
        guard let httpResponse = element.response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
          throw URLError(.badServerResponse)
        }
        print(String(decoding: element.data, as: UTF8.self))
        return element.data
      }
      .decode(type: LiveData.self, decoder: JSONDecoder())
      .tryMap() { listData -> Quote.ListRepresentation in
        return listData.quotes
      }
      .eraseToAnyPublisher()
  }
}
