//
//  DatabaseHelper.h
//  DataVault
//
//  Created by Assassin on 9/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
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

NS_ASSUME_NONNULL_BEGIN

@interface DatabaseHelper : NSObject
//Notes
-(void) createNote:(NotesDto *)dto;
-(uint) getNotesCount;
-(NSArray<NotesDto *>*) getNotesFromDb;

//Photos
-(void) createPhoto:(PhotosDto *)dto;
-(NSArray<PhotosDto *>*) getPhotosFromDb;
-(uint) getPhotosCount;

//Videos
-(void) createVideo:(VideosDto *)dto;
-(NSArray<VideosDto *>*) getVideosFromDb;
-(uint) getVideosCount;

//Documents
-(void) createDocument:(DocumentsDto *)dto;
-(NSArray<DocumentsDto *>*) getDocumentsFromDb;
-(uint) getDocumentCount;

//PDFs
-(void) createPDFs:(PDFsDto *)dto;
-(NSArray<PDFsDto *>*) getPDFsFromDb;
-(uint) getPDFsCount;

//Browser History
-(void) createBrowserHistory:(BrowserHistoryDto *)dto;
-(NSArray<BrowserHistoryDto *>*) getBrowserHistoryFromDb;
-(uint) getBrowserHistoryCount;

//Emails
-(void) createEmails:(PDFsDto *)dto;
-(NSArray<PDFsDto *>*) getEmailsFromDb;
-(uint) getEmailsCount;

//Music & Albums
-(void) createMusic:(PDFsDto *)dto;
-(NSArray<PDFsDto *>*) getMusicAlbumsFromDb;
-(uint) getMusicAlbumsCount;

@end

NS_ASSUME_NONNULL_END
