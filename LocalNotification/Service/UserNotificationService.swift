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
    
    func authorize(){
        
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        unCenter.requestAuthorization(options: options) { (accessGranted, error) in
            
            guard error == nil else{
                //display error
             //  debugPrint("error requesting Autorization (User Notification)")
                return
            }
            
            guard accessGranted else {
              //  debugPrint("user denied access - (User Notification)")
                 //Handle user denying permissions..
                return
            }
           // debugPrint("user accept notification")
            self.configure()
             
        }
        
    }
    
    
    func configure(){
        unCenter.delegate = self
        
    }
    
    
    
    func getAttachment(url : URL, id: String)-> UNNotificationAttachment? {
        do{
            let attachment = try UNNotificationAttachment(identifier: id, url: url)
            return attachment
        } catch {
            return nil
        }
    }

    func locationNotification(identifier: String, content: UNMutableNotificationContent){
    
        let request = UNNotificationRequest(identifier: identifier, content:content, trigger: nil)
        unCenter.add(request, withCompletionHandler: nil)
        
    }
    
    
    
    func triggerTheNotification(triggerType: TriggerType, identifier: String, content: UNMutableNotificationContent, components: DateComponents?,  interval : TimeInterval?, repeats: Bool){
        
        var trigger: UNNotificationTrigger!
        
        switch triggerType {
        case .calendar:
            if let components = components {
                trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: repeats)
            } else {
                debugPrint("components can't be nil when triggerType is .calendar")
            }
        case .timeInterval:
            if let interval = interval {
                trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: repeats)
            } else {
                debugPrint("interval can't be nil when triggerType is .timeInterval")
            }

        }
        
        if let trigger = trigger {
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            unCenter.add(request, withCompletionHandler: nil)
            
        } else {
            debugPrint("trigger can't be nil")
        }
        
        
    }
    
    
}


extension UserNotificationService : UNUserNotificationCenterDelegate {
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
       // debugPrint("User Notification did recive response")
        //user tapped notification
        completionHandler()
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
       // debugPrint("User Notification will present")
        // foreground what should happen - different oprions
 
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
    
    
    
}


