//
//  DatabaseHelper.m
//  DataVault
//
//  Created by Assassin on 9/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "DatabaseHelper.h"
#import <CoreData.h>

//Dtos
#import "NotesDto.h"
#import "PhotosDto.h"
#import "VideosDto.h"
#import "BrowserHistoryDto.h"
#import "MusicAlbumsDto.h"
#import "EmailsDto.h"
#import "PDFsDto.h"
#import "DocumentsDto.h"

@interface DatabaseHelper()

@property (nonatomic, strong, readwrite) NSPersistentContainer* _persistentContainer;

@end

@implementation DatabaseHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializeDatabaseConnection];
    }
    return self;
}

- (void)saveContext {
    NSError *error = nil;
    if (![self._persistentContainer.viewContext save:&error]) {
        //Log some information here for the error
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
    }
}


-(void) initializeDatabaseConnection{
    self._persistentContainer = [[NSPersistentContainer alloc] initWithName:@"DataVault"];
    [self._persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *description, NSError *error) {
        if (error != nil) {
            NSLog(@"Failed to load Core Data stack: %@", error);
        }
    }];
}

#pragma mark - Core Data stack

//Notes
-(void) createNote:(NotesDto *)dto{
    
    //Create the NSManagedObjecrt
    NotesDto *itemDto = [NSEntityDescription insertNewObjectForEntityForName:@"Notes" inManagedObjectContext:self._persistentContainer.viewContext];
    itemDto.title = dto.title;
    itemDto.notesDescription = dto.notesDescription;
    
    [self._persistentContainer.viewContext insertObject:itemDto];
    [self saveContext];
    
}
-(uint) getNotesCount {
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Notes"];
    NSError* error = NULL;
    NSArray<NotesDto *>* notes = [self._persistentContainer.viewContext executeFetchRequest:request error:&error];
    if(error != nil){
        return 0;
    }
    else
        return (uint)notes.count;
}

-(NSArray<NotesDto *>*) getNotesFromDb{
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Notes"];
    NSError* error = NULL;
    NSArray<NotesDto *>* notes = [self._persistentContainer.viewContext executeFetchRequest:request error:&error];
    if(error != nil){
        return NULL;
    }
    else
        return notes;
}

//Photos
-(void) createPhoto:(PhotosDto *)dto{
    PhotosDto *itemDto = [NSEntityDescription insertNewObjectForEntityForName:@"Photos" inManagedObjectContext:self._persistentContainer.viewContext];
    itemDto.name = dto.name;
    itemDto.photoDescription = dto.photoDescription;
    itemDto.created = dto.created;
    itemDto.data = dto.data;
    
    [self._persistentContainer.viewContext insertObject:itemDto];
    [self saveContext];
}
-(NSArray<PhotosDto *>*) getPhotosFromDb{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Photos"];
    NSError* error = NULL;
    NSArray<PhotosDto *>* photos = [self._persistentContainer.viewContext executeFetchRequest:request error:&error];
    if(error != nil){
        return NULL;
    }
    else
        return photos;
}
-(uint) getPhotosCount{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Photos"];
    NSError* error = NULL;
    NSArray<PhotosDto *>* photos = [self._persistentContainer.viewContext executeFetchRequest:request error:&error];
    if(error != nil){
        return 0;
    }
    else
        return (uint)photos.count;
}

////Videos
-(void) createVideo:(VideosDto *)dto{
    VideosDto *itemDto = [NSEntityDescription insertNewObjectForEntityForName:@"Videos" inManagedObjectContext:self._persistentContainer.viewContext];
    itemDto.name = dto.name;
    itemDto.videoDescription = dto.videoDescription;
    itemDto.created = dto.created;
    itemDto.data = dto.data;
    
    [self._persistentContainer.viewContext insertObject:itemDto];
    [self saveContext];
}
-(NSArray<VideosDto *>*) getVideosFromDb{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Videos"];
    NSError* error = NULL;
    NSArray<VideosDto *>* videos = [self._persistentContainer.viewContext executeFetchRequest:request error:&error];
    if(error != nil){
        return NULL;
    }
    else
        return videos;
}

-(uint) getVideosCount{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Videos"];
    NSError* error = NULL;
    NSArray<VideosDto *>* videos = [self._persistentContainer.viewContext executeFetchRequest:request error:&error];
    if(error != nil){
        NSLog(error.localizedDescription);
        return 0;
    }
    else
        return (uint)videos.count;
}

//
//Documents
-(void) createDocument:(DocumentsDto *)dto{
    DocumentsDto *itemDto = [NSEntityDescription insertNewObjectForEntityForName:@"Documents" inManagedObjectContext:self._persistentContainer.viewContext];
    itemDto.name = dto.name;
    itemDto.docDescription = dto.docDescription;
    itemDto.created = dto.created;
    itemDto.data = dto.data;
    itemDto.mime = dto.mime;
    
    [self._persistentContainer.viewContext insertObject:itemDto];
    [self saveContext];
}

-(NSArray<DocumentsDto *>*) getDocumentsFromDb{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Documents"];
    NSError* error = NULL;
    NSArray<DocumentsDto *>* documents = [self._persistentContainer.viewContext executeFetchRequest:request error:&error];
    if(error != nil){
        return NULL;
    }
    else
        return documents;
}

-(uint) getDocumentCount{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"Documents"];
    NSError* error = NULL;
    NSArray<DocumentsDto *>* documents = [self._persistentContainer.viewContext executeFetchRequest:request error:&error];
    if(error != nil){
        return 0;
    }
    else
        return (uint)documents.count;
}
//
//PDFs
-(void) createPDFs:(PDFsDto *)dto{
    PDFsDto *itemDto = [NSEntityDescription insertNewObjectForEntityForName:@"PDFs" inManagedObjectContext:self._persistentContainer.viewContext];
       itemDto.name = dto.name;
       itemDto.smallDescription = dto.smallDescription;
       itemDto.created = dto.created;
       itemDto.data = dto.data;
       
       [self._persistentContainer.viewContext insertObject:itemDto];
       [self saveContext];
}
-(NSArray<PDFsDto *>*) getPDFsFromDb{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"PDFs"];
       NSError* error = NULL;
       NSArray<PDFsDto *>* pdfs = [self._persistentContainer.viewContext executeFetchRequest:request error:&error];
       if(error != nil){
           return NULL;
       }
       else
           return pdfs;
}
-(uint) getPDFsCount{
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"PDFs"];
       NSError* error = NULL;
       NSArray<PDFsDto *>* pdfs = [self._persistentContainer.viewContext executeFetchRequest:request error:&error];
       if(error != nil){
           return 0;
       }
       else
           return (uint)pdfs.count;
}
//
////Browser History
//-(void) createBrowserHistory:(BrowserHistoryDto *)dto{
//
//}
//-(NSArray<BrowserHistoryDto *>*) getBrowserHistoryFromDb{
//
//}
//-(uint) getBrowserHistoryCount{
//
//}
//
////Emails
//-(void) createEmails:(PDFsDto *)dto{
//
//}
//-(NSArray<PDFsDto *>*) getEmailsFromDb{
//
//}
//-(uint) getEmailsCount{
//
//}
//
////Music & Albums
//-(void) createMusic:(PDFsDto *)dto{
//
//}
//-(NSArray<PDFsDto *>*) getMusicAlbumsFromDb{
//
//}
//-(uint) getMusicAlbumsCount{
//
//}
@end
