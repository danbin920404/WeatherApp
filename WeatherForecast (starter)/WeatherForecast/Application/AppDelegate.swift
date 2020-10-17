//
//
//  LoadView.swift
//  WeatherForecast
//
//  Created by 성단빈 on 2020/10/16.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    let rootViewController = WeatherCasterViewController()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .systemBackground
    rootViewController.forecastService = ForecastService()
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()
    
    return true
  }
}
