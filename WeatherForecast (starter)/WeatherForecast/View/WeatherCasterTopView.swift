//
//  LoadTopView.swift
//  WeatherForecast
//
//  Created by 성단빈 on 2020/10/16.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit
import SnapKit

class WeatherCasterTopView: UIView {
  // MARK: - Properties
  private let locationLabel = UILabel()
  private let dateLabel = UILabel()
  let reloadBtn = UIButton()
  
  // MARK: - View LifeCycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.setUI()
    self.setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - SetUI
  private func setUI() {
    [
      self.locationLabel,
      self.dateLabel,
      self.reloadBtn
    ].forEach {
      self.addSubview($0)
    }
    
    self.locationLabel.textColor = .white
    self.locationLabel.textAlignment = .center
    self.locationLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
    
    self.dateLabel.textColor = .white
    self.dateLabel.textAlignment = .center
    self.dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .black)
    
    self.reloadBtn.setTitle("↻", for: .normal)
    self.reloadBtn.setTitleColor(.white, for: .normal)
    self.reloadBtn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
  }
  
  // MARK: - SetLayout
  private func setLayout() {
    self.reloadBtn.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-20)
    }
    
    self.locationLabel.snp.makeConstraints {
      $0.top.centerX.equalToSuperview()
    }
    
    self.dateLabel.snp.makeConstraints {
      $0.top.equalTo(locationLabel.snp.bottom).offset(2)
      $0.centerX.equalToSuperview()
    }
  }
  
  // MARK: - Action Button
}

// MARK: - Extension

extension WeatherCasterTopView {
  func updateWeatherCasterTopView(location: String, date: String) {
    self.locationLabel.text = location
    self.dateLabel.text = date
    
    self.locationLabel.alpha = 0
    self.dateLabel.alpha = 0
    self.reloadBtn.alpha = 0
    UIView.animate(withDuration: 0.4) {
      self.locationLabel.alpha = 1
      self.dateLabel.alpha = 1
      self.reloadBtn.alpha = 1
    }
  }
  
  func spinAnimationReloadBtn() {
    let spinAnimation = CABasicAnimation(keyPath: "transform.rotation")
    spinAnimation.duration = 0.5
    spinAnimation.toValue = CGFloat.pi * 2
    self.reloadBtn.layer.add(spinAnimation, forKey: "spinAnimation")
  }
}

