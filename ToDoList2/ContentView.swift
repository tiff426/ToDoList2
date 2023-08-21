//
//  ContentView.swift
//  ToDoList2
//
//  Created by Scholar on 8/21/23.
//

import SwiftUI

struct ContentView: View {
    
    // getting our code to allow us to delete items
    @Environment(\.managedObjectContext) var context
    
    //@State var toDoItems : [ToDoItem] = []
    // when we use Core Data we ask core data to fetch the tasks/info for us, so we don;t need ana rray to keep track of it anymore
    @FetchRequest(entity: ToDo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ToDo.id, ascending: false)])
    // ^^passing in keypath...ascending: false into NSSortDescriptor is us telling Core Data to sor our data by the id of each
    var toDoItems : FetchedResults<ToDo>
    
    // this variable keeps track of if we want NewToDoView to open or not (basically if the user is trying to add a new task)
    @State private var showNewTask : Bool = false
    
    // we need to be able to access ToDoItem class in this file, so we create empty array that holds ToDoItem objects, represents the lsit of to do list tasks
    //has to be state variable because it'll change when user inputs information

    
    var body: some View {
            
        VStack {
            HStack {
                Text("To Do List!")
                    .font(.system(size: 40))
                    .fontWeight(.black)
                Spacer() //pushes elements to both sides
                //different way of creating a button
                Button(action: {
                    // when this button gets pressed, we want the new view to show, so true
                    self.showNewTask = true
                }) {
                    Text("+")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                }
                
            }
            .padding()
            Spacer() //push title and add button to top
        }
        
        // list view to show all tasks
        List {
            ForEach(toDoItems) { toDoItem in
                if toDoItem.isImportant == true {
                    //  instead of force unwrapping using !, use ?? which allows us to unwrap and provide an alternative if there is no value
                    Text("‼️" +  (toDoItem.title ?? "No title"))
                } else {
                    Text((toDoItem.title ?? "No title"))
                }
            }.onDelete(perform: deleteTask) // telling code that when delete is pressed in the List view, then we run the deleteTask function using core data
        }
        
        if showNewTask {
            // these values won't actually be the real values for title and isImportant, we jsut need to give it something to run, but in that view the values will be updated
            // when we use core data and not the array, we don't need to bind the array anymore, so do...
           // NewToDoView(title: "", isImportant: false, toDoItems: $toDoItems, showNewTask : $showNewTask)
            NewToDoView(title: "", isImportant: false, showNewTask: $showNewTask)
        }
    }
    
    // function to delete tasks in ContentView because we'll be deleting views from this UI
    // this function is included if you create a project with Core Data
    private func deleteTask(offsets: IndexSet) {
        withAnimation{
            offsets.map {toDoItems[$0]}.forEach(context.delete)
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
