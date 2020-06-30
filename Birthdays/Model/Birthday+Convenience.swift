//
//  Birthday+Convenience.swift
//  Birthdays
//
//  Created by Nelson Gonzalez on 6/30/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation
import CoreData

extension Birthday {

   @discardableResult convenience init(id: UUID = UUID(), name: String, birthdate: Date, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

       self.init(context: context)

       self.id = id
       self.name = name
       self.birthdate = birthdate
   }
}
