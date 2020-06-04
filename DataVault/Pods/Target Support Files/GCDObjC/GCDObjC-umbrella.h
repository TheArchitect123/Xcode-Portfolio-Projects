#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GCDGroup.h"
#import "GCDMacros.h"
#import "GCDObjC.h"
#import "GCDQueue.h"
#import "GCDSemaphore.h"

FOUNDATION_EXPORT double GCDObjCVersionNumber;
FOUNDATION_EXPORT const unsigned char GCDObjCVersionString[];

