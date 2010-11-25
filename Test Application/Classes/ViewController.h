//
//  ViewController.h
//  TwitterKitTest
//
//  Created by Felix Morgner on 22.11.10.
//  Copyright 2010 Bühler AG. All rights reserved.
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
