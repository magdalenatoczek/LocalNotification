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
    var shouldSetRegion = true
    
    func authorize(){
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        
    }
    
    func updateLocation(){
        shouldSetRegion = true
        locationManager.startUpdatingLocation()
    }
    
    
    
    
}

extension UserNotificationServiceForLocation: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location updated")
        
        guard let currentLocation = locations.first, shouldSetRegion else { return }
        shouldSetRegion = false
        let region = CLCircularRegion(center: currentLocation.coordinate, radius: 20, identifier: "startPosition")
        manager.startMonitoring(for: region)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("did enter region via core Location")
        NotificationCenter.default.post(name: NSNotification.Name("internalNotification.enteredRegion"), object: nil)
        
        
        
    }
    
    
}
