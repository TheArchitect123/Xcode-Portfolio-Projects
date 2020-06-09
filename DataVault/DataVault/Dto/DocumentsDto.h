//
//  DocumentsDto.h
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData.h>

@interface DocumentsDto : NSManagedObject

@property(nonatomic, strong, readwrite) NSString* name;
@property(nonatomic, strong, readwrite) NSString* docDescription;
@property(nonatomic, strong, readwrite) NSData* data;
@property(nonatomic, strong, readwrite) NSString* created;
@property(nonatomic, strong, readwrite) NSString* mime;

@end

