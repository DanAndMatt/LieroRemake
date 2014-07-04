//
//  Bullet.m
//  LieroRemake
//
//  Created by Mattias Linder on 2014-07-03.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//


#import "KeyHeader.h"
@implementation Bullet

@synthesize damage,angle,sprite,explode_area,velocity,acceleration,has_collided;

static const uint32_t player_category = 0x1 << 0;
static const uint32_t enemy_category = 0x1 << 3;
static const uint32_t bullet_category = 0x1 << 4;

-(NSObject*) init:(float)_angle :(float)_velocity :(float)_acceleration :(int)_damage :(NSString *)sprite_name :(float)_explode_area :(float)x_pos :(float)y_pos {
	damage = _damage;
    angle = _angle;
    velocity = _velocity;
    explode_area = _explode_area;
    acceleration = _acceleration;
    has_collided = false;
    
    sprite = [SKSpriteNode spriteNodeWithImageNamed:sprite_name];
    
    //Here you can change where the bullet is supposed to spawn, just change the
    // constant before cos and sin
    sprite.position = CGPointMake(x_pos + 50*cos(angle), y_pos + 50*sin(angle));

    sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
    [sprite.physicsBody setAffectedByGravity:true];
    sprite.physicsBody.dynamic = YES;
    sprite.physicsBody.mass= 1;
    //sprite.physicsBody.restitution=1;
    //sprite.physicsBody.linearDamping=0.2f;
    //sprite.physicsBody.angularDamping=0;
    
    sprite.physicsBody.categoryBitMask = bullet_category;
    sprite.physicsBody.collisionBitMask = player_category | enemy_category;
    sprite.physicsBody.contactTestBitMask = player_category | enemy_category;

	return self;
}

@end
