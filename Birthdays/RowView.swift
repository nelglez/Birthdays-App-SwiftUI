//
//  RowView.swift
//  Birthdays
//
//  Created by Nelson Gonzalez on 6/30/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI
import UserNotifications

struct RowView: View {
    @ObservedObject var birthday: Birthday
    
    var body: some View {
        ZStack {
                   Rectangle().fill(Color.white).cornerRadius(10).shadow(color: .gray, radius: 4)
        HStack {
            VStack {
                Text(getMonthName(date: birthday.birthdate ?? Date())).background(Color.red).foregroundColor(.white)
                Text("\(getDate(date: birthday.birthdate ?? Date()))").background(Color.white).foregroundColor(.black)
            }.padding()
            Spacer()
            Text(birthday.name ?? "Test").font(.title)
            Spacer()
            VStack {
                Text("Turning").background(Color.orange).foregroundColor(.white).cornerRadius(5)
                Text("\(getYearsOld(date: (birthday.birthdate ?? Date())))")
                Text("\(daysUntil(birthday: birthday.birthdate  ?? Date()))").background(Color.blue).cornerRadius(5)
            }
        }.padding()
        }.onAppear {
            let calendar = Calendar.current
            let month = calendar.component(.month, from: self.birthday.birthdate ?? Date())
            let day = calendar.component(.day, from: self.birthday.birthdate ?? Date())
            let todayMonth = calendar.component(.month, from: Date())
            let todayDay = calendar.component(.day, from: Date())
            
            //If the birthday date is today then go ahead and schedule a local notification
            if todayMonth == month && todayDay == day {
                self.scheduleNotification(birthdayDate: self.birthday.birthdate ?? Date())
            }
        }
    }
    func getDate(date: Date) -> Int {
        let components = date.get(.day, .month, .year)
    
        if let day = components.day/*, let month = components.month, let year = components.year */{
          //  print("day: \(day), month: \(month), year: \(year)")
           return day
            
        }

        return 0
    }
    
    func getMonthName(date: Date) -> String {
        
        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "MMM" // format January, February, March, ...
        
            let monthName = nameFormatter.string(from: date)
            return monthName
        
    }
    
    func getYearsOld(date: Date) -> Int {
        return date.age + 1
    }
    
    func daysUntil(birthday: Date) -> String {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        let date = cal.startOfDay(for: birthday)
        let components = cal.dateComponents([.day, .month], from: date)
        let nextDate = cal.nextDate(after: today, matching: components, matchingPolicy: .nextTimePreservingSmallerComponents)
        let x = cal.dateComponents([.day], from: today, to: nextDate ?? today).day ?? 0
        if x == 1 {
            return "In 1 day"
        } else if x == 365 {
            return "Today"
        } else {
            return "In \(x) days"
        }
    }
    
    func scheduleNotification(birthdayDate: Date) {
        let center = UNUserNotificationCenter.current()
        
        let title = "There's a birthday today!"

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

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        // more code to come
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(birthday: Birthday(name: "Test", birthdate: Date()))
    }
}


