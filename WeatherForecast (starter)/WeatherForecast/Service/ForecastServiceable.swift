//
//  ForecastServiceable.swift
//  WeatherForecast
//
//  Created by 성단빈 on 2020/10/16.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

protocol ForecastServiceable {
  func fetchWeatherForecast<T>(
    endpoint: Endpoint,
    completionHandler: @escaping (Result<T, ServiceError>) -> Void
  ) where T: Decodable
}
