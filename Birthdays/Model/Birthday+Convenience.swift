//
//  Birthday+Convenience.swift
//  Birthdays
//
//  Created by Nelson Gonzalez on 6/30/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//https://medium.com/@aliakhtar_16369/mastering-in-coredata-part-5-relationship-between-entities-in-core-data-b8fea1b50efb

import Foundation
import CoreData

extension Birthday {

    @discardableResult convenience init(id: UUID = UUID(), name: String, birthdate: Date, notification: Notif, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

       self.init(context: context)

       self.id = id
       self.name = name
       self.birthdate = birthdate
        self.notification = notification
   }
}
