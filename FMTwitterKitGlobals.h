//
//  FMTwitterKitDefines.h
//  FMTwitterKit
//
//  Created by Felix Morgner on 24.11.10.
//  Copyright 2010 Felix Morgner. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define kFMTwitterKitProfileImageDownloadFinishedNotification "FMTwitterKitProfileImageDownloadFinishedNotification"
#define kFMTwitterKitProfileImageDownloadConnectionException  "FMTwitterKitProfileImageDownloadConnectionException"

typedef enum
	{
	kFMTwitterKitProfileImageSizeNormal = 1,
	kFMTwitterKitProfileImageSizeSmall	 = 2,
	kFMTwitterKitProfileImageSizeBigger = 4,
	kFMTwitterKitProfileImageSizeFull   = 8
	} FMTwitterKitProfileImageSize;
