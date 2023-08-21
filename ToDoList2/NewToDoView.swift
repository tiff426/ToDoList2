//
//  NewToDoView.swift
//  ToDoList2
//
//  Created by Scholar on 8/21/23.
//

import SwiftUI

struct NewToDoView: View {
    
    // save our new task to core data
    @Environment(\.managedObjectContext) var context
    
    //state variables allow for these values to be changed and so the lsit can be refreshed whenever there are changes
    @State var title : String
    @State var isImportant : Bool
    
  //  @Binding var toDoItems : [ToDoItem]
    @Binding var showNewTask : Bool
    
    var body: some View {
        VStack {
            Text("Task title: ")
                .font(.title)
                .fontWeight(.bold)
            
            // double bind so that whatever user inputs gets stored in title variable
            TextField("Enter the task description...", text: $title)
                    .padding()
                .background(Color(.systemGroupedBackground))
                .cornerRadius(15)
                    .padding()
            
            // if the user inputs toggle on then that gives us our value for isImportant, so double binding
            Toggle(isOn: $isImportant) {
                Text("Is it important?")
            }
            .padding()
            
            // button to add task when info has been inputted
            //i think this all works without self.??
            Button(action: {
                self.addTask(title: self.title, isImportant: self.isImportant)
                self.showNewTask = false
            }) {
                Text("Add")
            }
            .padding()

        }
    }
    private func addTask(title: String , isImportant: Bool = false) {
        // we aren't adding a ToDo object to an array anymore
        //let task = ToDoItem(title: title, isImportant: isImportant)
        //toDoItems.append(task)
        
        // a new ToDo object gets created and then stored to core data using the save() function of context
        let task = ToDo(context: context)
        task.id = UUID()
        task.title = title
        task.isImportant = isImportant
        do {
            try context.save()
        } catch {
            print(error)
        }

    }
}

struct NewToDoView_Previews: PreviewProvider {
    static var previews: some View {
        //when the preview tries to run, we need to give the code everyting it needs, including those variables
        NewToDoView(title : "", isImportant : false, /* toDoItems: .constant([]),*/ showNewTask: .constant(true))
    }
}
