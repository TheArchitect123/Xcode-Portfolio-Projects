//
//  MimeHelper.h
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MimeHelper : NSObject
+(NSString *) getMimeOfFile:(NSString *)extension;
+(NSString *) getExtensionOfMime:(NSString *)mime;
@end

NS_ASSUME_NONNULL_END
