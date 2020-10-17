//
//  ForecastServiceStub.swift
//  WeatherForecast
//
//  Created by 성단빈 on 2020/10/16.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

// 샘플 데이터를 이용한 디코딩 테스트용 클래스
final class ForecastServiceStub: ForecastServiceable {
  func fetchWeatherForecast<T>(
    endpoint: Endpoint,
    completionHandler: @escaping (Result<T, ServiceError>) -> Void
  ) where T: Decodable {
    let data: Data
    
    switch endpoint.path {
    case .weather:
      data = SampleData.currentWeather
    case .forecast:
      data = SampleData.forecast
    }
    do {
      let result = try JSONDecoder().decode(T.self, from: data)
      completionHandler(.success(result))
    } catch {
      completionHandler(.failure(.decodingError(error)))
    }
  }
}
