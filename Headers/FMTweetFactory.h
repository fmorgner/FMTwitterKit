//
//  FMTweetFactory.h
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

#import <Cocoa/Cocoa.h>

#import "FMTweet.h"
#import "FMTwitterUser.h"

@interface FMTweetFactory : NSObject
	{
	
	}

+ (id)sharedTweetFactory;

- (NSArray*) tweetsFromXMLDocument:(NSXMLDocument*)aXMLDocument;
- (FMTweet*) tweetFromXMLDocument:(NSXMLDocument*)aXMLDocument;

@end
