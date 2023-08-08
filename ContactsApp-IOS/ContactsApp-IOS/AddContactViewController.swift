//
//  AddContactViewController.swift
//  ContactsApp-IOS
//
//  Created by Prabhjot on 08/08/2023
//

import UIKit
import CoreData

class AddContactViewController: UIViewController, UITextFieldDelegate {

    var selectedContact: Contact? = nil
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var deleteOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteOutlet.isHidden = true
        phoneNumberTextField.delegate = self
    }
    
    // Mark: UITextViewDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = "+1234567890"
        let allowedCharcterSet = CharacterSet(charactersIn: allowedCharacters)
        let typedCharcterSet = CharacterSet(charactersIn: string)
        return allowedCharcterSet.isSuperset(of: typedCharcterSet)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if (nameTextField.text!.count <  3) {
            let alert = CustomAlertController(title: "Pleae enter a name", message: "Name field is empty")
            DispatchQueue.main.async {
                self.present(alert.showAlert(), animated: true, completion: nil)
            }
        } else if (phoneNumberTextField.text!.count < 1) {
            let alert = CustomAlertController(title: "Pleae enter a phone number", message: "Phone Number field is empty")
            DispatchQueue.main.async {
                self.present(alert.showAlert(), animated: true, completion: nil)
            }
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            if(selectedContact == nil) {
                let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)
                let newContact = Contact(entity: entity!, insertInto: context)

                newContact.name = nameTextField.text
                newContact.phonenumber = phoneNumberTextField.text
                
                do {
                    try context.save()
                    Contacts.append(newContact)
                    navigationController?.popToRootViewController(animated: true)
                } catch  {
                    print("Failed to save contact")
                }
            } else {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
                
                do {
                    let results:NSArray = try context.fetch(request) as NSArray
                    for result in results {
                        let contact = result as! Contact
                        if(contact == selectedContact) {
                            contact.name = nameTextField.text
                            contact.phonenumber = phoneNumberTextField.text
                            try context.save()
                            navigationController?.popToRootViewController(animated: true)
                        }
                    }
                } catch{
                    print("Didn't get any contact")
                }
            }
        }
    }
    
    
    @IBAction func deleteContact(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results {
                
                let contact = result as! Contact
                if(contact == selectedContact) {
                    
                    contact.deletedDate = Date()
                    try context.save()
                    navigationController?.popToRootViewController(animated: true)
                    
                }
            }
        } catch{
            print("Didn't get any contact")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(selectedContact != nil) { //if its not nil, filling out the fields
            nameTextField.text = selectedContact?.name
            phoneNumberTextField.text = selectedContact?.phonenumber
            deleteOutlet.isHidden = false
        }
    }
}
