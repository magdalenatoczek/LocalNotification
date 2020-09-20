//
//  AlertService.swift
//  LocalNotification
//
//  Created by Magdalena Toczek on 20/09/2020.
//  Copyright © 2020 Popeq Apps. All rights reserved.
//

import Foundation
import UIKit

class AlertService {
    
    private init(){}
    
    static func alertConfirmingTheAcion(in vc: UIViewController, title: String, message: String,  completion: @escaping()-> Void){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: title, style: .default) { (_) in
            completion()
        }
        
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    
}

