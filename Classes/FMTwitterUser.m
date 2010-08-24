//
//  User.m
//  FMTwitterKit
//
//  Created by Felix Morgner on 04.02.10.
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

#import "FMTwitterUser.h"


@implementation FMTwitterUser

@synthesize name, screenName, location, description;
@synthesize profileImageURL, url;
@synthesize joinDate;
@synthesize timezone;
@synthesize isProtected, isFollowing, isVerified;
@synthesize uniqueID, followersCount, friendsCount, favouritesCount, statusesCount;
@synthesize xmlNode;

- (id) initWithXMLNode:(NSXMLNode*)aXMLNode
	{
	if(self = [super init])
		{
		NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
		
		name						= [[[[aXMLNode objectsForXQuery:@"for $p in name return $p" error:nil] objectAtIndex:0] stringValue] copy];
		screenName			= [[[[aXMLNode objectsForXQuery:@"for $p in screen_name return $p" error:nil] objectAtIndex:0] stringValue] copy];
		location				= [[[[aXMLNode objectsForXQuery:@"for $p in location return $p" error:nil] objectAtIndex:0] stringValue] copy];
		description			= [[[[aXMLNode objectsForXQuery:@"for $p in description return $p" error:nil] objectAtIndex:0] stringValue] copy];
		
		profileImageURL = [[NSURL URLWithString:[[[aXMLNode objectsForXQuery:@"for $p in profile_image_url return $p" error:nil] objectAtIndex:0] stringValue]] copy];
		url							= [[NSURL URLWithString:[[[aXMLNode objectsForXQuery:@"for $p in url return $p" error:nil] objectAtIndex:0] stringValue]] copy];

		joinDate				= [[NSDate dateWithNaturalLanguageString:[[[aXMLNode objectsForXQuery:@"for $p in created_at return $p" error:nil] objectAtIndex:0] stringValue]] copy];
		
		timezone				= [[NSTimeZone timeZoneForSecondsFromGMT:[[[[aXMLNode objectsForXQuery:@"for $p in utc_offset return $p" error:nil] objectAtIndex:0] stringValue] intValue]] copy];
		
		isProtected			= [[[[aXMLNode objectsForXQuery:@"for $p in protected return $p" error:nil] objectAtIndex:0] stringValue] boolValue];
		isFollowing			= [[[[aXMLNode objectsForXQuery:@"for $p in following return $p" error:nil] objectAtIndex:0] stringValue] boolValue];		
		isVerified			= [[[[aXMLNode objectsForXQuery:@"for $p in verified return $p" error:nil] objectAtIndex:0] stringValue] boolValue];		

		uniqueID				= [[[[aXMLNode objectsForXQuery:@"for $p in id return $p" error:nil] objectAtIndex:0] stringValue] intValue];		
		followersCount	= [[[[aXMLNode objectsForXQuery:@"for $p in followers_count return $p" error:nil] objectAtIndex:0] stringValue] intValue];		
		friendsCount		= [[[[aXMLNode objectsForXQuery:@"for $p in friends_count return $p" error:nil] objectAtIndex:0] stringValue] intValue];		
		favouritesCount	= [[[[aXMLNode objectsForXQuery:@"for $p in favourites_count return $p" error:nil] objectAtIndex:0] stringValue] intValue];		
		statusesCount		= [[[[aXMLNode objectsForXQuery:@"for $p in statuses_count return $p" error:nil] objectAtIndex:0] stringValue] intValue];
		
		[pool drain];
		}
		
	return self;
	}
	
+ (FMTwitterUser*) userWithXMLNode:(NSXMLNode*)aXMLNode
	{
	return [[[FMTwitterUser alloc] initWithXMLNode:aXMLNode] autorelease];
	}

- (id)copyWithZone:(NSZone *)zone
	{
	FMTwitterUser *copy = [[[self class] allocWithZone: zone] initWithXMLNode:xmlNode];
	return copy;
	}

- (void) dealloc
	{
	[name release];
	[screenName release];
	[location release];
	[description release];
	[profileImageURL release];
	[url release];
	[joinDate release];
	[timezone release];
	[super dealloc];
	}

@end

