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


@interface FMTwitterUser : NSObject <NSCopying>
	{
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
	
	NSInteger		uniqueID;
	NSInteger		followersCount;
	NSInteger		friendsCount;
	NSInteger		favouritesCount;
	NSInteger		statusesCount;	
	
	NSXMLNode*	xmlNode;
	}

- (id) initWithXMLNode:(NSXMLNode*)aXMLNode;
+ (FMTwitterUser*) userWithXMLNode:(NSXMLNode*)aXMLNode;

- (void) fetchProfileImage;



@property (nonatomic, retain) NSString* name, *screenName, *location, *description;
@property (nonatomic, retain) NSURL* profileImageURL, *url;
@property (nonatomic, retain) NSDate* joinDate;
@property (nonatomic, retain) NSTimeZone* timezone;
@property (nonatomic, retain) NSXMLNode* xmlNode;

@property (assign) BOOL isProtected, isFollowing, isVerified;
@property (assign) NSInteger uniqueID, followersCount, friendsCount, favouritesCount, statusesCount;

@end
