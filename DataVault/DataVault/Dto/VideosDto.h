//
//  VideosDto.h
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData.h>

@interface VideosDto : NSManagedObject

@property(nonatomic, strong, readwrite) NSString* name;
@property(nonatomic, strong, readwrite) NSString* videoDescription;
@property(nonatomic, strong, readwrite) NSData* data;
@property(nonatomic, strong, readwrite) NSString* created;

@end
