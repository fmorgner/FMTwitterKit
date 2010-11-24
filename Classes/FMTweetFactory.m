//
//  TweetFactory.m
//  FMTwitterKit
//
//  Created by Felix Morgner on 18.02.10.
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

//	This is the "factory" for the tweets. Here the NSXMLDocument that was
//	fetched from twitter.com get processed into an array of tweets.

#import "FMTweetFactory.h"

static FMTweetFactory* sharedInstance = nil;

@implementation FMTweetFactory

+ (id) sharedTweetFactory
	{
	if(!sharedInstance)
		{
		sharedInstance = [[self alloc] init];
		}
	return sharedInstance;
	}

- (id) init
	{
	if(!sharedInstance)
		{
		if((self = [super init]))
			{
			
			}
		sharedInstance = self;
		}
	else if(self != sharedInstance)
		{
		self = sharedInstance;
		}
	return self;
	}
	
- (NSArray*) tweetsFromXMLDocument:(NSXMLDocument *)aXMLDocument
	{
	NSMutableArray* tweetsArray = nil;	// The array containing the processed tweets.
	NSArray* statusNodesArray = nil;		// The array containing the NSXMLNodes representing the fetched statuses
	NSError* error = nil;								// The error object needed by nodesForXpath
	
	// Process the supplied NSXMLDocument into an array of NSXMLNode objects.
	statusNodesArray = [aXMLDocument nodesForXPath:@"statuses/status" error:&error];

	// Check if something went wrong while processing the NSXMLDocument.
	if (error != nil)
	{
		NSLog(@"Error while processing statuses NSXMLDocument: %@", [error localizedDescription]);
	}

	// Allocate the array holding the processed tweets.
	tweetsArray = [NSMutableArray arrayWithCapacity:[statusNodesArray count]];

	// Main tweet processing loop
	for(NSXMLNode* node in statusNodesArray)
		{
		// Get our processed tweet and add it to the tweetsArray array.
		[tweetsArray addObject:[FMTweet tweetWithXMLNode:node]];
		}

	// Return the array of processed tweets
	return tweetsArray;
	}

- (FMTweet*) tweetFromXMLDocument:(NSXMLDocument*)aXMLDocument
	{
	NSArray* statusNodesArray = nil;		// The array containing the NSXMLNodes representing the fetched statuses
	NSError* error = nil;								// The error object needed by nodesForXpath
	
	// Process the supplied NSXMLDocument into an array of NSXMLNode objects.
	statusNodesArray = [aXMLDocument nodesForXPath:@"status" error:&error];

	// Check if something went wrong while processing the NSXMLDocument.
	if (error != nil)
	{
		NSLog(@"Error while processing statuses NSXMLDocument: %@", [error localizedDescription]);
	}

	// Return the processed tweet
	return [FMTweet tweetWithXMLNode:[statusNodesArray objectAtIndex:0]];
	}


@end