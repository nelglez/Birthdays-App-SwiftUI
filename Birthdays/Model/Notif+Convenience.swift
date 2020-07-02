//
//  Notif+Convenience.swift
//  Birthdays
//
//  Created by Nelson Gonzalez on 7/2/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation
import CoreData

extension Notif {

    @discardableResult convenience init(id: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

       self.init(context: context)

       self.id = id
   }
}
