//
//  User.h
//  FMTwitterKit
//
//  Created by Felix Morgner on 04.02.10.
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

#import <Cocoa/Cocoa.h>
#import "FMTwitterKitGlobals.h"

@interface FMTwitterUser : NSObject <NSCopying>
	{
	@public
		NSString*		name;
		NSString*		screenName;
		NSString*		location;
		NSString*		description;
		
		NSURL*			profileImageURL;
		NSURL*			url;
		
		NSDate*			joinDate;
		
		NSTimeZone* timezone;
		
		BOOL				isProtected;
		BOOL				isFollowing;
		BOOL				isVerified;
		
		NSUInteger		uniqueID;
		NSUInteger		followersCount;
		NSUInteger		friendsCount;
		NSUInteger		favouritesCount;
		NSUInteger		statusesCount;
	
	@private
		id delegate;
		FMTwitterKitProfileImageSize selectedProfileImageSize;
	}

- (id) initWithXMLNode:(NSXMLNode*)aXMLNode;
+ (FMTwitterUser*) userWithXMLNode:(NSXMLNode*)aXMLNode;

- (void) fetchProfileImageOfSize:(FMTwitterKitProfileImageSize)profileImageSize;
- (void) didLoadProfileImage:(NSImage*)profileImage ofSize:(FMTwitterKitProfileImageSize)size;
- (void) processNotification:(NSNotification*)aNotification;
- (void) setDelegate:(id)aDelegate;

@property (nonatomic, retain) NSString* name, *screenName, *location, *description;
@property (nonatomic, retain) NSURL* profileImageURL, *url;
@property (nonatomic, retain) NSDate* joinDate;
@property (nonatomic, retain) NSTimeZone* timezone;

@property (assign) BOOL isProtected, isFollowing, isVerified;
@property (assign) NSUInteger uniqueID, followersCount, friendsCount, favouritesCount, statusesCount;

@end

@protocol FMTwitterUserDelegate

- (void) twitterUser:(FMTwitterUser*)twitterUser didLoadProfileImage:(NSImage*)profileImage ofSize:(FMTwitterKitProfileImageSize)size;

@end