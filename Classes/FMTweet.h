//
//  Tweet.h
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

#import <Cocoa/Cocoa.h>
#import "FMTwitterUser.h"

@interface FMTweet : NSObject <NSCopying>
	{	
	NSString* text;							// The text of the tweet
	NSString* source;						// The source from which the tweet was posted
	NSString* replyScreenName;	// The screenname of the user to wich this tweet was send as a reply
	
	FMTwitterUser*	user;				// The user that posted that tweet

	NSDate* creationDate;				// The date on which this tweet was posted
	
	NSUInteger uniqueID;					// The tweets unique identification number (also known as status number)
	NSUInteger replyStatusID;		// The identification number of the tweet to which this tweet was send as a reply
	NSUInteger replyUserID;			// The identification number of the user to which this tweet was send as a reply
	
	BOOL isTruncated;						// Is this tweet truncated?
	BOOL isFavourite;						// Is this tweet favourited?
	
	}

- (id) initWithXMLNode:(NSXMLNode*)aXMLNode;
+ (FMTweet*) tweetWithXMLNode:(NSXMLNode*)aXMLNode;

// This method is used to strip the HTML link out of the source string
// and create a NSURL object with the links URL.
- (void) stripLinkFromString:(NSString**)aString intoURL:(NSURL**)aURL;

@property (nonatomic, retain) NSString* text, *source, *replyScreenName;
@property (nonatomic, retain)	FMTwitterUser* user;
@property (nonatomic, retain) NSDate* creationDate;
@property (assign) NSUInteger uniqueID, replyStatusID, replyUserID;
@property (assign) BOOL isTruncated, isFavourite;
@property (nonatomic, retain) NSXMLNode* xmlNode;

@end
