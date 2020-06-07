//
//  MediaHelpers.m
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "MediaHelpers.h"
#import "NotesPostViewController.h";

//Apple
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

//Helpers
#import "SnackBarHelper.h"

@implementation MediaHelpers

+(void) selectVideoGallery:(UIViewController *)parentController{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
           if(status == PHAuthorizationStatusAuthorized){
               dispatch_async(dispatch_get_main_queue(), ^{
                   UIImagePickerController* photoPicker = [[UIImagePickerController alloc] init];
                   photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                   photoPicker.modalPresentationStyle = UIModalPresentationFullScreen;
                   photoPicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];

                   [parentController presentViewController:photoPicker animated:true completion:nil];
               });
           }
           else {
               [SnackBarHelper showSnackBarWithCustomBtnActionedMessage:@"Photo Gallery Access is required to use this feature" buttonTitle:@"Change" invokedAction:^{
                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
               }];
           }
       }];
}

+(void) selectPhotoGallery:(UIViewController *)parentController{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if(status == PHAuthorizationStatusAuthorized){
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImagePickerController* photoPicker = [[UIImagePickerController alloc] init];
                    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    photoPicker.modalPresentationStyle = UIModalPresentationFullScreen;
                
                    [parentController presentViewController:photoPicker animated:true completion:nil];
                });
            }
            else {
                [SnackBarHelper showSnackBarWithCustomBtnActionedMessage:@"Photo Gallery Access is required to use this feature" buttonTitle:@"Change" invokedAction:^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }];
            }
        }];
}

+(void) takePhotoFromCamera:(UIViewController *)parentController{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
           if(granted){
               dispatch_async(dispatch_get_main_queue(), ^{
                   UIImagePickerController* cameraTaker = [[UIImagePickerController alloc] init];
                   cameraTaker.sourceType = UIImagePickerControllerSourceTypeCamera;
                   cameraTaker.modalPresentationStyle = UIModalPresentationFullScreen;
                   
                   cameraTaker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
                   cameraTaker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                   cameraTaker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
                   
                   [parentController presentViewController:cameraTaker animated:true completion:nil];
               });
           }
           else {
               [SnackBarHelper showSnackBarWithCustomBtnActionedMessage:@"Camera Access is required to use this feature" buttonTitle:@"Change" invokedAction:^{
                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
               }];
           }
       }];
}
+(void) takeVideoFromCamera:(UIViewController *)parentController{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
           if(granted){
               dispatch_async(dispatch_get_main_queue(), ^{
                   UIImagePickerController* cameraTaker = [[UIImagePickerController alloc] init];
                   cameraTaker.sourceType = UIImagePickerControllerSourceTypeCamera;
                   cameraTaker.modalPresentationStyle = UIModalPresentationFullScreen;
                   
                   cameraTaker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
                   cameraTaker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                   cameraTaker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
                   
                   [parentController presentViewController:cameraTaker animated:true completion:nil];
               });
           }
           else {
               [SnackBarHelper showSnackBarWithCustomBtnActionedMessage:@"Camera Access is required to use this feature" buttonTitle:@"Change" invokedAction:^{
                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
               }];
           }
       }];
}

//Documents & PDFs
+(void) takePDFFromLocalDevice:(UIViewController *)parentController{
    UIDocumentPickerViewController* documentBrowser = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"com.adobe.pdf"] inMode:UIDocumentPickerModeImport];
       [parentController presentViewController:documentBrowser animated:true completion:nil];
    
}
+(void) takeDocumentFromLocalDevice:(UIViewController *)parentController{
    UIDocumentPickerViewController* documentBrowser = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.presentation", @"com.microsoft.word.doc",@"com.microsoft.excel.xls",@"com.microsoft.powerpoint.​ppt"] inMode:UIDocumentPickerModeImport];
       [parentController presentViewController:documentBrowser animated:true completion:nil];
}

+(void) beginCreateNote:(UIViewController *)parentController{
    UIStoryboard* storyRef = [UIStoryboard storyboardWithName:@"SafetyBoxStory" bundle:nil];
    
    //Controllers
    NotesPostViewController *notesPostController = [storyRef instantiateViewControllerWithIdentifier:@"NotesPostViewController"];
    
    //Opens up an action sheet with a set of options, and a small note sample to add content
    notesPostController.completionBlock = ^(NSString *s, NSString *e) {
        //Take the strings from the post page, and add it to the database
        
        
    };
    
    [parentController.navigationController pushViewController:notesPostController animated:true];
    
}
@end
