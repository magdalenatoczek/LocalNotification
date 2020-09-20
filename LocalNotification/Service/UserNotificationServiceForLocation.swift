//
//  UserNotificationServiceForLocation.swift
//  LocalNotification
//
//  Created by Magdalena Toczek on 20/09/2020.
//  Copyright © 2020 Popeq Apps. All rights reserved.
//

import Foundation
import CoreLocation

class UserNotificationServiceForLocation: NSObject {
    
    private override init() {}
    
    static let INSTANCE = UserNotificationServiceForLocation()
    
    let locationManager = CLLocationManager()
    
    func authorize(){
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        
    }
    
    func updateLocation(){
        locationManager.startUpdatingLocation()
    }
    
    
    
    
}

extension UserNotificationServiceForLocation: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location")
    }
    
    
    
}
