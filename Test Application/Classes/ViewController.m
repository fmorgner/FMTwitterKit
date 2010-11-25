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
	[selectedTweet release];
	[super dealloc];
	}

- (void) awakeFromNib
	{
	}

- (IBAction) reloadProfileImage:(id)sender
	{
	if(selectedTweet)
		{
		profileImageView.image = [selectedTweet.user profileImageOfSize:kFMTwitterKitProfileImageSizeBigger];
		}
	}

- (IBAction) fetchTimeline:(id)sender
	{
	[delegationCheckbox setEnabled:NO];
		
	NSError* fetchError = nil;
	
	NSXMLDocument* xmlDocument = [[NSXMLDocument alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://twitter.com/statuses/public_timeline.xml"] options:0 error:&fetchError];
	
	if(fetchError)
		{
		NSLog(@"An error occured: %@", [fetchError localizedDescription]);
		}
	
	FMTweetFactory* tweetFactory = [FMTweetFactory sharedTweetFactory];
	[self setSelectedTweet:[[tweetFactory tweetsFromXMLDocument:xmlDocument] objectAtIndex:3]];
	[xmlDocument release];
	
	
	if(delegationCheckbox.intValue)
		{
		[selectedTweet.user setDelegate:self];
		}
	else
		{
		[selectedTweet.user setDelegate:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification:) name:[NSString stringWithUTF8String:kFMTwitterKitProfileImageDownloadFinishedNotification] object:nil];
		}
	
	tweetField.stringValue = selectedTweet.text;
	usernameField.stringValue = selectedTweet.user.name;
	viaField.stringValue = selectedTweet.source;
	[profileImageView setImageScaling:NSScaleToFit];
	profileImageView.image = [selectedTweet.user profileImageOfSize:kFMTwitterKitProfileImageSizeBigger];

	[delegationCheckbox setEnabled:YES];
	}

- (void) didReceiveNotification:(NSNotification*)aNotification
	{
	if([[aNotification name] isEqualToString:[NSString stringWithUTF8String:kFMTwitterKitProfileImageDownloadFinishedNotification]])
		{
		profileImageView.image = selectedTweet.user.profileImage;
		}
	}

- (void) twitterUser:(FMTwitterUser*)twitterUser didLoadProfileImage:(NSImage*)profileImage ofSize:(FMTwitterKitProfileImageSize)size
	{
	profileImageView.image = profileImage;
	}
@end
