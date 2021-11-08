//
//  AppDelegate.swift
//  DeakoProject
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // starting point for programatic application
        self.window = UIWindow(frame: UIScreen.main.bounds)
       // set initial view controller and adds navigation bar
        window?.rootViewController = UINavigationController(rootViewController: TrafficCameraTableViewController())
        // making the view controller visible 
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

