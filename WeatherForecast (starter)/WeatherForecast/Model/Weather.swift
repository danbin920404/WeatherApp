//
//  Weather.swift
//  WeatherForecast
//
//  Created by 성단빈 on 2020/10/16.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

struct Weather {
  let main: Main
  let sky: [Sky]
  let date: Date
  
  struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
  }

  struct Sky: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
  }
}


// MARK: - Decodable

extension Weather: Decodable {
  private enum CodingKeys: String, CodingKey {
    case weather, main, dt
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    sky = try container.decode([Sky].self, forKey: .weather)
    main = try container.decode(Main.self, forKey: .main)
    let timestamp = try container.decode(TimeInterval.self, forKey: .dt)
    date = Date(timeIntervalSince1970: timestamp)
  }
}
