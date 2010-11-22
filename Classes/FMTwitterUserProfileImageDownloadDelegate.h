//
//  FMTwitterUserProfileImageDownloadDelegate.h
//  FMTwitterKit
//
//  Created by Felix Morgner on 22.11.10.
//  Copyright 2010 Felix Morgner. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FMTwitterUserProfileImageDownloadDelegate : NSObject
	{
	NSImage* downloadedImage;
	NSMutableData* receivedData;
	}

@property(nonatomic, retain) NSImage* downloadedImage;
@property(nonatomic, retain) NSMutableData* receivedData;

@end
