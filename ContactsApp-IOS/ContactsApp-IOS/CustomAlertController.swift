//
//  CustomAlertController.swift
//  ContactsApp-IOS
//
//  Created by Prabhjot on 08/08/2023
//

import UIKit

class CustomAlertController: NSObject {
    
    let message:String?
    let title:String?
    
    init(title:String, message:String) {
        self.message = message
        self.title = title
    }
    

    func showAlert()->UIAlertController {
        let alertController = UIAlertController(title: self.title, message: self.message, preferredStyle: .alert)
        // you can further customize your buttons, buttons' title etc
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
        }))
        return alertController
    }
    
}
