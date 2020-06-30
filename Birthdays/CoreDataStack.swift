//
//  CoreDataStack.swift
//  Birthdays
//
//  Created by Nelson Gonzalez on 6/30/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation
import CoreData


class CoreDataStack {

       // shared property pattern
       // Let us access the CoreDataStack from anywhere inthe app
       static let shared = CoreDataStack()

       // Setup a persistent container
       lazy var container: NSPersistentContainer = {

           let container = NSPersistentContainer(name: "Birthdays") // Name of the data model file
           // creates a persistent store
           container.loadPersistentStores { (_, error) in
               // Check for an error and intentionally crash the app with fatalError if there is an error
               if let error = error {
                   fatalError("Failed to load persistent stores: \(error)")
               }
           }
           // Return the container
           return container
       }()


       // Create easy acces to the ManagedObjectContext (moc)
       // Create a computed property
       var mainContext: NSManagedObjectContext {
           return container.viewContext
       }
}
