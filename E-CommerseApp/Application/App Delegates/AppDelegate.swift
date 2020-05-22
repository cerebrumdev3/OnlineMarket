//
//  AppDelegate.swift
//  E-CommerseApp
//
//  Created by Mohit Sharma on 5/19/20.
//  Copyright © 2020 Cerebrum Infotech. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import FirebaseInstanceID
import FirebaseMessaging
import GoogleMaps
import Alamofire
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate, MessagingDelegate
{
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Appcolor.update_ThemeColor()
        GMSServices.provideAPIKey(GoogleAPIKey)
        GoogleApi.shared.initialiseWithKey(GoogleAPIKey)
        GMSPlacesClient.provideAPIKey(GoogleAPIKey)
        
        registerForPushNotifications()
        
        // AllUtilies.CameraGallaryPrmission()
        set_nav_bar_color()
        setRootViewController()
        
        
        
        //Status bar color
        if #available(iOS 13.0, *)
        {
            //            let navBarAppearance = UINavigationBarAppearance()
            //            navBarAppearance.configureWithOpaqueBackground()
            //            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            //            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            //            navBarAppearance.backgroundColor = Appcolor.kTheme_Color
            //
            //            let navigationController = application.windows[0].rootViewController as! UINavigationController
            //            navigationController.navigationBar.standardAppearance = navBarAppearance
            //            navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
            
            
            //            let navBarAppearance = UINavigationBarAppearance()
            //            navBarAppearance.configureWithOpaqueBackground()
            //            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            //            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            //            navBarAppearance.backgroundColor = Appcolor.kTheme_Color
            //            let nav = UINavigationController()
            //            nav.navigationBar.standardAppearance = navBarAppearance
            //            nav.navigationBar.scrollEdgeAppearance = navBarAppearance
            
        }
        else
        {
            if let StatusbarView = UIApplication.shared.value(forKey: "statusBar") as? UIView
            {
                StatusbarView.backgroundColor = Appcolor.kTheme_Color
            }
        }
        
        
        
        //Nav bar title Bold
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font:  UIFont.boldSystemFont(ofSize: 18)]
        
        
        
        if #available(iOS 10, *)
        {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
        else
        {
            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }
        
        
        Messaging.messaging().delegate = self
        FirebaseApp.configure()
        
      //  Drift.logout()
      //  Drift.setup(kDrift_ClientToken)
      //  Drift.registerUser(AppDefaults.shared.userID, email: AppDefaults.shared.userEmail, userJwt: AppDefaults.shared.userName)
        
        
        return true
    }
    
    
    @available(iOS 13.0, *)
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "E_CommerseApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext ()
    {
        let context = persistentContainer.viewContext
        if context.hasChanges
        {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func showPermissionAlert()
        {
            let alert = UIAlertController(title: "Alert", message: "Please enable access to Notifications in the Settings app.", preferredStyle: .alert)
            
            let settingsAction = UIAlertAction(title: "Settings", style: .default) {[weak self] (alertAction) in
                self?.gotoAppSettings()
            }
            
            let cancelAction = UIAlertAction(title: KCancel, style: .default, handler: nil)
            
            alert.addAction(settingsAction)
            alert.addAction(cancelAction)
            
            DispatchQueue.main.async
                {
                    self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
        private func gotoAppSettings()
        {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else
            {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl)
            {
                if #available(iOS 10.0, *)
                {
                    UIApplication.shared.open(settingsUrl, options: [:]) { (success) in
                        print(success)
                    }
                }
                else
                {
                    
                }
            }
        }
        
        
        func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String)
        {
            print("Firebase registration token: \(fcmToken)")
            
            //let dataDict:[String: String] = ["token": fcmToken]
            // NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
            // TODO: If necessary send token to application server.
            // Note: This callback is fired at each app startup and whenever a new token is generated.
        }
        
        
        
        //MARK:- Push Configuration
        func application(_ application: UIApplication,
                         didFailToRegisterForRemoteNotificationsWithError error: Error)
        {
            print("Failed to register: \(error)")
            AppDefaults.shared.userDeviceToken = "11111111111"
        }
        
        func application(_ application: UIApplication,
                         didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
        {
            print("Successfully registered for notifications!")
            let deviceTokenString = deviceToken.hexString
            print(deviceTokenString)
            AppDefaults.shared.userDeviceToken = deviceTokenString
            Auth.auth().setAPNSToken(deviceToken, type: AuthAPNSTokenType.unknown)
            
            
            InstanceID.instanceID().instanceID(handler: { (result, error) in
                if let error = error
                {
                    print("Error fetching remote instange ID: \(error)")
                    AppDefaults.shared.firebaseToken = "123"
                }
                else if let result = result
                {
                    print("Remote instance ID token: \(result.token)")
                    AppDefaults.shared.firebaseToken = result.token
                }
            })
        }
        
        
        func registerForPushNotifications()
        {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                (granted, error) in
                guard granted else { return }
                self.getNotificationSettings()
            }
        }
        
        func getNotificationSettings()
        {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                print("Notification settings: \(settings)")
            }
        }
        
        
        // This function will be called when the app receive notification
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
        {
            // show the notification alert (banner), and with sound
            // completionHandler([.alert, .sound])
            // self.playSound()
            print(notification.request.content.userInfo as Any)
            self.give_me_notification_info(info: notification.request.content.userInfo)
            
        }
        
        // This function will be called right after user tap on the notification
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            
            // tell the app that we have finished processing the user’s action / response
            // completionHandler()
            print(response.notification.request.content.userInfo as Any)
            self.give_me_notification_info(info: response.notification.request.content.userInfo)
            //  self.playSound()
        }
        
        
        func give_me_notification_info(info:[AnyHashable : Any])
        {
            //           if let notif_title = info["title"] as? String
            //           {
            //
            //           }
        }
        
        
        
        func set_nav_bar_color()
        {
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().tintColor = UIColor.black
            UINavigationBar.appearance().barTintColor = UIColor.white
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().clipsToBounds = false
            UINavigationBar.appearance().backgroundColor = UIColor.white
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font : (UIFont(name: "Helvetica Neue", size: 18))!, NSAttributedString.Key.foregroundColor: UIColor.black]
            
        }
        
        func setRootViewController()
        {
            
            // self.setRootView("SWRevealViewController", storyBoard: "Home")
            
            if AppDefaults.shared.userID == "0"
            {
                self.setRootView("LoginWithPhoneVC", storyBoard: "Main")
            }
            else
            {
                self.setRootView("SWRevealViewController", storyBoard: "Home")
            }
        }
        
    }


    extension Data
    {
        var hexString: String
        {
            let hexString = map { String(format: "%02.2hhx", $0) }.joined()
            return hexString
        }
    }

