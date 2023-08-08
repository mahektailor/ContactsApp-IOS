//
//  ContactsTableViewController.swift
//  ContactsApp-IOS
//
//  Created by Prabhjot on 08/08/2023
//


import UIKit
import CoreData
var Contacts = [Contact]()
var addContact = AddContactViewController()

class ContactsTableViewController: UITableViewController {
    
    var firstload = true
    @IBOutlet weak var imgView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if (firstload) {
            firstload = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
            let sort = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sort]
            
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let contact = result as! Contact
                    Contacts.append(contact)
                }
            }
            catch{
                print("Didn't get any contact")
            }
        }
    }
    
    func nonDeletedContacts() -> [Contact]{
            var nonDeleteContactList = [Contact]()
            for contact in Contacts {
                if (contact.deletedDate == nil) {
                    nonDeleteContactList.append(contact)
                }
            }
            return nonDeleteContactList
        }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nonDeletedContacts().count
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = nonDeletedContacts()[indexPath.row].name

        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ViewContact") {
            let dst = segue.destination as! ContactsViewController
            let indexPath = tableView.indexPathForSelectedRow!
            dst.selectedContact = nonDeletedContacts()[indexPath.row]
            dst.index = tableView.indexPathForSelectedRow?.row
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0, y: 0)

        UIView.animate(withDuration: 0.5) {
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}
