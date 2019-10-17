//
//  AppDelegate.swift
//  Edulinu
//
//  Created by Laurens Kropf on 04.03.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import UIKit
import Firebase
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    override init() {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // OneSignal: Get AdditionalData from notification and forward if notification type is news
        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
          let payload: OSNotificationPayload = result!.notification.payload

          if payload.additionalData != nil {
             let additionalData = payload.additionalData
             if additionalData?["openNewsWithId"] != nil {
                let newsIdFromOneSignal = additionalData?["openNewsWithId"] as! String
                let newsId = Int(newsIdFromOneSignal) ?? -1
                
                var news: [News] = []
                let ref = Database.database().reference(withPath: "news")
                ref.queryOrdered(byChild: "newsId").queryEqual(toValue: newsId).observe(.value, with: { snapshot in
                    var newNews: [News] = []
                    for child in snapshot.children {
                        if let snapshot = child as? DataSnapshot,
                            let newsEntry = News(snapshot: snapshot) {
                            newNews.append(newsEntry)
                        }
                    }
                    
                    news = newNews
                    
                    if news.isEmpty {
                    } else {
                        
                        let newsEntry = news[0]
                        
                        let storyboard = UIStoryboard(name: "NewsNotification", bundle: nil)
                        let newsNotificationVC = storyboard.instantiateViewController(withIdentifier: "NewsNotificationViewController") as! NewsNotificationViewController
                        
                        newsNotificationVC.newsEntry = newsEntry
                        
                        newsNotificationVC.modalPresentationStyle = .fullScreen
                        
                        self.window?.rootViewController?.present(newsNotificationVC, animated: true, completion: nil)
                        
                    }
                })
                
             }
          }
        }
        
        
        // OneSignal: Init Settings
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]

        // OneSignal: Init
        OneSignal.initWithLaunchOptions(launchOptions,
        appId: "0ffcee62-6b71-417d-8123-a276cf3cc936",
        handleNotificationAction: notificationOpenedBlock,
        settings: onesignalInitSettings)
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;

        if edulinuLocalUserSettings.bool(forKey: Keys.ElusDidSplash) {
            OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
            })
        }
        
        // Database
        let ref = Database.database().reference(withPath: "maintenance")
        ref.observe(.value, with: { (snapshot) in
            if let value = snapshot.value as? [String: Any] {
                let maintenanceMode = value["maintenanceMode"] as? Bool ?? false
                if maintenanceMode == true {
                    let mainStoryboard:UIStoryboard = UIStoryboard(name: "Maintenance", bundle: nil)
                    let maintenanceViewController = mainStoryboard.instantiateViewController(withIdentifier: "MaintenanceViewController") as! MaintenanceViewController
                    self.window?.rootViewController = maintenanceViewController
                }
            }
        })
        
        if edulinuLocalUserSettings.bool(forKey: Keys.ElusDidSplash) == false {
            let splashscreenStoryboard:UIStoryboard = UIStoryboard(name: "Splashscreen", bundle: nil)
            let splashWelcomeViewController = splashscreenStoryboard.instantiateViewController(withIdentifier: "SplashWelcomeViewController") as! SplashWelcomeViewController
            self.window?.rootViewController = splashWelcomeViewController
        }
        
        if edulinuLocalUserSettings.array(forKey: Keys.ElusFavouriteTeachers) == nil {
            edulinuLocalUserSettings.set([""], forKey: Keys.ElusFavouriteTeachers)
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "myEdReloadDayTime"), object: nil)
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

