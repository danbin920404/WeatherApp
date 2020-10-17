//
//  LoadView.swift
//  WeatherForecast
//
//  Created by 성단빈 on 2020/10/16.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit
import CoreLocation
import SnapKit

final class WeatherCasterViewController: UIViewController {
  // MARK: - Properties
  var forecastService: ForecastServiceable!
  private let cityName = "서울"
  private var currentWeather: Weather? {
    didSet { self.weatherCasterView.tableView.reloadData() }
  }
  private var forecastList: [Weather]? {
    didSet { self.weatherCasterView.tableView.reloadData() }
  }
  private let weatherCasterView = WeatherCasterView()
  private var changeBackgroundImageCount = 0
  
  // MARK: - View LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.geocodeAddressString(city: cityName)
    self.weatherCasterView.weatherCasterTopView.updateWeatherCasterTopView(location: self.cityName, date: self.makeNowDate())
    self.setUI()
    self.setLayout()
  }
  
  //MARK: - StatusBarHidden
  override var prefersStatusBarHidden: Bool { true }
  
  // MARK: - SetUI
  private func setUI() {
    self.view.addSubview(self.weatherCasterView)
    
    self.weatherCasterView.weatherCasterTopView.reloadBtn.addTarget(self, action: #selector(self.reloadDidTapBtn), for: .touchUpInside)
    
    self.weatherCasterView.tableView.register(
      CurrentWeatherTableViewCell.self,
      forCellReuseIdentifier: CurrentWeatherTableViewCell.identifier
    )
    
    self.weatherCasterView.tableView.register(
      ForecastTableViewCell.self,
      forCellReuseIdentifier: ForecastTableViewCell.identifier
    )
    
    self.weatherCasterView.tableView.dataSource = self
    self.weatherCasterView.tableView.delegate = self
  }
  
  // MARK: - SetLayout
  private func setLayout() {
    self.weatherCasterView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  // MARK: - Set Func
  private func geocodeAddressString(city: String) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(city) { (placemarks, error) in
      guard error == nil else { return print(error!.localizedDescription) }
      guard let location = placemarks?.first?.location else { return print("데이터가 없습니다.")}
      self.didReceiveLocation(location)
    }
  }
  
  private func didReceiveLocation(_ location: CLLocation) {
    let latitude = location.coordinate.latitude
    let longitude = location.coordinate.longitude
    
    self.fetchCurrentWeather(lat: latitude, lon: longitude)
    self.fetchForecast(lat: latitude, lon: longitude)
  }
  
  private func fetchCurrentWeather(lat: Double, lon: Double) {
    let endpoint = Endpoint(
      path: .weather,
      query: [.lat: "\(lat)", .lon: "\(lon)", .units: "metric", .lang: "kr"]
    )
    
    self.forecastService.fetchWeatherForecast(endpoint: endpoint) {
      (result: Result<Weather, ServiceError>) in
      switch result {
      case .success(let value): self.currentWeather = value
      case .failure(let error): print("현재 날씨 가져오기 실패. \(error)")
      }
    }
  }
  
  private func fetchForecast(lat: Double, lon: Double) {
    let endpoint = Endpoint(
      path: .forecast,
      query: [.lat: "\(lat)", .lon: "\(lon)", .units: "metric", .cnt: "24", .lang: "kr"]
    )
    forecastService.fetchWeatherForecast(endpoint: endpoint) {
      [weak self] (result: Result<Forecast, ServiceError>) in
      switch result {
      case .success(let value): self?.forecastList = value.list
      case .failure(let error): print("기상 예보 가져오기 실패. \(error)")
      }
    }
  }
  
  private func makeNowDate() -> String {
    let now = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko")
    dateFormatter.dateFormat = "a H:mm"
    
    return dateFormatter.string(from: now)
  }
  
  private func makeForcastDay() -> String {
    let now = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "M.d (E)"
    
    return dateFormatter.string(from: now)
  }
  
  private func makeForcastDate() -> String {
    let now = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    
    return dateFormatter.string(from: now)
  }
  
  private func changeBackgroundImage() -> String {
    let imageNames = [
      "sunny",
      "lightning",
      "cloudy",
      "rainy"
    ]
    self.changeBackgroundImageCount += 1
    
    return imageNames[self.changeBackgroundImageCount % imageNames.count]
  }
  
  // MARK: - Action Button
  @objc private func reloadDidTapBtn(_ sender: UIButton) {
    self.weatherCasterView.weatherCasterTopView.updateWeatherCasterTopView(location: self.cityName, date: self.makeNowDate())
    
    self.weatherCasterView.updateBackgroundImage(imageName: self.changeBackgroundImage())
    
    self.weatherCasterView.weatherCasterTopView.spinAnimationReloadBtn()
  }
  
  
}

// MARK: - TableViewDataSource Extension
extension WeatherCasterViewController: UITableViewDataSource {
  private enum Section: Int, CaseIterable {
    case currentWeather
    case forecast
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return Section.allCases.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if Section.currentWeather.rawValue == section {
      
      return currentWeather == nil ? 0 : 1
    } else {
      
      return forecastList?.count ?? 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if Section.currentWeather.rawValue == indexPath.section {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: CurrentWeatherTableViewCell.identifier,
        for: indexPath
      ) as! CurrentWeatherTableViewCell
      
      guard let current = currentWeather, let sky = current.sky.first else { return cell }
      
      let minTemp = limitFraction(of: current.main.temp_min, maximum: 1)
      let maxTemp = limitFraction(of: current.main.temp_max, maximum: 1)
      let temp = limitFraction(of: current.main.temp, maximum: 1)
      cell.configure(
        weatherImageName: sky.icon,
        weatherStatus: sky.description,
        minTemp: minTemp,
        maxTemp: maxTemp,
        currentTemp: temp
      )
      
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: ForecastTableViewCell.identifier, for: indexPath
      ) as! ForecastTableViewCell
      
      guard let forecast = forecastList?[indexPath.row], let sky = forecast.sky.first else { return cell }
      
      let temp = limitFraction(of: forecast.main.temp, maximum: 0)
      cell.configure(date: makeForcastDay(), time: makeForcastDate(), imageName: sky.icon, temperature: temp)
      
      return cell
    }
  }
  
  private func limitFraction(of temperature: Double, maximum: Int) -> String {
    return String(format: "%.\(maximum)f°", temperature)
  }
}


// MARK: - UITableViewDelegate Extension
extension WeatherCasterViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if Section.currentWeather.rawValue == indexPath.section {
      guard let safeAreaInsetsTopHeight = self.view.window?.safeAreaInsets.top,
            let deviceHeight = self.view.window?.frame.height else { return 0 }
      let topViewHeight = weatherCasterView.weatherCasterTopView.frame.size.height
      
      return deviceHeight - topViewHeight - safeAreaInsetsTopHeight
    } else {
      
      return 80
    }
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let alpha = scrollView.contentOffset.y * 0.001
    
    if alpha > 0 || alpha < 0.8 {
      self.weatherCasterView.updateBlurView(alpha: alpha)
    }
  }
}
