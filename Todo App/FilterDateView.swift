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
 @State var dueDate: Date

 init(items: Binding<[TodoItem]>) {
     self._items = items
     _dueDate = State(initialValue: Date())
 }

 func buttonTapped() {
    for item in items {
        if item.dueDate.get(.day, .month, .year).year == dueDate.get(.day, .month, .year).year &&
           item.dueDate.get(.day, .month, .year).month == dueDate.get(.day, .month, .year).month &&
           item.dueDate.get(.day, .month, .year).day == dueDate.get(.day, .month, .year).day {
            filteredItems.append(item)
        }
    }
     
}

 var body: some View {
     NavigationView {
         VStack(alignment: .leading) {
            List {
                DatePicker("Date", selection: $dueDate, displayedComponents: .date)
                    .onChange(of: filteredItems) { value in
                        value.dueDate.get(.day, .month, .year).year == dueDate.get(.day, .month, .year).year &&
                           value.dueDate.get(.day, .month, .year).month == dueDate.get(.day, .month, .year).month &&
                           value.dueDate.get(.day, .month, .year).day == dueDate.get(.day, .month, .year).day {
                            filteredItems.append(value)
                        }
                    }
                
                Spacer()
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
         .navigationTitle("Search Todos by date")
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

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
