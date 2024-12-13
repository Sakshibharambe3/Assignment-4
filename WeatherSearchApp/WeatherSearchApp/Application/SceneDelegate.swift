//
//  SceneDelegate.swift
//  WeatherSearchApp
//
//  Created by SAKSHI BHARAMBE on 12/9/24.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: LaunchScreenView())
        self.window = window
        window.makeKeyAndVisible()
    }
}
