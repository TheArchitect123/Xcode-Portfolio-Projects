//
//  NotesDataArray.h
//  DataVault
//
//  Created by Assassin on 7/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotesDto.h"

//Helpers
#import "DatabaseHelper.h"

//A series of methods required to manage connecting with the local database & cloud
@interface NotesDataArray : NSMutableArray<NotesDto *>

@property(nonatomic, strong, readwrite) DatabaseHelper* _dbHelper;

@end
