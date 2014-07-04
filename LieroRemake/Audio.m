//
//  Audio.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-30.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "KeyHeader.h"
@implementation Audio

@synthesize audioAction;

-(void)playAudio:(NSString*)audioTitle{
    
    audioAction = [SKAction playSoundFileNamed:audioTitle waitForCompletion:YES];
};
@end
