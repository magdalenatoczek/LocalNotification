//
//  ViewController.swift
//  LocalNotification
//
//  Created by Magdalena Toczek on 18/09/2020.
//  Copyright © 2020 Popeq Apps. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
  let TIMER_NOTIFICATION_HOUR = "UserNotification.everyHour"
    let DATE_NOTIFICATION_MONDAY = "UserNotification.data.monday"
    
    
    
    var notificationNumber = 0

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }

    
    
    
    
    
    
    
    @IBAction func timesButtonPressed(_ sender: Any) {
        
        print("timebuttonClicked")
      
        let content = UNMutableNotificationContent()
        content.title = "Timer Notification"
        content.body = "new notification every hour"
        content.sound = .default
        content.badge = 1
        
        AlertService.alertConfirmingTheAcion(in: self, title: "timer nofitication", message: "one hour") {
            UserNotificationServiceForTime.INSTANCE.triggerTheNotification(triggerType: .timeInterval, identifier: self.TIMER_NOTIFICATION_HOUR, content: content, components: nil, interval: 3600, repeats: true)
        }
    }
    
    
    @IBAction func dataButtonPressed(_ sender: Any) {
        print("data")
      
        let content = UNMutableNotificationContent()
        content.title = "DataNotification"
        content.body = "new notification every monday"
        content.sound = .default
        content.badge = 1
        
        var components = DateComponents()
        components.weekday = 1
        
        AlertService.alertConfirmingTheAcion(in: self, title: "data notification", message: "on monday") {
            UserNotificationServiceForTime.INSTANCE.triggerTheNotification(triggerType: .calendar, identifier: self.DATE_NOTIFICATION_MONDAY, content: content, components: components, interval: nil, repeats: true)
        }
       
        
        
        
        
        
        
    }
    
    
    
    @IBAction func localizationPressed(_ sender: Any) {
        print("localization")
        
        AlertService.alertConfirmingTheAcion(in: self, title: "Location notification", message: " ") {
            UserNotificationServiceForLocation.INSTANCE.updateLocation()
        }
        
 
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        
    }
    
    
    
}

