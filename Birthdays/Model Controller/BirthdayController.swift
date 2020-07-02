//
//  BirthdayController.swift
//  Birthdays
//
//  Created by Nelson Gonzalez on 6/30/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import Foundation
import CoreData
import UserNotifications

class BirthdayController: ObservableObject {
    @Published private(set) var birthdays: [Birthday] = []
    
    init() {
          getBirthdays()
      }
      
       
      func saveToPersistentStore() {
          let moc = CoreDataStack.shared.mainContext
          do {
              try moc.save()
              getBirthdays()
           
          } catch {
              NSLog("Error saving managed object context: \(error)")
          }
      }
      
      func getBirthdays() {
          let fetchRequest: NSFetchRequest<Birthday> = Birthday.fetchRequest()
          let moc = CoreDataStack.shared.mainContext

        DispatchQueue.main.async {
            do {
              
                self.birthdays = try moc.fetch(fetchRequest)
                 
            } catch {
                NSLog("Error fetching tasks: \(error)")

            }
        }
          
      }

      // MARK: - CRUD Methods
      // Create
    func addNewBirthdayFor(name: String, birthDate: Date, notification: Notif, completion: @escaping() -> Void) {
        _ = Birthday(name: name, birthdate: birthDate, notification: notification)
          saveToPersistentStore()
        completion()
      }

      // Read
      // Update
      func update(birthday: Birthday, name: String, birthdate: Date) {
          birthday.name = name
          birthday.birthdate = birthdate
       
          saveToPersistentStore()
      }

      // Delete
      func delete(birthDay: Birthday) {
        
        let center = UNUserNotificationCenter.current()
        guard let notificationId = birthDay.notification?.id else { return }
        print("REMOVED NOTIF ID: \(notificationId)")
        center.removePendingNotificationRequests(withIdentifiers: [notificationId])
        
          let mainC = CoreDataStack.shared.mainContext
          mainC.delete(birthDay)
          saveToPersistentStore()    }
       
       func deleteBirthdate(at indexSet: IndexSet) {
           guard let index = Array(indexSet).first else { return }
           
           let birthday = self.birthdays[index]
           
           delete(birthDay: birthday)
           
       }

    

    
//    func addNewBirthdayFor(name: String, birthDate: Date, completion: @escaping() -> Void) {
//        let newBirthday = Birthday(name: name, birthdate: birthDate)
//        birthdays.append(newBirthday)
//        completion()
//    }
}
