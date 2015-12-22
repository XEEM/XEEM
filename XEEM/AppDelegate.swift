//
//  AppDelegate.swift
//  XEEM
//
//  Created by USER on 12/3/15.
//  Copyright © 2015 JadeLe. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
    
//        if (User.currentUser == nil) {
//            let storyBoard = UIStoryboard(name: "Login", bundle: nil)
//            let rootVC = storyBoard.instantiateViewControllerWithIdentifier("LoginNavigationController") as! UINavigationController
//            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//            self.window!.rootViewController = rootVC
//            self.window?.makeKeyAndVisible()
//        } else {
//            let storyboard = UIStoryboard(name: "User", bundle: nil)
//            SideMenuController.menuButtonImage = UIImage(named: "menuButton")
//            SideMenuController.presentationStyle = .UnderCenterPanelLeft
//            SideMenuController.animationStyle = .CircleMaskAnimation
//            
//            UINavigationBar.appearance().translucent = false
//            UINavigationBar.appearance().barTintColor = UIColor(hue:0.56, saturation:0.88, brightness:0.95, alpha:1)
//            
//            let rootVC =  storyboard.instantiateViewControllerWithIdentifier("SideMenuController") as! SideMenuController
//            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//            self.window?.rootViewController = rootVC
//            self.window?.makeKeyAndVisible()
//        }
        
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "User", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("CenterUser") as! UINavigationController
        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("LeftViewController") as! LeftViewController
        let rightViewController = storyboard.instantiateViewControllerWithIdentifier("RightViewController") as! RightViewController
        
        //let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
       
        let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)
  
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()


    
        return true
    }

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


}

