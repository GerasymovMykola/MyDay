//
//  ContentView.swift
//  MyDay
//

import SwiftUI

struct Task: Identifiable{
    
    let id = UUID()
    var name: String
    var isComplited: Bool = false
    
}


struct ContentView: View {
    
    @State private var tasks =
    
    [Task(name:"Купити молоко"),
     Task(name:"Прочитати книгу"),
     Task(name:"Зробити зарядку")]
    
    var body: some View {
        
        NavigationView {
            VStack{
                
                Button(action:{
                    tasks.append(Task(name: "New task") )
                }) {
                    Text("Add")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                    
                }
                
                List($tasks) {$task in
                    HStack{
                        Toggle(isOn: $task.isComplited, label: {
                            TextField("Task name", text: $task.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .foregroundColor(task.isComplited ? .gray : .black)
                                .strikethrough(task.isComplited, color: .gray)
                                
                        })
                    }
                }
                
            }.navigationTitle("Мої завдання")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




