//
//  ContentView.swift
//  MyDay
//

import SwiftUI
import CoreData



struct ContentView: View {
    
    @Environment (\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: TaskViewModel
    
    init(context: NSManagedObjectContext){
        _viewModel = StateObject(wrappedValue: TaskViewModel(context: context))
    }
    
    var body: some View {
        
        NavigationView{
            VStack{
                HStack(alignment: .center, spacing: 8){
                    
                    TextEditor(text: $viewModel.newTaskName)
                        .frame(minHeight: 20, maxHeight: 60)
                        .padding(8)
                        .border(Color.cyan)
                        .cornerRadius(8)
                        .padding()
                    
                    Button(action: viewModel.addTask){
                        Text("+")
                            .frame(maxWidth: 30, minHeight: 70)
                            .padding(.horizontal)
                            .background(Color.cyan)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        
                        
                    }.padding(.trailing, 8.0).frame(width: 60.0)
                }
                List {
                    ForEach(viewModel.tasks){ task in
                        HStack(alignment: .center){
                            Button(action:{
                                viewModel.toggleTaskCompletion(task)
                            }){
                                Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                                    .foregroundColor(task.isCompleted ? .gray : .gray)
                                    .font(.title)
                                
                            }.buttonStyle(PlainButtonStyle())
                            
                            TextEditor(text: Binding(
                                get: { task.name ?? "" },
                                set: { newValue in
                                    task.name = newValue
                                    viewModel.toggleTaskCompletion(task)
                                }
                            ))
                            .font(.body)
                            .foregroundColor( task.isCompleted ? .gray : .primary)
                            .strikethrough(task.isCompleted, color: .gray)
                            .frame(minHeight: 20, maxHeight: 80)
                            .disabled(task.isCompleted)
                        }
                        .frame(maxHeight: .infinity, alignment: .center)
                        .padding(.vertical, 2)
                    }.onDelete(perform: viewModel.deleteTask)
                }
                
                
                Button(action: viewModel.deleteCompletedTasks) {
                    Text("Refresh")
                        .foregroundColor(.red)
                }
                
            }.navigationTitle("My day")
        }
    }
    
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let previewContext = PersistenceController.shared.container.viewContext
        
        ContentView(context: previewContext)
            .environment(\.managedObjectContext, previewContext)
    }
}




