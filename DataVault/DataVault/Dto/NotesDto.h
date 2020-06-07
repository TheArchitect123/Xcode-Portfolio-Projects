//
//  NotesDto.h
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NotesDto : NSObject

@property(nonatomic, strong, readwrite) NSString* Title;
@property(nonatomic, strong, readwrite) NSString* Description;

@end
