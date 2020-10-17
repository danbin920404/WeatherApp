//
//  WeatherCasterTableViewCell.swift
//  WeatherForecast
//
//  Created by 성단빈 on 2020/10/17.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class CurrentWeatherTableViewCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "CurrentWeatherTableViewCell"
  private let weatherImageView = UIImageView()
  private let statusLabel = UILabel()
  private let tempMinMaxLabel = UILabel()
  private let currentTempLabel = UILabel()
  
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
      self.weatherImageView,
      self.statusLabel,
      self.tempMinMaxLabel,
      self.currentTempLabel
    ].forEach {
      self.addSubview($0)
    }
    
    self.weatherImageView.contentMode = .scaleAspectFit
    
    self.statusLabel.font = .systemFont(ofSize: 21, weight: .semibold)
    self.statusLabel.textColor = .white
    
    self.tempMinMaxLabel.font = .systemFont(ofSize: 20, weight: .bold)
    self.tempMinMaxLabel.textColor = .white
    
    self.currentTempLabel.font = .systemFont(ofSize: 90, weight: .semibold)
    self.currentTempLabel.textColor = .white
  }
  
  // MARK: - SetLayout
  private func setLayout() {
    self.currentTempLabel.snp.makeConstraints {
      $0.bottom.equalTo(super.safeAreaLayoutGuide.snp.bottom)
      $0.leading.equalToSuperview().offset(20)
    }

    self.tempMinMaxLabel.snp.makeConstraints {
      $0.bottom.equalTo(self.currentTempLabel.snp.top).offset(6)
      $0.leading.equalToSuperview().offset(20)
    }
    
    self.weatherImageView.snp.makeConstraints {
      $0.bottom.equalTo(tempMinMaxLabel.snp.top)
      $0.leading.equalToSuperview().offset(20)
      $0.height.width.equalTo(40)
    }
    
    self.statusLabel.snp.makeConstraints {
      $0.leading.equalTo(self.weatherImageView.snp.trailing).offset(2)
      $0.centerY.equalTo(self.weatherImageView.snp.centerY)
    }
  }
  
  // MARK: Configure Cell
  func configure(
    weatherImageName: String,
    weatherStatus: String,
    minTemp: String,
    maxTemp: String,
    currentTemp: String
  ) {
    self.weatherImageView.image = UIImage(named: weatherImageName)
    self.statusLabel.text = weatherStatus
    
    let kernAttr: [NSAttributedString.Key: Any] = [.kern: -1]
    let fontAttr: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 20, weight: .light)]
    let mergedAttrs = kernAttr.merging(fontAttr) { _, _ in }
    
    let mutableString = NSMutableAttributedString(string: "⤓", attributes: mergedAttrs)
    mutableString.append(NSAttributedString(string: minTemp, attributes: kernAttr))
    mutableString.append(NSAttributedString(string: "   "))
    mutableString.append(NSAttributedString(string: "⤒", attributes: mergedAttrs))
    mutableString.append(NSAttributedString(string: maxTemp, attributes: kernAttr))
    self.tempMinMaxLabel.attributedText = mutableString
    
    self.currentTempLabel.attributedText = NSAttributedString(
      string: currentTemp, attributes: [.kern: 0]
    )
  }
  
  // MARK: - Action Button
}

// MARK: - Extension


