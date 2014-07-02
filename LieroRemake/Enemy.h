//
//  Enemy.h
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-30.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>


@interface Enemy : NSObject

@property int hp;
@property float x;
@property float y;
@property NSString *name;
@property SKLabelNode *hpLabel;
@property SKSpriteNode *sprite;
@property CGPoint location;
@property float angle;
@property BOOL isMovingRight;
@property BOOL isStopingPlayer;
@property BOOL isMovingLeft;
@property BOOL isJumping;

-(void)moveDirection;
-(void)jumpEnemy;


@end
