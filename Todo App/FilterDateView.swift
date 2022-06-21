//
//  FilterDateView.swift
//  Todo App
//
//  Created by Amir Mohammad on 3/31/1401 AP.
//

import SwiftUI

struct FilterDateView: View {

 @Binding var items: [TodoItem]
 @State var filteredItems: [TodoItem] = []
 @State var date: Date

 init(items: Binding<[TodoItem]>) {
     self._items = items
     _date = State(initialValue: Date())
 }

 func buttonTapped() {
     for item in items {
         if item.dueDate == date {
             filteredItems.append(item)
         }
     }
 }

 var body: some View {
     NavigationView {
         VStack(alignment: .leading, spacing: 10) {
             Form {
                 DatePicker("Date", selection: $date)
             }
             List {
                 ForEach(filteredItems, id: \.ID) {
                     item in
                     VStack(alignment: .leading, spacing: 10) {
                         Text(item.name)
                             .bold()
                             .font(.title3)
                     }
                 }
             }
         }
         .navigationTitle("Search todo'es by date ")
         .toolbar {
             Button {
                 buttonTapped()
             } label: {
                 Text("Search")
             }
         }
     }
 }
}
