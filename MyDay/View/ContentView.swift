//
//  ContentView.swift
//  MyDay
//
//  Created by Gerasimov's on 2024-03-04.
//

import SwiftUI


struct ChecklistItem: Identifiable, Codable {
    
    var id: UUID
    var text: String
    var isChecked: Bool
    
    init(id: UUID = UUID(), text: String, isChecked: Bool = false) {
        self.id = id
        self.text = text
        self.isChecked = isChecked
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case text
        case isChecked
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        text = try container.decode(String.self, forKey: .text)
        isChecked = try container.decode(Bool.self, forKey: .isChecked)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(text, forKey: .text)
        try container.encode(isChecked, forKey: .isChecked)
    }
}


struct ContentView: View {
    
    
    @State private var checklistItems = [ChecklistItem]()
    
    @State private var newTask = ""
    
    var body: some View {
        
        VStack{
            
            Text("My day")
                .font(.custom("AvenirNext-Bold", size: 40))
            
            //Adding new taks elements
            HStack{
                
                TextEditor(text: $newTask)
                    .border(Color.gray, width: 3)
                    .cornerRadius(15)
                    .padding(10)
                    .frame(width: .infinity , height: 100, alignment: .center)
                    .font(.custom("AvenirNext", size: 25))
                
                Button(action:{
                    if newTask != "" {
                        checklistItems.append(ChecklistItem(text: newTask))
                        newTask = ""
                        saveChecklist()
                    }
                }, label: {
                    Text("+")
                        
                        .foregroundColor(.green)
                        .padding(20)
                        .border(Color.gray, width: 3)
                        .cornerRadius(15)
                        .frame(width: 100 , height: 100, alignment: .center)
                        .font(.custom("AvenirNext", size: 40))
                    
                })
            }
            
            //List elemets
            List(checklistItems) { item in
                HStack {
                    
                    if item.isChecked {
                        Image(systemName: "checkmark")
                    } else {
                        Image(systemName: "square")
                    }
                    
                    
                    if item.isChecked {
                        Text(item.text)
                            .font(.custom("AvenirNext-Italic", size: 25)).strikethrough()
                    } else {
                        Text(item.text)
                            .font(.custom("AvenirNext-Italic", size: 25))
                    }
                    
                    
                    Spacer()
                    
                    if item.text != "To be happy" {
                    Text("-")
                        .font(.custom("AvenirNext-Bold", size: 50))
                        .foregroundColor(.red)
                        .padding(.horizontal, 20)
                        
                        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                            if let selectedItemIndex = self.checklistItems.firstIndex(where: { $0.id == item.id }) {
                                checklistItems.remove(at: selectedItemIndex)
                                saveChecklist()
                            }
                            
                        })
                    }
                }
                .onTapGesture {
                    if let selectedItemIndex = self.checklistItems.firstIndex(where: { $0.id == item.id }) {
                        self.checklistItems[selectedItemIndex].isChecked.toggle()
                        saveChecklist()
                    }
                }
            }.onAppear {self.loadChecklist()}
            
        }
    }
    
    func saveChecklist() {
        ChecklistDataManager.shared.saveChecklistItems(checklistItems)
    }
    
    func loadChecklist() {
        checklistItems = ChecklistDataManager.shared.loadChecklistItems()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




