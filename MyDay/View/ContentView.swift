//
//  ContentView.swift
//  MyDay
//

import SwiftUI
import CoreData



struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors:[NSSortDescriptor(keyPath: \Task.isCompleted, ascending: true)]
    ) var tasks: FetchedResults<Task>
    
    var body: some View {
        
        NavigationView {
            VStack{
                
                Button(action: addTask) {
                    Text("Add")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                    
                }
                
                List {
                    ForEach(tasks) {task in
                        HStack {
                            Toggle(isOn: Binding(
                                get: { task.isCompleted },
                                set: { newValue in
                                    task.isCompleted = newValue
                                    saveContext()
                                }
                                
                            )) {
                                TextField("Назва завдання", text: Binding(
                                    get: { task.name ?? "" },
                                    set: { newValue in
                                        task.name = newValue
                                        saveContext()
                                    }
                                ))
                                .font(.body)
                                .foregroundColor(task.isCompleted ? .gray : .primary)
                                .strikethrough(task.isCompleted, color: .gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteTasks)
                    
                }
                
            }.navigationTitle("Мої завдання")
        }
    }
    
    private func addTask (){
        
        let newTask = Task(context: viewContext)
        newTask.id = UUID()
        newTask.name = "New task"
        newTask.isCompleted = false
        saveContext()
        
    }
    
    private func saveContext(){
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Error: \(nsError)")
        }
    }
    
    private func deleteTasks(offsets: IndexSet){
        
        offsets.map { tasks[$0] }.forEach(viewContext.delete)
        saveContext()
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




