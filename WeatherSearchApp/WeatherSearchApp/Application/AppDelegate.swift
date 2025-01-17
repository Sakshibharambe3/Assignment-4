//
//  AppDelegate.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/9/24.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIHostingController(rootView:
            NavigationView {
            LaunchScreenView()
            }
        )
        window?.makeKeyAndVisible()
        return true
    }
}
