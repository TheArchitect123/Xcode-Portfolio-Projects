//
//  DocumentPreviewerViewController.h
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <QuickLook/QuickLook.h>

#import "QuickLookDataSource.h"

@interface DocumentPreviewerViewController : QLPreviewController<QLPreviewControllerDataSource, QLPreviewControllerDelegate>
@property (strong, nonatomic, readwrite) IBOutlet WKWebView *_docPreviewer;
//@property (strong, nonatomic, readwrite) NSData *_dataArray;
@property (strong, nonatomic, readwrite) NSString *_dataPath;
@property (strong, nonatomic, readwrite) QuickLookDataSource *_dataSource;

@end
