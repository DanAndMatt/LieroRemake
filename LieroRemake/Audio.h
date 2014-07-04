//
//  Audio.h
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-30.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//


@class Audio;
@interface Audio : NSObject


@property SKAction *audioAction;

-(void)playAudio:(NSString*)audioTitle;
@end
