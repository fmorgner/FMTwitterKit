//
//  FMTwitterUserProfileImageDownloadDelegate.m
//  FMTwitterKit
//
//  Created by Felix Morgner on 22.11.10.
//  Copyright 2010 Felix Morgner. All rights reserved.
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
	NSDictionary* userInfoDictionary = [NSDictionary dictionaryWithObject:self.receivedData forKey:@"profileImageData"];
	
	NSNotification* notification = [NSNotification notificationWithName:@"FMTwitterKitProfileImageDownloadFinishedNotification" object:self userInfo:userInfoDictionary];
	
	[notificationCenter postNotification:notification];
	[receivedData release];
	}
	
- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
	{
	NSException* exception = [NSException exceptionWithName:@"FMTwitterKitProfileImageDownloadConnectionException"
																				reason:[error localizedFailureReason]
																				userInfo:nil];
	[exception raise];
	}
@end
