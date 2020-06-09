//
//  NotesDashSource.h
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Dto
#import "NotesDto.h"

//Custom
#import "NotesDataArray.h"

@interface NotesDashSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong, readwrite) UIViewController* _parentController;
@property(nonatomic, strong, readwrite) NSMutableArray<NotesDto *>* _dataArray;
@property(nonatomic, strong, readwrite) DatabaseHelper* _dbHelper;

-(void) createNewNote:(NSString *)title description:(NSString *) descriptionRef;

@end
