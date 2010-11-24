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
#import "FMTwitterUserProfileImageDownloadDelegate.h"

@implementation FMTwitterUser

@synthesize name, screenName, location, description;
@synthesize profileImageURL, url;
@synthesize joinDate;
@synthesize timezone;
@synthesize isProtected, isFollowing, isVerified;
@synthesize uniqueID, followersCount, friendsCount, favouritesCount, statusesCount;
@synthesize xmlNode;

#pragma mark -
#pragma mark Allocation/Deallocation: 

- (id) initWithXMLNode:(NSXMLNode*)aXMLNode
	{
	if((self = [super init]))
		{
		[self setName:				[[[aXMLNode objectsForXQuery:@"for $p in name return $p" error:nil] objectAtIndex:0] stringValue]];
		[self setScreenName:	[[[aXMLNode objectsForXQuery:@"for $p in screen_name return $p" error:nil] objectAtIndex:0] stringValue]];
		[self setLocation:		[[[aXMLNode objectsForXQuery:@"for $p in location return $p" error:nil] objectAtIndex:0] stringValue]];
		[self setDescription:	[[[aXMLNode objectsForXQuery:@"for $p in description return $p" error:nil] objectAtIndex:0] stringValue]];
		
		[self setProfileImageURL: [NSURL URLWithString:[[[aXMLNode objectsForXQuery:@"for $p in profile_image_url return $p" error:nil] objectAtIndex:0] stringValue]]];
		[self setUrl:							[NSURL URLWithString:[[[aXMLNode objectsForXQuery:@"for $p in url return $p" error:nil] objectAtIndex:0] stringValue]]];

		[self setJoinDate: [NSDate dateWithNaturalLanguageString:[[[aXMLNode objectsForXQuery:@"for $p in created_at return $p" error:nil] objectAtIndex:0] stringValue]]];
		
		[self setTimezone: [NSTimeZone timeZoneForSecondsFromGMT:[[[[aXMLNode objectsForXQuery:@"for $p in utc_offset return $p" error:nil] objectAtIndex:0] stringValue] longLongValue]]];
		
		[self setIsProtected:	[[[[aXMLNode objectsForXQuery:@"for $p in protected return $p" error:nil] objectAtIndex:0] stringValue] boolValue]];
		[self setIsFollowing:	[[[[aXMLNode objectsForXQuery:@"for $p in following return $p" error:nil] objectAtIndex:0] stringValue] boolValue]];		
		[self setIsVerified:	[[[[aXMLNode objectsForXQuery:@"for $p in verified return $p" error:nil] objectAtIndex:0] stringValue] boolValue]];		

		[self setUniqueID:				[[[[aXMLNode objectsForXQuery:@"for $p in id return $p" error:nil] objectAtIndex:0] stringValue] longLongValue]];		
		[self setFollowersCount:	[[[[aXMLNode objectsForXQuery:@"for $p in followers_count return $p" error:nil] objectAtIndex:0] stringValue] longLongValue]];		
		[self setFriendsCount:		[[[[aXMLNode objectsForXQuery:@"for $p in friends_count return $p" error:nil] objectAtIndex:0] stringValue] longLongValue]];		
		[self setFavouritesCount:	[[[[aXMLNode objectsForXQuery:@"for $p in favourites_count return $p" error:nil] objectAtIndex:0] stringValue] longLongValue]];		
		[self setStatusesCount:		[[[[aXMLNode objectsForXQuery:@"for $p in statuses_count return $p" error:nil] objectAtIndex:0] stringValue] longLongValue]];
		}
		
	return self;
	}
	
+ (FMTwitterUser*) userWithXMLNode:(NSXMLNode*)aXMLNode
	{
	return [[[FMTwitterUser alloc] initWithXMLNode:aXMLNode] autorelease];
	}

- (id)copyWithZone:(NSZone *)zone
	{
	FMTwitterUser *copy = [[FMTwitterUser allocWithZone: zone] init];

	copy.name						 = [[self.name copy] autorelease];
	copy.screenName			 = [[self.screenName copy] autorelease];
	copy.location				 = [[self.location copy] autorelease];
	copy.description		 = [[self.description copy] autorelease];
	copy.profileImageURL = [[self.profileImageURL copy] autorelease];
	copy.url						 = [[self.url copy] autorelease];
	copy.joinDate				 = [[self.joinDate copy] autorelease];
	copy.timezone				 = [[self.timezone copy] autorelease];

	
	copy.isProtected		 = self.isProtected;
	copy.isFollowing		 = self.isFollowing;
	copy.isVerified			 = self.isVerified;
	copy.uniqueID				 = self.uniqueID;
	copy.followersCount  = self.followersCount;
	copy.friendsCount		 = self.friendsCount;
	copy.favouritesCount = self.favouritesCount;
	copy.statusesCount	 = self.statusesCount;

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

#pragma mark -
#pragma mark Convenience accessors:

- (void) fetchProfileImageOfSize:(FMProfileImageSize)profileImageSize
	{
	NSMutableString* profileImageURLString = [NSMutableString stringWithFormat:@"http://api.twitter.com/1/users/profile_image/%@.xml?size=", self.screenName];
		
	switch (profileImageSize)
		{
		case FMProfileImageSizeSmall:
			[profileImageURLString appendString:@"small"];
			break;
		case FMProfileImageSizeNormal:
			[profileImageURLString appendString:@"normal"];
			break;
		case FMProfileImageSizeBigger:
			[profileImageURLString appendString:@"bigger	"];
			break;
		default:
			NSLog(@"Invalid parameter '%i' supplied for 'profileImageSize'. Defaulting to normal size.", (int)profileImageSize);
			break;
		}
	
	NSURL* selectedProfileImageURL = [NSURL URLWithString:profileImageURLString];
	
	FMTwitterUserProfileImageDownloadDelegate* delegate = [[FMTwitterUserProfileImageDownloadDelegate alloc] init];
	[NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:selectedProfileImageURL] delegate:delegate];
	[delegate release];
	}

@end

