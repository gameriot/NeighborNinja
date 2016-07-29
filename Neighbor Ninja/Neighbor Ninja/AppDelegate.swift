//
//  AppDelegate.swift
//  NeighborNinja
//
//  Created by Samast Varma on 6/25/16.
//  Copyright © 2016 Samast Varma. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import FirebaseInstanceID

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        registerForPushNotifications(application)
        // Override point for customization after application launch.
        // Use Firebase library to configure APIs
        FIRApp.configure()
        return true
    }
    
    func registerForPushNotifications(application: UIApplication) {
        let notificationSettings = UIUserNotificationSettings(
            forTypes: [.Badge, .Sound, .Alert], categories: nil)
        application.registerUserNotificationSettings(notificationSettings)
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        if notificationSettings.types != .None {
            application.registerForRemoteNotifications()
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for i in 0..<deviceToken.length {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        //Tricky line
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.Unknown)
        print("Device Token:", tokenString)
    }

//    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        // Override point for customization after application launch.
//        FIRApp.configure()
//
//        let notificationTypes : UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
//        let notificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
//        application.registerForRemoteNotifications()
//        application.registerUserNotificationSettings(notificationSettings)
//        
//        return true
//    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
//        print ("Message ID : \(userInfo["gcm_message_id"]!)")
//        print (userInfo)
//    }
    


    
}

