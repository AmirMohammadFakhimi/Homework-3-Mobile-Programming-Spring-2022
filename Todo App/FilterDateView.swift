//
//  FilterDateView.swift
//  Todo App
//
//  Created by Amir Mohammad on 3/31/1401 AP.
//

import SwiftUI

struct FilterDateView: View {

    @Binding var items: [TodoItem]
    @State var filteredItems: [TodoItem] = [] {
        didSet {
            for item in items {
                if item.date == date {
                        filteredItems.append(item)
                }
            }
        }
    }
    @State var date: Date
    
    init(items: Binding<[TodoItem]>) {
        self._items = items
        _date = State(initialValue: Date())
    }

    // [picker addTarget:self action:@selector(dateChanged:) 
    //           forControlEvents:UIControlEventValueChanged]

    // func dateChanged:(id)sender{
    //     for item in items {
    //         if item.date == date {
    //             filteredItems.append(item)
    //         }
    //     }
    // }
    
    func buttonTapped() {
        for item in items {
            if item.date == date {
                filteredItems.append(item)
            }
        }
    }

    func getfilteredItems() {
        for item in items {
            if item.date == date {
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
                    ForEach(filteredItems, id: \.id) {
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

