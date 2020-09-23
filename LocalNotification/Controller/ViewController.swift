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
  let LOCATION_NOTIFICATION_REGION = "UserNotification.location.myRegion"
    
    
    var notificationNumber = 0

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterRegion), name: NSNotification.Name("internalNotification.enteredRegion"), object: nil)
    
    }

    
    @objc func didEnterRegion(){
        
        let content = UNMutableNotificationContent()
        content.title = "Location Notification"
        content.body = "You have returned"
        content.sound = .default
        content.badge = 1
        UserNotificationService.INSTANCE.locationNotification(identifier: LOCATION_NOTIFICATION_REGION, content: content)
        
    }
    
    
    func getResource(name: String, withExtension: String)-> URL? {
        if let url = Bundle.main.url(forResource: name, withExtension: withExtension) {
            return url
        }else{
            return nil
        }
    }
    
    
    @IBAction func timesButtonPressed(_ sender: Any) {
        
        print("timebuttonClicked")
      
        let content = UNMutableNotificationContent()
        content.title = "Timer Notification"
        content.body = "new notification 6 min"
        content.sound = .default
        content.badge = 1
        
        if let url = getResource(name: "download", withExtension: "png"){
            if let attachment = UserNotificationService.INSTANCE.getAttachment(url: url, id: "notificationAttachment.Timer"){
                content.attachments = [attachment]
            }
        }
        
        AlertService.alertConfirmingTheAcion(in: self, title: "timer nofitication", message: "6 min") {
            UserNotificationService.INSTANCE.triggerTheNotification(triggerType: .timeInterval, identifier: self.TIMER_NOTIFICATION_HOUR, content: content, components: nil, interval: 360, repeats: true)
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
            UserNotificationService.INSTANCE.triggerTheNotification(triggerType: .calendar, identifier: self.DATE_NOTIFICATION_MONDAY, content: content, components: components, interval: nil, repeats: true)
        }
       
        
        
        
        
        
        
    }
    
    
    
    @IBAction func locationButtonPressed(_ sender: Any) {
        print("location clicked")
        
        AlertService.alertConfirmingTheAcion(in: self, title: "Location notification", message: " ") {
            UserNotificationServiceForLocation.INSTANCE.updateLocation()
        }
        
 
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        
    }
    
    
    
}

