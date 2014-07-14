//
//  Player.h
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-25.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//


#import "Aim.h"
#import "Bullet.h"
#import "Smg_kaliber.h"

@class Player;
@interface Player : NSObject



@property int hp;
@property float x;
@property float y;
@property CGPoint location;
@property NSString *name;
@property int bullet_type;
@property SKLabelNode *hpLabel;
@property SKSpriteNode *sprite;
@property float angle;
@property BOOL isMovingRight;
@property BOOL isStopingPlayer;
@property BOOL isMovingLeft;
@property BOOL isJumping;
@property BOOL isShooting;
@property Aim *aim;
@property BOOL aims_right;
@property NSMutableArray* bullet_list;
@property int bullet_index;
@property NSTimer* timer;
@property int grenade_ammo;
@property int smg_ammo;

@property NSMutableArray *sprite_textures;



-(void)setMovingRightToTrue;
-(void)setMovingLeftToTrue;
-(void)moveDirection;
-(void)jump;
//-(void)animateChar;
-(void)superAnimateFunction: (NSString*) sprite_name : (int) suffix : (NSString*) atlas_name;
-(void)createBullet:(float)_angle :(float)_velocity :(float)_acceleration :(int)_damage :(NSString*)sprite_name :(float)_explode_area :(float)x_pos :(float)y_pos;
-(void)createSmgKaliber:(float)_angle :(float)x_pos :(float)y_pos;
-(void)moveBullets;
-(void)animateMovement;

-(SKSpriteNode*)shoot;
@end
