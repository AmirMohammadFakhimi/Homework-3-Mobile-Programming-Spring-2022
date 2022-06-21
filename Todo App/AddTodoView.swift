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
    @State var dueDate: Date
    @State var dateToShow: String
    
    init(items: Binding<[TodoItem]>, itemToEdit: TodoItem? = nil) {
        self._items = items
        self.itemToEdit = itemToEdit
        
        if let item = itemToEdit {
            _name = State(initialValue: item.name)
            _dueDate = State(initialValue: item.dueDate)
            _dateToShow = State(initialValue: item.dueDate.formatted())
        } else {
            _name = State(initialValue: "")
            _dueDate = State(initialValue: Date())
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
            item.dateToShow = dueDate.formatted()
            let item = TodoItem(name: name, dueDate: dueDate)
            items.append(item)
            items.removeLast()
        } else {
            let item = TodoItem(name: name, dueDate: dueDate)
            items.append(item)
        }
        mode.wrappedValue.dismiss()
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            DatePicker("Date", selection: $dueDate)
        }
        .navigationTitle(Text("Add new Todo"))
        .toolbar {
            Button {
                buttonTapped()
            } label: {
                Text("Done")
            }
        }
    }
}
