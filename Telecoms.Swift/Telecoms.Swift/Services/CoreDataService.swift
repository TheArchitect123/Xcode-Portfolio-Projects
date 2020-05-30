//
//  CoreDataService.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import CoreData;
import CoreFoundation;

class CoreDataService {
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Telecoms_Swift")
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
        return container
    }()
    
    
    // MARK: - Core Data Read Apis
    func GetContainerConnection() -> NSPersistentContainer{
        return persistentContainer;
    }
    
    // MARK: Core Data Create (Insert) Apis
    func PersistDataOnDisk(cityID : Int) {
        
        LoaderHelper.ShowLoaderWithMessage("Persisting item into Core Data Layer");
        let managedContext =
            self.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "WeatherRef", in: managedContext)!
        
        let cityCarrier = NSManagedObject(entity: entity,
                                          insertInto: managedContext)
        cityCarrier.setValue("\(cityID)", forKeyPath: "id")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error persisting item to disk");
        }
        
        LoaderHelper.DismissLoaderWithDefault();
    }
    
    func GetDataOnDisk() -> [String] {
        
        let managedContext =
            self.persistentContainer.viewContext;
        
        
        let fetchRequest =
            NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherRef")
        do {
            let ids = try managedContext.fetch(fetchRequest) as! [NSManagedObject];

            var items = [String]();
            for id in ids {
                items.append((id.value(forKey: "id") as! String));
            }
            
            return items;
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return Array<String>();
    }
    
    
    // MARK: - Core Data Saving support
    func saveContext () {
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
