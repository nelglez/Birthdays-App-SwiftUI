//
//  AddBirthdayView.swift
//  Birthdays
//
//  Created by Nelson Gonzalez on 6/30/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI
import UserNotifications

struct AddBirthdayView: View {
    @Environment(\.presentationMode) var presentationMode
    var birthdayController: BirthdayController
    @State private var name = ""
    @State private var birthDate = Date()
    @State private var showAlert = false
    @State private var identifier = ""
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var body: some View {
        VStack {
            Text("Add a birthday!").font(.largeTitle)
            TextField("Name", text: $name).textFieldStyle(RoundedBorderTextFieldStyle())
            DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                Text("Select a date")
            }

            Text("Birthday date is \(birthDate, formatter: dateFormatter)")
            
            Button(action: {
                if !self.name.isEmpty {
                   
             //       print("UUID = \(self.identifier)")
                    
                    self.scheduleNotification(name: self.name, birthdayDate: self.birthDate, completion: {
                       
              //          print("UUID = \(self.identifier)")
                        
                        self.birthdayController.addNewBirthdayFor(name: self.name, birthDate: self.birthDate, notification: Notif(id: self.identifier)) {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    })
                    
                } else {
                    self.showAlert = true
                }
            }) {
                Text("Save")
            }.alert(isPresented: $showAlert) {
                Alert(title: Text("Error!"), message: Text("Please fill in all fields."), dismissButton: .default(Text("OK!")))
            }
            
        }.padding()
    }
    
    func scheduleNotification(name: String, birthdayDate: Date, completion: @escaping() -> Void) {
        

        let center = UNUserNotificationCenter.current()
        
        let title = "It's \(name)'s birthday today!"

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = title
          //  content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            let calendar = Calendar.current
           // calendar.component(.year, from: date)
            let month = calendar.component(.month, from: birthdayDate)
            let day = calendar.component(.day, from: birthdayDate)

            var dateComponents = DateComponents()
            dateComponents.month = month
            dateComponents.day = day
            dateComponents.hour = 7
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
           // shows the alert five seconds from now for testing purposes.
         //   let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            let identifier = UUID().uuidString
            self.identifier = identifier
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            center.add(request)
        }

        // more code to come
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
                completion()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                        completion()
                    } else {
                        print("D'oh")
                        completion()
                    }
                }
            }
        }
    }
}

struct AddBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        AddBirthdayView(birthdayController: BirthdayController())
    }
}
