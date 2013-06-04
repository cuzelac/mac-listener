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
@property (strong) AVAudioRecorder *recorder;
@property (weak) IBOutlet NSSliderCell *progressSlider;
@property (weak) IBOutlet NSLevelIndicator *volumeLevel;

- (IBAction)toggle:(id)sender;
- (void)updateDisplay;

@end
