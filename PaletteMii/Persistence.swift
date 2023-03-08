//
//  Persistence.swift
//  PaletteMii
//
//  Created by Kaori Persson on 2023-03-06.
//

import CoreData

struct PersistenceController {
  static let shared = PersistenceController()
  
  static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext
    
    for _ in 0..<10 {
      let newItem = Palette(context: viewContext)
      newItem.id = UUID().uuidString
      newItem.title = "Sample"
    }
    
    do {
      try viewContext.save()
    } catch {
      // Replace this implementation with code to handle the error appropriately.
      // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
  }()
  
  let container: NSPersistentContainer
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "PaletteMii")
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    container.viewContext.automaticallyMergesChangesFromParent = true
  }
  
  
  func addSampleData(viewContext: NSManagedObjectContext) {
    
    /// 新しいpaletteList
    let paletteLists: [(String, [String])] = [
      ("my palette1", ["93AEC1", "FF0000", "00FF00"]),
      ("my palette2", ["9DBDBA", "00FFFF", "FF0000"]),
      ("my palette3", ["F8B042", "FF00FF", "00FFFF"])
    ]
    /// Paletteテーブル全消去
    let fetchRequestPalette = NSFetchRequest<NSFetchRequestResult>(entityName: "Palette")
    fetchRequestPalette.entity = Palette.entity()
    let palettes = try? viewContext.fetch(fetchRequestPalette) as? [Palette]
    for palette in palettes! {
      viewContext.delete(palette)
    }
    
    /// Paletteテーブル登録
    for (title, colorHexList) in paletteLists {
      let newPalette = Palette(context: viewContext)
      newPalette.id = UUID().uuidString
      newPalette.title = title
      
      // register colorHexes
      for colorHex in colorHexList {
        let fetchRequestColorHex = NSFetchRequest<NSFetchRequestResult>(entityName: "ColorHex")
        fetchRequestColorHex.entity = ColorHex.entity()
        fetchRequestColorHex.predicate = NSPredicate(format: "hex = %@", colorHex)
        let result = try? viewContext.fetch(fetchRequestColorHex) as? [ColorHex]
        if let existingColorHex = result?.first {
          /// 既に存在している場合はそれを使用
          newPalette.addToColorHexes(existingColorHex)
        } else {
          /// 存在しない場合は新規に作成
          let newColorHex = ColorHex(context: viewContext)
          newColorHex.hex = colorHex
          newPalette.addToColorHexes(newColorHex)
        }
      } // END: colorHex
      
    }
    
    
    
    //
    //    for _ in 0..<10 {
    //      let newItem = Palette(context: viewContext)
    //      newItem.id = UUID().uuidString
    //      newItem.title = "Sample"
    //    }
    do {
      try viewContext.save()
    } catch {
      // Replace this implementation with code to handle the error appropriately.
      // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }
  
  
  /// NSSet? → [ColorHex]変換
  func toColorHexArray(_ colorHexes: NSSet?) -> [ColorHex] {
    guard let colorHexes = colorHexes as? Set<ColorHex> else {
      return []
    }
    return Array(colorHexes)
  }
  
}
