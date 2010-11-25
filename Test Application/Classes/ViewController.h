//
//  ViewController.h
//  TwitterKitTest
//
//  Created by Felix Morgner on 22.11.10.
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
#import "FMTwitterKit/FMTwitterKit.h"


@interface ViewController : NSObject <FMTwitterUserDelegate>
	{
	IBOutlet NSTextField* usernameField;
	IBOutlet NSTextField* tweetField;
	IBOutlet NSTextField* viaField;
	IBOutlet NSImageView* profileImageView;
	IBOutlet NSButton* delegationCheckbox;
	
	FMTweet* selectedTweet;
	}

- (IBAction) fetchTimeline:(id)sender;
- (IBAction) reloadProfileImage:(id)sender;

- (void) didReceiveNotification:(NSNotification*)aNotification;

@property(nonatomic, retain) FMTweet* selectedTweet;

@end
