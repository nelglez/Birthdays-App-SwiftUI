//
//  ContentView.swift
//  Birthdays
//
//  Created by Nelson Gonzalez on 6/30/20.
//  Copyright © 2020 Nelson Gonzalez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var birthDayController = BirthdayController()
    @State private var isShowing = false
    var body: some View {
       
        VStack {
            HStack(alignment: .center) {
                Spacer()
                Text("🎂 Birthdays! 🥳").font(.largeTitle)
                Spacer()
                Button(action: {
                    self.isShowing.toggle()
                }) {
                    Image(systemName: "plus.circle").imageScale(.large)
                }.sheet(isPresented: $isShowing) {
                    AddBirthdayView(birthdayController: self.birthDayController)
                }
            }
            if birthDayController.birthdays.count == 0 {
                Spacer()
                Text("No birthdays yet. Add a birthday!").foregroundColor(.gray)
            } else {
            List{
                ForEach(birthDayController.birthdays, id: \.id) { birthday in
                    RowView(birthday: birthday)
                }.onDelete { (indexSet) in
                    self.birthDayController.deleteBirthdate(at: indexSet)
                }
            }.onAppear {
                 // To remove only extra separators below the list:
                   UITableView.appearance().tableFooterView = UIView()

                   // To remove all separators including the actual ones:
                   UITableView.appearance().separatorStyle = .none
                }
            
            }
            Spacer()
        }.padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
