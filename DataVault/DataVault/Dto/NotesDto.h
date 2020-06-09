//
//  NotesDto.h
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData.h>

@interface NotesDto : NSManagedObject

@property(nonatomic, strong, readwrite) NSString* title;
@property(nonatomic, strong, readwrite) NSString* notesDescription;

@end
