//
//  Audio.h
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-30.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <SpriteKit/SpriteKit.h>
@interface Audio : NSObject


@property SKAction *audioAction;

-(void)playAudio:(NSString*)audioTitle;
@end
