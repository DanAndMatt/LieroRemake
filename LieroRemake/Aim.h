//
//  Aim.h
//  macSpriteGame
//
//  Created by Mattias Linder on 2014-07-01.
//  Copyright (c) 2014 Mattias Linder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
@interface Aim : NSObject

@property SKSpriteNode *sprite;
@property bool up;
@property bool down;
@property double angle;
@property float radius;

-(NSObject*) init:(float)player_x_pos :(float)player_y_pos;

-(void) updateAim:(float)player_x_pos :(float)player_y_pos :(bool)player_aims_right;

@end
