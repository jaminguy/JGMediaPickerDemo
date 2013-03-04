//
//  ViewController.m
//  JGMediaPickerDemo
//
//  Created by Jamin Guy on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#import <MediaPlayer/MediaPlayer.h>

#import "JGMediaPickerController.h"

@interface ViewController ()

@property (nonatomic, strong) JGMediaPickerController *mediaPickerController;

@end

@implementation ViewController

@synthesize mediaPickerController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setShowMediaPickerButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)showMediaButtonTouchUpInside:(id)sender {
    if(self.mediaPickerController == nil) {
        [self.showMediaPickerButton setTitle:@"Loading..." forState:UIControlStateNormal];
        self.showMediaPickerButton.enabled = NO;
        __weak ViewController *weakSelf = self;
        [JGMediaPickerController jgMediaPickerControllerAsync:^(JGMediaPickerController *jgMediaPickerController) {
            weakSelf.mediaPickerController = jgMediaPickerController;
            weakSelf.mediaPickerController.delegate = self;
            [weakSelf presentModalViewController:self.mediaPickerController.viewController animated:YES];
            [weakSelf.showMediaPickerButton setTitle:@"Show Media Picker" forState:UIControlStateNormal];
            weakSelf.showMediaPickerButton.enabled = YES;
        }];
    }
    else {
        [self presentModalViewController:self.mediaPickerController.viewController animated:YES];
    }
}

- (void)jgMediaPicker:(JGMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection selectedItem:(MPMediaItem *)selectedItem {
    [[MPMusicPlayerController iPodMusicPlayer] setQueueWithItemCollection:mediaItemCollection];
    [[MPMusicPlayerController iPodMusicPlayer] setNowPlayingItem:selectedItem];
    [[MPMusicPlayerController iPodMusicPlayer] play];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)jgMediaPickerDidCancel:(JGMediaPickerController *)mediaPicker {
    [self dismissModalViewControllerAnimated:YES];
}

@end
