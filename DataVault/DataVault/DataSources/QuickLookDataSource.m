//
//  QuickLookDataSource.m
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "QuickLookDataSource.h"
#import <QuickLook/QuickLook.h>

#import <QuickLook/QuickLook.h>
#import <QuickLook/QLBase.h>

@implementation QuickLookDataSource
//Data Source
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id<QLPreviewItem>)item{
    return true;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    
    return [NSURL fileURLWithPath:self._dataPath];
}
@end
