//
//  AppDelegate.m
//  AVAudioPlayer
//
//  Created by Chris Uzelac on 6/3/13.
//  Copyright (c) 2013 allecto.org. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application

//    self.audioPlayer = nil;
    NSString *filePath = @"/asdf.mp3";
    NSLog(@"%@", filePath);
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:filePath];
    NSLog(@"%@", [fileURL absoluteString]);

    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer setCurrentTime:0.0];
    [self.audioPlayer setVolume:0.5];
    [self.audioPlayer setMeteringEnabled:YES];
    [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateDisplay) userInfo:nil repeats:YES];
    [self activateStatusMenu];
}

- (void)activateStatusMenu
{
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    
    NSStatusItem *theItem = [bar statusItemWithLength:NSVariableStatusItemLength];
    self.item = theItem;
    
    [theItem setTitle: NSLocalizedString(@"Tablet",@"")];
    [theItem setHighlightMode:YES];
    [theItem setMenu:self.theMenu];
}

- (IBAction)takePctValueForProgressFrom:(id)sender {
    float pct = [sender floatValue];
    NSLog(@"progress set to: %3.2f", pct);
    
    float newLoc = [self.audioPlayer duration] * (pct / 100);
    
    NSLog(@"len: %f | newLoc: %f", [self.audioPlayer duration], newLoc);
    [self.audioPlayer setCurrentTime:newLoc];
}

- (IBAction)toggle:(id)sender {
    NSLog(@"playing: %li", [sender state]);
    if (1 == [sender state]){
        [self.audioPlayer play];
    }
    else
    {
        [self.audioPlayer pause];
    }
}

- (void)updateDisplay {
    float pctComplete = [self.audioPlayer currentTime] / [self.audioPlayer duration] * 100;

    NSLog(@"setting bar to: %3.2f", pctComplete);
    [self.progressSlider setFloatValue:pctComplete];
    
    // Most audio falls in the range of -60 - 0
    // so we'll add 60
    // anything below 0 is trunc'd to zero
    // anything above 60 is trunc'd to 60
    
    [self.audioPlayer updateMeters];
    float level = [self.audioPlayer averagePowerForChannel:0];
//    float db = ((level + 160 + tweak) / 160) * 10;
    float db = (level + 60) / 60 * 100;
    // Something isnt' write about the math in this line
    //float tweak = 60;
    //float db = (level + (120 - tweak) ) / (120 - tweak) * 100;
    
    NSLog(@"level: %f | db: %f", level, db);
    [self.volumeLevel setFloatValue:floor(db / 100 * self.volumeLevel.maxValue)];
}

@end
