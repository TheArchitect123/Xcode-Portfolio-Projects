//
//  DatabaseService.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import CoreData;

class DatabaseService : NSObject{
    
    //Mappers
    func mapFromDto(_ filmsModel: inout NSManagedObject, _ film: FilmsResultDto) {
        filmsModel.setValue(film.created, forKeyPath: "createdDate");
        filmsModel.setValue(film.director, forKeyPath: "directorName");
        filmsModel.setValue(film.edited, forKeyPath: "editedDate");
        filmsModel.setValue(film.episode_id, forKeyPath: "episodeNum");
        filmsModel.setValue(film.opening_crawl, forKeyPath: "openingDesc");
        // filmsModel.actors = film.characters;
        filmsModel.setValue(film.title, forKeyPath: "movieTitle");
        // filmsModel.actors = film.characters;
        filmsModel.setValue(film.url, forKeyPath: "filmUrl");
        filmsModel.setValue(film.producer, forKeyPath: "producerName");
        filmsModel.setValue(film.release_date, forKeyPath: "releaseDate");
    }
    
    func mapToDto(_ filmsModel: NSManagedObject) -> FilmsResultDto {
        let itemDto = FilmsResultDto.init(dictionary: ["":""]);
        itemDto.created = filmsModel.value(forKey: "createdDate") as! String;
        itemDto.director = filmsModel.value(forKey: "directorName") as! String;
        itemDto.edited = filmsModel.value(forKey: "editedDate") as! String;
        itemDto.episode_id = filmsModel.value(forKey: "episodeNum") as! Int;
        itemDto.opening_crawl = filmsModel.value(forKey: "openingDesc") as! String;
        // itemDto.characters = filmsModel.actors;
        itemDto.title = filmsModel.value(forKey: "movieTitle") as! String;
        //itemDto.characters = filmsModel.actors;
        itemDto.url = filmsModel.value(forKey: "filmUrl") as! String;
        itemDto.producer = filmsModel.value(forKey: "producerName") as! String;
        itemDto.release_date = filmsModel.value(forKey: "releaseDate") as! String;
        
        return itemDto;
    }
    
    #warning("APIS Used for CRUD (Create Read Update Delete) Operations")
    func insertFilm(dto: FilmsResultDto) {
        
        let managedContext = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Films", in: managedContext)!
        
        var filmCarrier = NSManagedObject(entity: entity, insertInto: managedContext);
        self.mapFromDto(&filmCarrier, dto);
        
        managedContext.insert(filmCarrier);
        self.saveContext();
    }
    
    func deleteFilm(dto: String){
        let managedContext =
            self.persistentContainer.viewContext;
        let fetchRequest =
            NSFetchRequest<NSFetchRequestResult>(entityName: "Films")
        do {
            let films = try managedContext.fetch(fetchRequest) as! [NSManagedObject];
            for film in films {
                let item = film.value(forKey: "movieTitle") as! String;
                if(item == "\(dto)"){
                    managedContext.delete(film);
                    try managedContext.save();
                }
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getFilmsCount() -> Int {
        let fetchRequest : NSFetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Films");
        let error : NSError? = nil;
        do {
            let films : Array<FilmsModel> = try self.persistentContainer.viewContext.fetch(fetchRequest) as! Array<FilmsModel>;
            if(films != nil && films.count != 0){
                return films.count;
            }
        }
        catch{
            return 0;
        }
        
        return 0;
    }
    
    func getFilmsFromDb() -> Array<FilmsResultDto>? {
        
        let managedContext =
            self.persistentContainer.viewContext;
        
        let fetchRequest =
            NSFetchRequest<NSFetchRequestResult>(entityName: "Films")
        do {
            let films = try managedContext.fetch(fetchRequest) as! [NSManagedObject];
            
            var items = Array<FilmsResultDto>();
            for film in films {
                items.append(mapToDto(film));
            }
            
            //Sort the dashboard items by films release date
            items = items.sorted(by: { (fr: FilmsResultDto, snd: FilmsResultDto) -> Bool in
                
                let frDate = DateHelper.ConvertToDate(dateString: fr.release_date);
                let sndDate = DateHelper.ConvertToDate(dateString: snd.release_date);
                
                if(frDate != nil && sndDate != nil){
                    return frDate!.timeIntervalSince1970 < sndDate!.timeIntervalSince1970;
                }
                else
                {
                    return true;
                }
            });
            
            return items;
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return Array<FilmsResultDto>();
    }
    
    // MARK: - Initialize Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SWAPIConsumer_Swift")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                //Logging information here
            }
        });
        
        return container
    }();
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                //some logging information goes here
            }
        }
    }
}
