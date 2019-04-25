//
//  DataService.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 3/27/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import CoreData

open class INJDataService: INJService {
    private static var containers:[String: (inst: NSPersistentContainer, count: Int)] = [:]
    
    private var managedObject:NSManagedObject!
    private var persistentContainer: NSPersistentContainer!
    private var entityName: String!
    private var managedObjectClass: NSManagedObject.Type!
    
    public func initModel(containerName: String, entityName: String, managedObjectClass: NSManagedObject.Type) {
        self.entityName = entityName
        self.managedObjectClass = managedObjectClass
        
        initContainer(containerName)
    }
    
    // <<<<<<<<<<<<<<<<<<<<<<<<< fetch >>>>>>>>>>>>>>>>>>>>>>>>>
    public func fetch() -> [NSManagedObject]? {
        return self.fetch(unique: "", value: "")
    }
    
    public func fetch(unique: String, value: String) -> [NSManagedObject]? {
        let fetchRequest = createFetchRequest(unique, value)
        let managedContext = persistentContainer.viewContext
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            return result as? [NSManagedObject]
        }catch {
            print("❌ DataService::fetch \(error)");
        }
        
        return nil
    }
    
    public func fetchAsync(_ complete: @escaping ([NSManagedObject])->Void) {
        self.fetchAsync(unique: "", value: "", complete)
    }
    
    public func fetchAsync(unique: String, value: String, _ complete: @escaping ([NSManagedObject])->Void) {
        let fetchRequest = createFetchRequest(unique, value)
        
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) {
            asynchronousFetchResult in
            
            guard let result = asynchronousFetchResult.finalResult as? [NSManagedObject] else { return }
            
            complete(result)
        }
        
        do {
            try persistentContainer.viewContext.execute(asynchronousFetchRequest)
        }catch {
            print("❌ DataService::fetchAsync \(error)")
        }
    }
    
    private func createFetchRequest(_ unique: String, _ value: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        if !unique.isEmpty && !value.isEmpty {
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "\(unique) = %@", value)
            fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "\(unique)", ascending: false)]
        }
        
        return fetchRequest
    }
    // <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    
    public func create(data: NSManagedObject) {
        guard let description = NSEntityDescription.entity(forEntityName: entityName, in: persistentContainer.viewContext) else { return }
//
        let manager = NSManagedObject(entity: description, insertInto: persistentContainer.viewContext)
        
        for (key, value) in data.changedValues() {
            manager.setValue(value, forKey: key)
        }
    }
    
    public func delete(unique: String, value: String) {
        let fetchRequest = createFetchRequest(unique, value)
        let managedContext = persistentContainer.viewContext
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            if result.count > 0 {
                let deleteObj = result[0] as! NSManagedObject
                
                managedContext.delete(deleteObj)
            }else {
                print("⁉️ DataService::delete not exist \"\(unique)\"");
            }
        
        }catch {
            print("❌ DataService::delete \"\(unique)\" \(error)");
        }
    }
    
    public func generateObject() -> NSManagedObject {
        return (managedObjectClass.init(context: persistentContainer.viewContext))
    }
    
    public func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                
                print("✅ INJDataService::save model, \(String(describing: entityName!)) saved")
            } catch {
                let nserror = error as NSError
                fatalError("❌ Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func initContainer(_ name: String) {
        var container: NSPersistentContainer
        
        guard var containerData = INJDataService.containers[name] else {
            //        let identifier = Bundle(for: type(of: self)).bundleIdentifier
            //        let bundle = Bundle(identifier: identifier)
            let bundle = Bundle(for: type(of: self))
            let modelURL = bundle.url(forResource: name, withExtension: "momd")!
            
            if let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL) {
                container = NSPersistentContainer(name: name, managedObjectModel: managedObjectModel)
                
                container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                    if let error = error as NSError? {
                        fatalError("Unresolved error \(error), \(error.userInfo)")
                    }
                })
                
                persistentContainer = container
                
                INJDataService.containers[name] = (persistentContainer, 1)                
            }
            
            return
        }
        
        containerData.count += 1
        
        persistentContainer = containerData.inst
    }
    
    #if DEBUG
    public func printDataBaseURL() {
        print(persistentContainer.persistentStoreDescriptions.first?.url! as Any)
    }
    #else
    #endif
}
