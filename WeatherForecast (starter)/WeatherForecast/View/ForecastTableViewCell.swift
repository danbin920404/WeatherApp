//
//  ForecastTableViewCell.swift
//  WeatherForecast
//
//  Created by 성단빈 on 2020/10/17.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "ForecastTableViewCell"
  private let dateLabel = UILabel()
  private let timeLabel = UILabel()
  private let weatherImageView = UIImageView()
  private let temperatureLabel = UILabel()
  private let weatherImageUnderLineView = UIView()
  
  // MARK: - View LifeCycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setUI()
    setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - SetUI
  private func setUI() {
    self.backgroundColor = .clear
    
    [
      self.dateLabel,
      self.timeLabel,
      self.weatherImageView,
      self.weatherImageUnderLineView,
      self.temperatureLabel
    ].forEach {
      self.addSubview($0)
    }
    
    self.dateLabel.font = .systemFont(ofSize: 16, weight: .regular)
    self.dateLabel.textColor = .white
    
    self.timeLabel.font = .systemFont(ofSize: 22, weight: .medium)
    self.timeLabel.textColor = .white
    
    self.weatherImageView.contentMode = .scaleAspectFit
    
    self.weatherImageUnderLineView.backgroundColor = .lightGray
    
    self.temperatureLabel.textColor = .white
    self.temperatureLabel.font = .monospacedDigitSystemFont(ofSize: 34, weight: .medium)
  }
  
  // MARK: - SetLayout
  private func setLayout() {
    self.dateLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(16)
      $0.leading.equalToSuperview().offset(10)
    }
    
    self.timeLabel.snp.makeConstraints {
      $0.top.equalTo(self.dateLabel.snp.bottom)
      $0.leading.equalToSuperview().offset(10)
    }
    
    self.weatherImageView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview()
      $0.width.height.equalTo(40)
    }
    
    self.weatherImageUnderLineView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.width.equalTo(self.weatherImageView.snp.width)
      $0.height.equalTo(2)
    }
    
    self.temperatureLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-10)
      $0.centerY.equalToSuperview()
    }
  }
  
  // MARK: Configure Cell
  func configure(
    date: String,
    time: String,
    imageName: String,
    temperature: String
    ) {
    self.dateLabel.text = date
    self.timeLabel.text = time
    self.weatherImageView.image = UIImage(named: imageName)
    self.temperatureLabel.text = temperature
  }
  
  // MARK: - Action Button
}

// MARK: - Extension


