//
//  ServiceError.swift
//  WeatherForecast
//
//  Created by 성단빈 on 2020/10/16.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

enum ServiceError: Error {
  case invalidURL
  case clientError(Error)
  case invalidStatusCode
  case noData
  case decodingError(Error)
}
