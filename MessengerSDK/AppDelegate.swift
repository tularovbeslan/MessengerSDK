//
//  AppDelegate.swift
//  MessengerSDK
//
//  Created by workmachine on 24/12/2018.
//  Copyright © 2018 Beslan Tularov Ramazanovich. All rights reserved.
//

import UIKit
import FPSCounter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
//		FPSCounter.showInStatusBar(UIApplication.shared)
		window = UIWindow()
		window?.makeKeyAndVisible()
		
		window?.rootViewController = UINavigationController(rootViewController: MessengerViewController())
		
		return true
	}
}

