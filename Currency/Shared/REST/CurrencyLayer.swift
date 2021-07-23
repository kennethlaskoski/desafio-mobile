//
//  CurrencyLayer.swift
//  Currency
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import Combine
import Foundation
import EndpointPublisher

// MARK: - Common URL components
struct CurrencyLayer: API {
  let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
  let components: URLComponents = {
    var components = URLComponents()
    components.scheme = "http"
    components.host = "api.currencylayer.com"
    components.queryItems = [URLQueryItem(name: "access_key", value: "672e3cdb941c218df034c5b44112c19b")]
    return components
  }()
}

// MARK: - Endpoints
extension CurrencyLayer {
  // list endpoint
  var list: Endpoint<CurrencyLayer> {
    Endpoint<CurrencyLayer>("list", for: self)!
  }

  // live endpoint
  var live: Endpoint<CurrencyLayer> {
    Endpoint<CurrencyLayer>("live", for: self)!
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

extension Currency {
  typealias ListRepresentation = [String: String]
  typealias LiveRepresentation = [String: Double]
}

// list representation
extension CurrencyLayer {
  struct ListData: Codable {
    let currencies: Currency.ListRepresentation
  }
}

// live representation
extension CurrencyLayer {
  struct LiveData: Codable {
    let quotes: Currency.LiveRepresentation
  }
}

// MARK: - Publishers

// list publisher
extension CurrencyLayer {
  func listPublisher() -> AnyPublisher<Currency.ListRepresentation, Swift.Error> {
    return session.publisher(for: list)
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
  func livePublisher() -> AnyPublisher<Currency.LiveRepresentation, Swift.Error> {
    return session.publisher(for: live)
      .tryMap() { element -> Data in
        guard let httpResponse = element.response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
          throw URLError(.badServerResponse)
        }
        print(String(decoding: element.data, as: UTF8.self))
        return element.data
      }
      .decode(type: LiveData.self, decoder: JSONDecoder())
      .tryMap() { liveData -> Currency.LiveRepresentation in
        return liveData.quotes
      }
      .eraseToAnyPublisher()
  }
}
