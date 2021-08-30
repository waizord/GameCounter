//
//  AppDelegate.swift
//  GameCounter
//
//  Created by Ivan on 8/26/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = NewGameViewController()
        
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.navigationBar.barTintColor = Constants.colors.appBackgroundBlack
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.setValue(true, forKey: "hidesShadow")
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17)!], for: .normal)
        UIBarButtonItem.appearance().tintColor = Constants.colors.customGreen
        
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

