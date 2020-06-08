//
//  DocumentPreviewerViewController.m
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "DocumentPreviewerViewController.h"
#import "QuickLookDataSource.h"

#import <QuickLook/QuickLook.h>
#import <QuickLook/QLBase.h>

#import <WebKit/WebKit.h>
#import "MimeHelper.h"
@implementation DocumentPreviewerViewController

- (void)viewDidLoad {
    //[super viewDidLoad];
    // Do any additional setup after loading the view.
    
//         [docsReviewController._docPreviewer loadData:self._dataDocumentArray[index].data MIMEType:self._dataDocumentArray[index].mime characterEncodingName:@"UTF-8" baseURL:nil];
    //self._dataSource = [[QuickLookDataSource alloc] init];
    //self._dataSource._dataPath = self._dataPath;
//
    self.dataSource = self;
    self.delegate = self;
    
    [self previewController:self previewItemAtIndex:0];
}

-(void) viewDidAppear:(BOOL)animated{
//    [self._docPreviewer loadData:self._dataArray MIMEType:[MimeHelper getMimeOfFile:@"doc"] characterEncodingName:@"UTF-8" baseURL:nil];
}

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    
    return [NSURL fileURLWithPath:self._dataPath];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
