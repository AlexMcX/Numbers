//
//  DataService.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 3/27/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import CoreData

public class INJDataService: INJService {
    private var managedObject:NSManagedObject!
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "client")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func initModel(entityName:String, managedObjectClass:NSManagedObject.Type) {
        var model:INJInjectableInstance
        let managedContext = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            if (result.count == 0) {
                model = (managedObjectClass.init(context: managedContext)) as! INJInjectableInstance
                
                print("DataService::initModel - create new model \(entityName)")
            }else {
                model = result[0] as! INJInjectableInstance
                
                print("DataService::initModel - read model \(entityName)")
            }
            
            managedObject = model as? NSManagedObject
            
            model.register()
        }catch {
            print("DataService:: \(error)");
        }
    }
    
    private func updateModel() {
//        let changes = managedObject.changedValues()
//        
//        print("HAS CHANGES: count:\(changes.count)")
//        
//        print(managedObject)
    }
    
//    private func createEntity(entityName: String) {
//        guard let description = NSEntityDescription.entity(forEntityName: entityName, in: persistentContainer.viewContext) else { return }
//
//        let manager = NSManagedObject(entity: description, insertInto: persistentContainer.viewContext)
//
////        manager.setValue("init", forKey: "true")
////        manager.setValue("uuid1002", forKey: "uuid")
//
//        save()
//
//        print("DataService::createEntity - \(entityName)")
//    }
    
//    func initModel(entityName:String) {
//        guard let description = NSEntityDescription.entity(forEntityName: entityName, in: persistentContainer.viewContext) else { return }
//
//        managed = NSManagedObject(entity: description, insertInto: persistentContainer.viewContext)
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//
//        let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) {
//            asynchronousFetchResult in
//
//            guard let result = asynchronousFetchResult.finalResult as? [Client] else { return }
//
//            print("async: \(result.count)")
//
////            if (result.count > 0) {
////                InjectionManager.instance.registerInjection(injector: result[0])
////            }
//        }
//
//        do {
//            try persistentContainer.viewContext.execute(asynchronousFetchRequest)
//        }catch {
//            print("Error \(error)")
//        }
//    }
    
    
//    override func onInit() {
//        
//    }
    
    // PUBLIC
    public func save() {
        updateModel()
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
