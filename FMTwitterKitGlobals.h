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
#define kFMTwitterKitProfileImageData													"profileImageData"

typedef enum
	{
	FMProfileImageSizeNormal = 1,
	FMProfileImageSizeSmall	 = 2,
	FMProfileImageSizeBigger = 4,
	FMProfileImageSizeFull   = 8
	} FMTwitterKitProfileImageSize;
