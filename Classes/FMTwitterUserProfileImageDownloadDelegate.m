//
//  FMTwitterUserProfileImageDownloadDelegate.m
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

#import "FMTwitterUserProfileImageDownloadDelegate.h"


@implementation FMTwitterUserProfileImageDownloadDelegate

@synthesize downloadedImage, receivedData;

- (id)init
	{
	if ((self = [super init]))
		{
		self.receivedData = [[[NSMutableData alloc] init] autorelease];
    }
    
	return self;
	}

- (void)dealloc
	{
	[super dealloc];
	}

#pragma mark -
#pragma mark NSURLConnection delegate methods:

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
	{
	[self.receivedData appendData:data];
	}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
	{
	NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
	NSDictionary* userInfoDictionary = [NSDictionary dictionaryWithObject:self.receivedData forKey:[NSString stringWithUTF8String:kFMTwitterKitProfileImageData]];
		
	NSNotification* notification = [NSNotification notificationWithName:[NSString stringWithUTF8String:kFMTwitterKitProfileImageDownloadFinishedNotification]
																															 object:self
																														 userInfo:userInfoDictionary];
	
	[notificationCenter postNotification:notification];
	[receivedData release];
	}
	
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
	{
	NSException* exception = [NSException exceptionWithName:[NSString stringWithUTF8String:kFMTwitterKitProfileImageDownloadConnectionException]
																									 reason:[error localizedFailureReason]
																								 userInfo:nil];
	[exception raise];
	}
@end
