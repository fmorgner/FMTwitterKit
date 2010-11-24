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

#pragma mark -
#pragma mark Allocation/Deallocation:

- (id) initWithXMLNode:(NSXMLNode *)aXMLNode
	{
	if((self = [super init]))
		{
		[self setText:						[[[aXMLNode objectsForXQuery:@"for $p in text return $p" error:nil] objectAtIndex:0] stringValue]];
		[self setSource:					[[[aXMLNode objectsForXQuery:@"for $p in source return $p" error:nil] objectAtIndex:0] stringValue]];
		[self setReplyScreenName:	[[[aXMLNode objectsForXQuery:@"for $p in in_reply_to_screen_name return $p" error:nil] objectAtIndex:0] stringValue]];

		[self setUser: [FMTwitterUser userWithXMLNode:[[aXMLNode nodesForXPath:@"user" error:nil] objectAtIndex:0]]];

		[self setCreationDate: [NSDate dateWithNaturalLanguageString:[[[aXMLNode objectsForXQuery:@"for $p in created_at return $p" error:nil] objectAtIndex:0] stringValue]]];

		[self setUniqueID:			[[[[aXMLNode objectsForXQuery:@"for $p in id return $p" error:nil] objectAtIndex:0] stringValue] longLongValue]];		
		[self setReplyStatusID:	[[[[aXMLNode objectsForXQuery:@"for $p in in_reply_to_status_id return $p" error:nil] objectAtIndex:0] stringValue] longLongValue]];
		[self setReplyUserID:		[[[[aXMLNode objectsForXQuery:@"for $p in in_reply_to_user_id return $p" error:nil] objectAtIndex:0] stringValue] longLongValue]];

		[self setIsTruncated:	[[[[aXMLNode objectsForXQuery:@"for $p in truncated return $p" error:nil] objectAtIndex:0] stringValue] boolValue]];
		[self setIsFavourite:	[[[[aXMLNode objectsForXQuery:@"for $p in favorited return $p" error:nil] objectAtIndex:0] stringValue] boolValue]];
		}

	return self;
	}

+ (FMTweet*) tweetWithXMLNode:(NSXMLNode*)aXMLNode
	{
	return [[[FMTweet alloc] initWithXMLNode:aXMLNode] autorelease];
	}

- (void)dealloc
	{
	[text release];
	[source release];
	[replyScreenName release];
	[creationDate release];
	[user release];
	[super dealloc];
	}

#pragma mark -
#pragma mark NSCopying protocol methods

- (id)copyWithZone:(NSZone *)zone
	{
	FMTweet *copy = [[FMTweet allocWithZone: zone] init];
	
	copy.text						 = [[self.text copy] autorelease];
	copy.source					 = [[self.source copy] autorelease];
	copy.replyScreenName = [[self.replyScreenName copy] autorelease];
	copy.user						 = [[self.user copy] autorelease];
	copy.creationDate		 = [[self.creationDate copy] autorelease];

	copy.uniqueID			 = self.uniqueID;
	copy.replyStatusID = self.replyStatusID;
	copy.replyUserID	 = self.replyUserID;
	copy.isTruncated	 = self.isTruncated;
	copy.isFavourite	 = self.isFavourite;

	return copy;
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

#pragma mark -
#pragma mark Utility methods:

- (void) stripLinkFromString:(NSString**)aString intoURL:(NSURL**)aURL
	{
	
	if(aString == nil)
		{
		return;
		}
	else
		{
		NSString* tagString = nil;
		NSString* newSourceString = nil;
			
		NSRange firstTagRange = [*aString rangeOfString:@">"];
		
		if(firstTagRange.location == NSNotFound)
			{
			return;
			}
		else
			{
			firstTagRange.length = firstTagRange.location + 1;
			firstTagRange.location = 0;
			tagString = [[NSString alloc] initWithString:[*aString substringWithRange:firstTagRange]];
			}
		
		NSRange secondTagRange = [*aString rangeOfString:@"<" options:NSBackwardsSearch];
			
		NSRange sourceStringRange = NSMakeRange(firstTagRange.length, secondTagRange.location - firstTagRange.length);
		newSourceString = [[NSString alloc] initWithString:[*aString substringWithRange:sourceStringRange]];
		
		[*aString release];			
		*aString = newSourceString;

		if(aURL == nil)
			{
			[tagString release];
			return;
			}
		else
			{
			NSRange hrefRange = [tagString rangeOfString:@"href=\""];
			NSRange endQuotationmarkRange = [[tagString substringFromIndex:hrefRange.location + 6] rangeOfString:@"\""];
			NSRange urlRange = NSMakeRange(hrefRange.location + 6, endQuotationmarkRange.location);

			NSString* urlString = [tagString substringWithRange:urlRange];	
			[tagString release];

			NSURL* sourceURL = [[NSURL alloc] initWithString:urlString];
			[*aURL release];
			*aURL = sourceURL;
			}

		}
		
	}

#pragma mark -
#pragma mark Custom accessors:

- (void) setSource:(NSString *)aString
	{
	if(source != nil)
		{
		[source release];
		}

	source = [aString retain];	

	[self stripLinkFromString:&source intoURL:nil];
	}

@end
