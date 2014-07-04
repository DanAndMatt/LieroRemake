//
//  Bullet.h
//  LieroRemake
//
//  Created by Mattias Linder on 2014-07-03.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

@class Bullet;
@interface Bullet : NSObject

@property float angle;
@property int damage;
@property float explode_area;
@property SKSpriteNode* sprite;
@property float velocity;
@property float acceleration;
@property bool has_collided;

-(NSObject*) init:(float)_angle :(float)_velocity :(float)_acceleration :(int)_damage :(NSString*)sprite_name :(float)_explode_area :(float)x_pos :(float)y_pos;

@end
