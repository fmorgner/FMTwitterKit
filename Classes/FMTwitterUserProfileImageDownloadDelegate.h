//
//  FMTwitterUserProfileImageDownloadDelegate.h
//  FMTwitterKit
//
//  Created by Felix Morgner on 22.11.10.
//
//  Copyright 2010 Felix Morgner.
//
//	This program is free software, you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//	the Free Software Foundation, version 3 of the License.
//
//	This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY, without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

#import <Foundation/Foundation.h>
#import "FMTwitterKitGlobals.h"

@interface FMTwitterUserProfileImageDownloadDelegate : NSObject
	{
	NSImage* downloadedImage;
	NSMutableData* receivedData;
	}

@property(nonatomic, retain) NSImage* downloadedImage;
@property(nonatomic, retain) NSMutableData* receivedData;

@end
