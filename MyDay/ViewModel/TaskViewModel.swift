//
//  TaskViewModel.swift
//  MyDay


import Foundation
import CoreData
import SwiftUI


class TaskViewModel: ObservableObject {
    
    @Published var tasks:[Task] = []
    @Published var newTaskName: String = ""
    
    private var viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchTasks()
        
    }
    
    func fetchTasks(){
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Task.isCompleted, ascending: true)]
        
        do{
            tasks = try viewContext.fetch(fetchRequest)
        }catch{
            print("\(error.localizedDescription)")
        }
    }
    
    func addTask(){
        
        guard !newTaskName.isEmpty else {return}
        
        let newTask = Task(context: viewContext)
        newTask.id = UUID()
        newTask.name = newTaskName
        newTask.isCompleted = false
        
        saveContext()
        newTaskName = ""
        fetchTasks()
        
    }
    
    func toggleTaskCompletion(_ task: Task){
        
        task.isCompleted.toggle()
        saveContext()
        fetchTasks()
        
    }
    
    func deleteTask(at offsets: IndexSet){
        
        offsets.map { tasks[$0] }.forEach(viewContext.delete)
        saveContext()
        fetchTasks()
        
    }
    
    func deleteCompletedTasks(){
        for task in tasks where task.isCompleted {
            viewContext.delete(task)
        }
        saveContext()
        fetchTasks()
    }
    
    func saveContext(){
        
        do{
            try viewContext.save()
        }catch{
            print("\(error.localizedDescription)")
        }
        
    }
    
}



