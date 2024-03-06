//
//  ContentView.swift
//  MyDay
//
//  Created by Gerasimov's on 2024-03-04.
//

import SwiftUI

struct ChecklistItem: Identifiable {
    let id = UUID()
    var text: String
    var isChecked: Bool = false
}

struct ContentView: View {
    
    @State private var checklistItems = [
        ChecklistItem(text: "Йога"),
        ChecklistItem(text: "курси по Swift"),
        ChecklistItem(text: "повторити слова англ.")
    ]
    
    @State private var newTask = ""
    
    var body: some View {
        
        VStack{
            
            TextEditor(text: $newTask).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 3).padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
        List(checklistItems) { item in
            HStack {
                Text(item.text)
                Spacer()
                if item.isChecked {
                    Image(systemName: "checkmark")
                } else {
                    Image(systemName: "square")
                }
            }
            .onTapGesture {
                if let selectedItemIndex = self.checklistItems.firstIndex(where: { $0.id == item.id }) {
                    self.checklistItems[selectedItemIndex].isChecked.toggle()
                }
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
