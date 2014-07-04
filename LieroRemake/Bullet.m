//
//  Bullet.m
//  LieroRemake
//
//  Created by Mattias Linder on 2014-07-03.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//


#import "KeyHeader.h"
@implementation Bullet

@synthesize damage,angle,sprite,explode_area,velocity,acceleration;

-(NSObject*) init:(float)_angle :(float)_velocity :(float)_acceleration :(int)_damage :(NSString *)sprite_name :(float)_explode_area :(float)x_pos :(float)y_pos {
	damage = _damage;
    angle = _angle;
    velocity = _velocity;
    explode_area = _explode_area;
    acceleration = _acceleration;
    
    sprite = [SKSpriteNode spriteNodeWithImageNamed:sprite_name];
    sprite.position = CGPointMake(x_pos, y_pos);

    sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
    [sprite.physicsBody setAffectedByGravity:true];
    sprite.physicsBody.dynamic = YES;
    sprite.physicsBody.mass= 1;
    sprite.physicsBody.restitution=1;
    sprite.physicsBody.linearDamping=0.2f;
    sprite.physicsBody.angularDamping=0;

	return self;
}

@end
