//
//  MimeHelper.m
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "MimeHelper.h"

@implementation MimeHelper
+(NSString *) getMimeOfFile:(NSString *)extension{
    
    if([extension isEqualToString: @"doc"] || [extension isEqualToString: @"docx"]){
         return @"com.microsoft.word.doc";
    }
    else if([extension isEqualToString: @"xls"] || [extension isEqualToString: @"xlsx"]){
         return @"com.microsoft.excel.xls";
    }
    else if([extension isEqualToString: @"ppt"] || [extension isEqualToString: @"pptx"]){
         return @"com.microsoft.powerpoint.​ppt";
    }
    else if([extension isEqualToString: @".key"]){
         return @"com.apple.keynote.key";
    }
    else {
         return @"public.text";
    }
    
    return @"";
}

+(NSString *) getExtensionOfMime:(NSString *)mime{
    
    if([mime isEqualToString: @"com.microsoft.word.doc"]){
         return @"doc";
    }
    else if([mime isEqualToString: @"com.microsoft.excel.xls"]){
         return @"xls";
    }
    else if([mime isEqualToString: @"com.microsoft.powerpoint.​ppt"]){
         return @"​ppt";
    }
    else if([mime isEqualToString: @"com.apple.keynote.key"]){
         return @"key";
    }
    
    return @"";
}
@end
