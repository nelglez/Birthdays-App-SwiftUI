//
//  AddBirthdayView.swift
//  Birthdays
//
//  Created by Nelson Gonzalez on 6/30/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct AddBirthdayView: View {
    @Environment(\.presentationMode) var presentationMode
    var birthdayController: BirthdayController
    @State private var name = ""
    @State private var birthDate = Date()
    @State private var showAlert = false
    
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
                    self.birthdayController.addNewBirthdayFor(name: self.name, birthDate: self.birthDate) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
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
}

struct AddBirthdayView_Previews: PreviewProvider {
    static var previews: some View {
        AddBirthdayView(birthdayController: BirthdayController())
    }
}
