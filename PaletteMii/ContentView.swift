//
//  ContentView.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-06.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Palette.id, ascending: true)],
    animation: .default)
  private var items: FetchedResults<Palette>
  
  var body: some View {
    NavigationView {
      
      VStack {
        HStack {
          ImageColorPicker()
          ImageColorPicker()
          ImageColorPicker()
          ImageColorPicker()
          ImageColorPicker()
        }
        
        
        List {
          ForEach(items) { item in
            NavigationLink {
              HStack {
                Text("Item at \(item.title!)")
                
                ForEach(PersistenceController.shared.toColorHexArray(item.colorHexes), id: \.self) { color in
                  Text(color.hex!)
                }
                
                ForEach(PersistenceController.shared.toTagsArray(item.tags), id: \.self) { tag in
                  Text(tag.name!)
                }
              }
            } label: {
              HStack {
                Image(systemName: "person")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 100, height: 100)
                  .cornerRadius(30)
                
                VStack(alignment: .leading) {
                  Text(item.title!)
                  
                  HStack {
                    ForEach(PersistenceController.shared.toColorHexArray(item.colorHexes), id: \.self) { color in
                      Text(color.hex!)
                    }
                  }
                  
                  HStack {
                    ForEach(PersistenceController.shared.toTagsArray(item.tags), id: \.self) { tag in
                      Text(tag.name!)
                    }
                  }
                }
              }
            }
          }
          .onDelete(perform: deleteItems)
        }
        .listStyle(.plain)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            EditButton()
          }
          ToolbarItem {
            Button(action: addItem) {
              Label("Add Item", systemImage: "plus")
            }
          }
        }
        Text("Select an item")
      }
      .onAppear {
        //PersistenceController.shared.addSampleData(viewContext: viewContext)
      } // END: list
      }
    
    
  }
  
  private func addItem() {
    withAnimation {
      let newItem = Palette(context: viewContext)
      newItem.title = "Added sample"
      
      do {
        try viewContext.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      offsets.map { items[$0] }.forEach(viewContext.delete)
      
      do {
        try viewContext.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
}

private let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
