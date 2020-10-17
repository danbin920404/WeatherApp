//
//  Endpoint.swift
//  WeatherForecast
//
//  Created by 성단빈 on 2020/10/16.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

struct Endpoint {
  static let defaultAppID = "eb200cd80d5c2c335f015004011c13ec"

  let baseURL = "https://api.openweathermap.org"
  let apiVersion = "/data/2.5/"
  let path: Path
  let query: QueryItems
  let appID: String

  init(path: Path, query: QueryItems, appID: String = Endpoint.defaultAppID) {
    self.path = path
    self.query = query
    self.appID = appID
  }

  func combineURL() -> URL? {
    guard var components = URLComponents(string: baseURL) else { fatalError() }
    components.path = apiVersion + path.rawValue
    components.queryItems = query.map {
      URLQueryItem(name: $0.rawValue, value: $1)
    }
    components.queryItems?.append(.init(name: "appid", value: appID))
    return components.url
  }
}


extension Endpoint {
  enum Path: String {
    case weather
    case forecast
  }
  enum QueryKey: String {
    case lat, lon, units, cnt, lang
  }
  typealias QueryItems = [QueryKey: String]
}
