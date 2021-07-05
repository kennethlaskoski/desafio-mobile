//
//  CurrencyLayer.swift
//  Currency
//
//  Created by Kenneth Laskoski on 05/07/21.
//

import Combine
import Foundation

struct ListResponse: Codable {
  let success: Bool
  let terms: String
  let privacy: String
  let currencies: [String: String]
}

class CurrencyLayer: ObservableObject {
  @Published private(set) var currencies: [Currency] = [
    Currency(code: "USD", name: "Dollar"),
    Currency(code: "BRL", name: "Real"),
    Currency(code: "GBP", name: "Pound"),
    Currency(code: "EUR", name: "Euro"),
  ]

  private static let apikey = "672e3cdb941c218df034c5b44112c19b"
  private static let baseURL = URL(string: "http://api.currencylayer.com")

  private var listCancellabe: AnyCancellable?

  init() {
    let endpoint = "list"
    let url = URL(string: "\(endpoint)?access_key=\(CurrencyLayer.apikey)", relativeTo: CurrencyLayer.baseURL)!

    let request = URLRequest(url: url)
    let publihser = URLSession.shared.dataTaskPublisher(for: request)

    listCancellabe = publihser
      .tryMap() { element -> Data in
        guard let httpResponse = element.response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
          throw URLError(.badServerResponse)
        }
        return element.data
      }
      .decode(type: ListResponse.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .sink(
        receiveCompletion: { print ("Received completion: \($0).") },
        receiveValue: { response in
          var newList: [Currency] = []
          for (key, value) in response.currencies {
            newList.append(Currency(code: key, name: value))
          }
          self.currencies = newList
        }
      )
  }
}
