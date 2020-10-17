//
//  LoadView.swift
//  WeatherForecast
//
//  Created by 성단빈 on 2020/10/16.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit
import SnapKit

class WeatherCasterView: UIView {
  // MARK: - Properties
  private let backgroundImageView = UIImageView()
  let weatherCasterTopView = WeatherCasterTopView()
  let tableView = UITableView()
  private let blurView = UIVisualEffectView()
  
  // MARK: - View LifeCycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
    setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - SetUI
  private func setUI() {
    self.addSubview(self.backgroundImageView)
    self.addSubview(self.blurView)
    self.addSubview(self.weatherCasterTopView)
    self.addSubview(self.tableView)
    
    self.backgroundImageView.image = UIImage(named: "sunny")
    self.backgroundImageView.contentMode = .scaleAspectFill
    
    self.tableView.backgroundColor = .clear
    self.tableView.allowsSelection = false
    self.tableView.showsVerticalScrollIndicator = false
    
    self.blurView.effect = UIBlurEffect(style: .dark)
    self.blurView.alpha = 0
  }
  
  // MARK: - SetLayout
  private func setLayout() {
    self.backgroundImageView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
    
    self.weatherCasterTopView.snp.makeConstraints {
      $0.top.equalTo(super.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(self.weatherCasterTopView.reloadBtn.snp.height)
    }
    
    self.tableView.snp.makeConstraints {
      $0.top.equalTo(weatherCasterTopView.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
    
    self.blurView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  // MARK: - Action Button
}

// MARK: - Extension

extension WeatherCasterView {
  func updateBackgroundImage(imageName: String) {
    UIView.transition(
      with: self.backgroundImageView,
      duration: 1,
      options: [.transitionCrossDissolve]
    ) {
      self.backgroundImageView.image = UIImage(named: imageName)
    }
  }
  
  func updateBlurView(alpha: CGFloat) {
    self.blurView.alpha = alpha
  }
}
