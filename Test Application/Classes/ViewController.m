//
//  ViewController.m
//  TwitterKitTest
//
//  Created by Felix Morgner on 22.11.10.
//  Copyright 2010 Bühler AG. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize selectedTweet;

- (void) dealloc
	{
	[selectedTweet dealloc];
	[super dealloc];
	}


- (void)fetchTimeline:(id)sender
	{
	[delegationCheckbox setEnabled:NO];
	
	NSXMLDocument* xmlDocument = [[NSXMLDocument alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://twitter.com/statuses/public_timeline.xml"] options:0 error:nil];
	FMTweetFactory* tweetFactory = [FMTweetFactory sharedTweetFactory];
	NSArray* tweets = [tweetFactory tweetsFromXMLDocument:xmlDocument];
	[xmlDocument release];
	
	[self setSelectedTweet:[tweets objectAtIndex:3]];
	
	if(delegationCheckbox.intValue)
		{
		NSLog(@"using delegation");
		[selectedTweet.user setDelegate:self];
		}
	else
		{
		NSLog(@"using notifications");
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification:)
																				name:@"FMTwitterKitProfileImageDownloadFinishedNotification" object:nil];
		}
	
	tweetField.stringValue = selectedTweet.text;
	usernameField.stringValue = selectedTweet.user.name;
	viaField.stringValue = selectedTweet.source;
	
	[selectedTweet.user fetchProfileImageOfSize:FMProfileImageSizeBigger];

	[delegationCheckbox setEnabled:YES];
	}

- (void)didReceiveNotification:(NSNotification*)aNotification
	{
	NSData* profileImageData = [[aNotification userInfo] objectForKey:@"profileImageData"];
	NSImage* profileImage = [[NSImage alloc] initWithData:profileImageData];
	
	[profileImageView setImageScaling:NSScaleToFit];
	profileImageView.image = profileImage;
	[profileImage release];
	}

- (void) twitterUser:(FMTwitterUser*)twitterUser didLoadProfileImage:(NSImage*)profileImage ofSize:(FMTwitterKitProfileImageSize)size
	{
	[profileImageView setImageScaling:NSScaleToFit];
	profileImageView.image = profileImage;
	[profileImage release];
	}
@end
