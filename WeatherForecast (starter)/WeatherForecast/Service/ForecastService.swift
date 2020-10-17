//
//  ForecastService.swift
//  WeatherForecast
//
//  Created by 성단빈 on 2020/10/18.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

class ForecastService: ForecastServiceable {
  
  func fetchWeatherForecast<T>(
    endpoint: Endpoint,
    completionHandler: @escaping (Result<T, ServiceError>) -> Void
  ) where T: Decodable {
    guard let url = endpoint.combineURL() else { return completionHandler(.failure(.invalidURL)) }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard error == nil else { return completionHandler(.failure(.clientError(error!))) }
      guard let header = response as? HTTPURLResponse,
        (200..<300) ~= header.statusCode
        else { return completionHandler(.failure(.invalidStatusCode)) }
      guard let data = data else { return completionHandler(.failure(.noData)) }
      
      do {
        let weather = try JSONDecoder().decode(T.self, from: data)
        DispatchQueue.main.async {
          completionHandler(.success(weather))
        }
      } catch {
        completionHandler(.failure(.decodingError(error)))
      }
    }.resume()
  }
}
