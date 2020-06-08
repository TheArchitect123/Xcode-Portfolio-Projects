//
//  QuickLookDataSource.h
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuickLookDataSource : QLPreviewController<QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@property (strong, nonatomic, readwrite) NSString *_dataPath;

@end

NS_ASSUME_NONNULL_END
