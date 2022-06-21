//
//  AddTodoView.swift
//  Todo App
//
//  Created by Amir Mohammad on 3/31/1401 AP.
//

import SwiftUI

struct AddToDoView: View {
    @Environment(\.presentationMode) var mode
    
    @Binding var items: [TodoItem]
    
    var itemToEdit: TodoItem?
    
    @State var name: String
    @State var date: Date
    @State var dateToShow: String
    
    init(items: Binding<[TodoItem]>, itemToEdit: TodoItem? = nil) {
        self._items = items
        self.itemToEdit = itemToEdit
        
        if let item = itemToEdit {
            _name = State(initialValue: item.name)
            _date = State(initialValue: item.date)
            _dateToShow = State(initialValue: item.date.formatted())
        } else {
            _name = State(initialValue: "")
            _date = State(initialValue: Date())
            _dateToShow = State(initialValue: Date().formatted())
        }
    }
    
    func getItemWithID(ID: Int) -> TodoItem? {
        for item in items {
            if item.ID == ID {
                return item
            }
        }
        return nil
    }
    
    func buttonTapped() {
        if let item = itemToEdit {
            item.name = name
            item.dateToShow = date.formatted()
            let item = TodoItem(name: name, date: date)
            items.append(item)
            items.removeLast()
        } else {
            let item = TodoItem(name: name, date: date)
            items.append(item)
        }
        mode.wrappedValue.dismiss()
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            DatePicker("Date", selection: $date)
        }
        .navigationTitle(Text("Add new ToDo"))
        .toolbar {
            Button {
                buttonTapped()
            } label: {
                Text("Done")
            }
        }
    }
}
