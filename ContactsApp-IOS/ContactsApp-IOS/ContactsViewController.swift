//
//  ContactsViewController.swift
//
//  ContactsApp-IOS
//
//  Created by Prabhjot on 08/08/2023
//
//

import UIKit

class ContactsViewController: UIViewController {

    var selectedContact: Contact? = nil
    var index: Int!

    var newSelectedContact: Contact? = nil

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {

        if selectedContact != nil {
            nameLabel.text = selectedContact?.name
            numberLabel.text = selectedContact?.phonenumber
            newSelectedContact = selectedContact
        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editContact") {
            print(selectedContact!)
            let dst = segue.destination as! AddContactViewController
            dst.selectedContact = newSelectedContact
        }
    }
}
