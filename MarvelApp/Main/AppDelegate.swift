//
//  AppDelegate.swift
//  MarvelApp
//
//  Created by Asaad Jaber on 3/13/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var rootViewController: ComposableGridViewController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        rootViewController = ComposableGridViewController()
        rootViewController.imageAPI = ImageAPI(requestLoader: APIRequestLoader(apiRequest: ImageStoreAPI()))
        
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.backgroundColor = UIColor(displayP3Red: 34/255, green: 37/255, blue: 43/255, alpha: 1.0)
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("yo Will BG")

        UserDefaults.standard.set(rootViewController.listDataSource.json, forKey: ListDataSource.documentPath)

    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        UserDefaults.standard.set(rootViewController.listDataSource.json, forKey: ListDataSource.documentPath)

        print("yo Will terminate")
    }
}
