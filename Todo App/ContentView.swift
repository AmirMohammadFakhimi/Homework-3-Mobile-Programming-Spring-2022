//
//  ContentView.swift
//  Todo App
//
//  Created by Amir Mohammad on 3/31/1401 AP.
//

import SwiftUI

class TodoItem {
    var name = ""
    var ID: Int
    var date = Date()
    var dateToShow = ""
    var id = 0

    init(name: String, date: Date) {
        self.name = name
        self.date = date
        self.dateToShow = date.formatted()
        self.ID = id
        id += 1
    }
}

struct ContentView: View {
    @State var isNavLinkActive = false
    @State var items: [TodoItem] = []
    
    @State var isActive = false
    
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    func getToDoNum() -> Int {
        var todoNum = 0
        for _ in items {
            todoNum += 1
        }
        return todoNum
    }
    
    var body: some View {
        NavigationView {
            List {
                Text("number of Todos: \(getToDoNum())")
                ForEach(items, id: \.id) {
                    item in
                    NavigationLink(destination: AddToDoView(items: $items, itemToEdit: item)) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(item.name)
                                .bold()
                                .font(.title3)
                            Text("\(item.dateToShow)")
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("My Todos")
            .toolbar {
                NavigationLink {
                    AddToDoView(items: $items)
                } label: {
                    Text("+")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
