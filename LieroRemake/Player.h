//
//  Player.h
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-25.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Aim.h"
@interface Player : NSObject



@property int hp;
@property float x;
@property float y;
@property CGPoint location;
@property NSString *name;
@property SKLabelNode *hpLabel;
@property SKSpriteNode *sprite;
@property float angle;
@property BOOL isMovingRight;
@property BOOL isStopingPlayer;
@property BOOL isMovingLeft;
@property BOOL isJumping;
@property Aim *aim;
@property BOOL aims_right;


-(void)moveDirection;
-(void)jumpPlayer;
//-(void)animateChar;
-(void)superAnimateFunction: (NSString*) sprite_name : (int) suffix : (NSString*) atlas_name;
@end
