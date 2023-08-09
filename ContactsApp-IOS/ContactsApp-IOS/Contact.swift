//
//  Contact.swift
//  ContactsApp
//
//  Created by Hannan Max on 2022-12-11.
//

import CoreData

@objc(Contact)

class Contact: NSManagedObject {

  //  @NSManaged var id: NSNumber!
    @NSManaged var name: String!
    @NSManaged var phonenumber: String!
    @NSManaged var deletedDate: Date?
}
