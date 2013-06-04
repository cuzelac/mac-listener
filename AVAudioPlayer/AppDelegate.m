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
    NSString *filePath = @"/dev/null";
    NSLog(@"%@", filePath);
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:filePath];
    NSLog(@"%@", [fileURL absoluteString]);
    
    NSDictionary *audioSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt:AVAudioQualityMedium],AVEncoderAudioQualityKey,
                                   [NSNumber numberWithInt:16],AVEncoderBitRateKey,
                                   [NSNumber numberWithInt: 1],AVNumberOfChannelsKey,
                                   [NSNumber numberWithFloat:44100.0],AVSampleRateKey,
                                   nil];

    [self setRecorder:[[AVAudioRecorder alloc] initWithURL:fileURL settings:audioSettings error:nil]];
    [self.recorder prepareToRecord];
    [self.recorder setMeteringEnabled:YES];
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(updateDisplay) userInfo:nil repeats:YES];
}


- (IBAction)toggle:(id)sender {
    NSLog(@"playing: %li", [sender state]);
    if (1 == [sender state]){
        [self.recorder record];
    }
    else
    {
        [self.recorder stop];
    }
}

- (void)updateDisplay {
    float tweak = 0.0; //-20.0;
    [self.recorder updateMeters];
    float level = [self.recorder averagePowerForChannel:0];
    float db = ((level + 160 + tweak) / 160) * 20;
    
    NSLog(@"level: %f | db: %f", level, db);
    [self.volumeLevel setFloatValue:db];
}
@end
