//
//  CurrencyLayer.swift
//  Currency
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import Combine
import Foundation

struct CurrencyLayer {
  private static let urlComponents: URLComponents = {
    var components = URLComponents()
    components.scheme = "http"
    components.host = "api.currencylayer.com"
    components.queryItems = [URLQueryItem(name: "access_key", value: "672e3cdb941c218df034c5b44112c19b")]
    return components
  }()
}

extension CurrencyLayer {
  struct Endpoint {
    let url: URL

    init(name: String, queryItems: [URLQueryItem]? = nil) {
      var components = CurrencyLayer.urlComponents
      components.path = name.isEmpty ? "" : "/\(name)"
      if let newItems = queryItems {
        components.queryItems!.append(contentsOf: newItems)
      }
      url = components.url!
    }
  }
}

extension CurrencyLayer.Endpoint {
  static var list: Self {
    CurrencyLayer.Endpoint(name: "list")
  }
}

extension CurrencyLayer.Endpoint {
  static var live: Self {
    CurrencyLayer.Endpoint(name: "live")
  }
}

extension CurrencyLayer {
  struct SuccessData: Codable {
    let success: Bool
  }
}

extension CurrencyLayer {
  struct Error: Codable {
    let code: Int
    let info: String
  }

  struct ErrorData: Codable {
    let error: Error
  }
}

extension CurrencyLayer.Error: Error {}

extension CurrencyLayer {
  struct LegalData: Codable {
    let terms: String
    let privacy: String
  }
}

extension CurrencyLayer {
  typealias CurrencyData = [String : String]
  struct ListData: Codable {
    let success: Bool
    let terms: String
    let privacy: String
    let currencies: CurrencyData
  }
}

extension CurrencyLayer {
  typealias QuoteData = [String : String]
  struct LiveData: Codable {
    let timestamp: Int
    let source: String
    let quotes: QuoteData
  }
}

extension CurrencyLayer {
  static func listPublisher() -> AnyPublisher<CurrencyData, Swift.Error> {
    let publisher = URLSession.shared.dataTaskPublisher(for: Endpoint.list.url)
    return publisher
      .tryMap() { element -> Data in
        guard let httpResponse = element.response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
          throw URLError(.badServerResponse)
        }
        print(String(decoding: element.data, as: UTF8.self))
        return element.data
      }
      .decode(type: ListData.self, decoder: JSONDecoder())
      .tryMap() { element -> CurrencyData in
        return element.currencies
      }
      .eraseToAnyPublisher()
  }
}
