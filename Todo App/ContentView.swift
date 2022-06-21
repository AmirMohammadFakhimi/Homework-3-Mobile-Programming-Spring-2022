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
    var dueDate = Date()
    var createdDate = Date.now
    var dateToShow = ""
    static var idCounter = 0

    init(name: String, dueDate: Date) {
        self.name = name
        self.dueDate = dueDate
        self.dateToShow = dueDate.formatted()
        self.ID = TodoItem.idCounter
        TodoItem.idCounter += 1
    }
}

enum SortType: String, CaseIterable, Identifiable {
    case createdDate, dueDate, name
    var id: Self { self }
}

struct ContentView: View {
    @State var isNavLinkActive = false
    @State var items: [TodoItem] = [
        TodoItem(name: "hi1", dueDate: Date.now),
        TodoItem(name: "Amir", dueDate: Date.now),
        TodoItem(name: "hi2", dueDate: Date.now)
    ]
    
    @State var sortedItems: [TodoItem] {
            get {
                if (selectedSortType == SortType.dueDate) {
                    items = items.sorted(by: { $0.dueDate > $1.dueDate })
                } else if (selectedSortType == SortType.createdDate) {
                    items = items.sorted(by: { $0.createdDate > $1.createdDate })
                } else if (selectedSortType == SortType.name) {
                    items = items.sorted(by: { $0.name > $1.name })
                }
            }
            set {
                items = newValue
            }
        }
    
    @State var isActive = false
    @State var isShowingSortSheet = false
    @State var selectedSortType: SortType = .createdDate
    
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
        TabView {
            NavigationView {
                List {
                    Text("number of Todos: \(getToDoNum())")
                    ForEach(items, id: \.ID) {
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
                    HStack {
                        Button {
                            isShowingSortSheet.toggle()
                        } label: {
                            Text("Sort Options")
                        }
                        NavigationLink {
                            AddToDoView(items: $items)
                        } label: {
                            Text("+")
                        }
                    }
                    
                }
                .sheet(isPresented: $isShowingSortSheet) {
                    Picker("Sort Type", selection: $selectedSortType) {
                        Text("By Created Date").tag(SortType.createdDate)
                        Text("By Due Date").tag(SortType.dueDate)
                        Text("By Name").tag(SortType.name)
                    }
                }
            }
            .tabItem {
                Image(systemName: "square.and.pencil")
                Text("TODO LIST")
            }
            FilterDateView(items: $items)
                .tabItem {
                    Image(systemName: "doc.text.magnifyingglass")
                    Text("Filter")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
