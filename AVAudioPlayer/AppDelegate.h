//
//  AppDelegate.h
//  AVAudioPlayer
//
//  Created by Chris Uzelac on 6/3/13.
//  Copyright (c) 2013 allecto.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>


@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) AVAudioPlayer *audioPlayer;
@property (strong) NSStatusItem *item;
@property (weak) IBOutlet NSSliderCell *progressSlider;
@property (weak) IBOutlet NSLevelIndicator *volumeLevel;
@property (weak) IBOutlet NSMenu *theMenu;

- (IBAction)takePctValueForProgressFrom:(id)sender;
- (IBAction)toggle:(id)sender;
- (void)updateDisplay;

@end
