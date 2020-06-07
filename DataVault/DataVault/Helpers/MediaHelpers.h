//
//  MediaHelpers.h
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MediaHelpers : NSObject

+(void) selectVideoGallery:(UIViewController *)parentController;
+(void) selectPhotoGallery:(UIViewController *)parentController;
+(void) takePhotoFromCamera:(UIViewController *)parentController;
+(void) takeVideoFromCamera:(UIViewController *)parentController;

//Documents & PDFs
+(void) takePDFFromLocalDevice:(UIViewController *)parentController;
+(void) takeDocumentFromLocalDevice:(UIViewController *)parentController;

//Notes
+(void) beginCreateNote:(UIViewController *)parentController;

@end
