//
//  AppDelegate.swift
//  Networking
//
//  Created by Omran on 2020-02-13.
//  Copyright © 2020 Omran. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //https://samples.openweathermap.org/data/2.5?q=London,uk&

        let manager = APIManager(baseURL: "https://samples.openweathermap.org/data/2.5")
        let endpoint = TestEnpoint.weather(queryParams: ["q":"London", "appid":"b6907d289e10d714a6e88b30761fae22"])
       
        manager.makeApiCall(at: endpoint, for: WeatherResponse.self) { (result) in
            switch result {
            case .success(let w):
                print(w)
            case .failure(let error):
                print(error)
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

