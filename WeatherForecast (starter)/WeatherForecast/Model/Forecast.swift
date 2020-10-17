//
//  Forecast.swift
//  WeatherForecast
//
//  Created by 성단빈 on 2020/10/16.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

struct Forecast: Decodable {
  let list: [Weather]
}
