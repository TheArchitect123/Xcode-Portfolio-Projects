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
    
    override init() {
        
    }
    

    //Mappers
    func mapFromDto(_ filmsModel: inout FilmsModel, _ film: FilmsResultDto) -> FilmsResultDto? {
        let itemDto = FilmsModel.init();
        itemDto.createdDate = film.created;
        itemDto.directorName = film.director;
        itemDto.editedDate = film.edited;
        itemDto.episodeNum = film.episode_id;
        itemDto.openingDesc = film.opening_crawl;
        itemDto.actors = film.characters;
        itemDto.movieTitle = film.title;
        itemDto.actors = film.characters;
        itemDto.filmUrl = film.url;
        itemDto.producerName = film.producer;
        itemDto.releaseDate = film.release_date;
        
        return nil;
    }
    
    func mapToDto(_ filmsModel: FilmsModel) -> FilmsResultDto? {
        let itemDto = FilmsResultDto.init(dictionary: ["":""]);
        itemDto.created = filmsModel.createdDate;
        itemDto.director = filmsModel.directorName;
        itemDto.edited = filmsModel.editedDate;
        itemDto.episode_id = filmsModel.episodeNum ;
        itemDto.opening_crawl = filmsModel.openingDesc;
        itemDto.characters = filmsModel.actors;
        itemDto.title = filmsModel.movieTitle;
        itemDto.characters = filmsModel.actors;
        itemDto.url = filmsModel.filmUrl ;
        itemDto.producer = filmsModel.producerName ;
        itemDto.release_date = filmsModel.releaseDate;
        
        
        return nil;
    }
    
    #warning("APIS Used for CRUD (Create Read Update Delete) Operations")
    func insertFilm(dto: FilmsResultDto) {
        
        var itemDto : FilmsModel = NSEntityDescription.insertNewObject(forEntityName: "Films", into: self.persistentContainer.viewContext) as! FilmsModel;
        self.mapFromDto(&itemDto, dto); //Bind the Data (as pass by reference)
        
        self.persistentContainer.viewContext.insert(itemDto);
        self.saveContext();
    }

    func deleteFilm(dto: Int){
        let fetchRequest : NSFetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Films");
        fetchRequest.predicate = NSPredicate.init(format: "", dto);
        
        var itemDto : FilmsModel = NSEntityDescription.insertNewObject(forEntityName: "Films", into: self.persistentContainer.viewContext) as! FilmsModel;
        
        self.persistentContainer.viewContext.delete(fetchRequest);
             self.persistentContainer.viewContext.insert(itemDto);
             self.saveContext();
    }

    
    func getFilmsCount() -> Int {
        let fetchRequest : NSFetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Films");
        let error : NSError? = nil;
        do {
            let films : Array<FilmsModel> = try self.persistentContainer.viewContext.execute(fetchRequest) as! Array<FilmsModel>;
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
        //Get the results from FilmsResultDto and map it to the FilmsModel
        let fetchRequest : NSFetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Films");
        let error : NSError? = nil;
        do {
            let films : Array<FilmsModel> = try self.persistentContainer.viewContext.execute(fetchRequest) as! Array<FilmsModel>;
            if(films != nil && films.count != 0){
                return films.map { (result: FilmsModel) -> FilmsResultDto in
                    return self.mapToDto(result)!;
                };
            }
        }
        catch{
            
        }
        
        return nil;
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
