//
//  Tweet.m
//  FMTwitterKit
//
//  Created by Felix Morgner on 02.02.10.
//
//  Copyright 2010 Felix Morgner.
//
//	This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//	the Free Software Foundation; version 3 of the License.
//
//	This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//

#import "FMTweet.h"

@implementation FMTweet

@synthesize text, source, replyScreenName;
@synthesize user;
@synthesize creationDate;
@synthesize uniqueID, replyStatusID, replyUserID;
@synthesize isTruncated, isFavourite;
@synthesize xmlNode;

#pragma mark -
#pragma mark Initialisation

- (id) initWithXMLNode:(NSXMLNode *)aXMLNode
	{
	if(self = [super init])
		{
		xmlNode = [aXMLNode retain];
		
		text						= [[[[aXMLNode objectsForXQuery:@"for $p in text return $p" error:nil] objectAtIndex:0] stringValue] retain];
		source					= [[[[aXMLNode objectsForXQuery:@"for $p in source return $p" error:nil] objectAtIndex:0] stringValue] retain];
		replyScreenName = [[[[aXMLNode objectsForXQuery:@"for $p in in_reply_to_screen_name return $p" error:nil] objectAtIndex:0] stringValue] retain];
		
		user						= [[FMTwitterUser userWithXMLNode:[[aXMLNode nodesForXPath:@"user" error:nil] objectAtIndex:0]] retain];
		
		creationDate	  = [[NSDate dateWithNaturalLanguageString:[[[aXMLNode objectsForXQuery:@"for $p in created_at return $p" error:nil] objectAtIndex:0] stringValue]] retain];

		uniqueID				= [[[[aXMLNode objectsForXQuery:@"for $p in id return $p" error:nil] objectAtIndex:0] stringValue] intValue];		
		replyStatusID		= [[[[aXMLNode objectsForXQuery:@"for $p in in_reply_to_status_id return $p" error:nil] objectAtIndex:0] stringValue]intValue];
		replyUserID			= [[[[aXMLNode objectsForXQuery:@"for $p in in_reply_to_user_id return $p" error:nil] objectAtIndex:0] stringValue]intValue];
		
		isTruncated			= [[[[aXMLNode objectsForXQuery:@"for $p in truncated return $p" error:nil] objectAtIndex:0] stringValue] boolValue];
		isFavourite			= [[[[aXMLNode objectsForXQuery:@"for $p in favorited return $p" error:nil] objectAtIndex:0] stringValue] boolValue];
		}

	return self;
	}

+ (FMTweet*) tweetWithXMLNode:(NSXMLNode*)aXMLNode
	{
	return [[[FMTweet alloc] initWithXMLNode:aXMLNode] autorelease];
	}

#pragma mark -
#pragma mark NSCopying protocol methods

- (id)copyWithZone:(NSZone *)zone
	{
	FMTweet *copy = [[[self class] allocWithZone: zone] initWithXMLNode:xmlNode];
	return copy;
	}

#pragma mark -
#pragma mark Deallocation

- (void)dealloc
	{
	[text release];
	[source release];
	[replyScreenName release];
	[creationDate release];
	[user release];
	[xmlNode release];
	[super dealloc];
	}

#pragma mark -
#pragma mark Description

- (NSString*) description
	{
	NSMutableDictionary* descriptionDictionary = [NSMutableDictionary dictionary];
	
	[descriptionDictionary setValue:[text description] forKey:@"text"];
	[descriptionDictionary setValue:[source description] forKey:@"source"];
	[descriptionDictionary setValue:[replyScreenName description] forKey:@"replyScreenName"];
	
	return [descriptionDictionary description];
	}
@end
