//
//  UserNotificationService.swift
//  LocalNotification
//
//  Created by Magdalena Toczek on 18/09/2020.
//  Copyright © 2020 Popeq Apps. All rights reserved.
//

import Foundation
import UserNotifications


class UserNotificationService : NSObject {
    
    private override init() {}
    
    static let INSTANCE = UserNotificationService()
    
    let unCenter = UNUserNotificationCenter.current()
    
    func autorize(){
        
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        unCenter.requestAuthorization(options: options) { (accessGranted, error) in
            
            guard error == nil else{
                //display error
               debugPrint("error requesting Autorization (User Notification)")
                return
            }
            
            guard accessGranted else {
                debugPrint("user denied access - (User Notification)")
                 //Handle user denying permissions..
                return
            }
            
            self.configure()
             debugPrint("user accept notification")
        }
        
    }
    
    
    func configure(){
        unCenter.delegate = self
        
    }
    
}


extension UserNotificationService : UNUserNotificationCenterDelegate {
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        debugPrint("User Notification did recive response")
        //user tapped notification
        completionHandler()
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        debugPrint("User Notification will present")
        // foreground what should happen - different oprions
 
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
    
    
    
}


