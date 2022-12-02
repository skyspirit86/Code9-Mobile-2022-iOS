//
//  AppDelegate.swift
//  Code9-Mobile-2022-iOS
//
//  Created by Zolt Varga on 4/23/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    // 1. On tapping the App Icon this is the first method what is called. App Lifecycle method
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        prepareLoginScreen()
        
        return true
    }
    
    // MARK: - Prepare 1st Screen
    
    private func prepareLoginScreen() {
        window = UIWindow()
        let loginViewController = LoginViewController()
        window?.rootViewController = loginViewController
        window?.makeKeyAndVisible()
    }
}

