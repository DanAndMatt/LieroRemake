//
//  Smg_kaliber.m
//  LieroRemake
//
//  Created by Mattias Linder on 2014-07-04.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "Smg_kaliber.h"

@implementation Smg_kaliber

static const uint32_t player_category = 0x1 << 0;
static const uint32_t enemy_category = 0x1 << 3;
static const uint32_t bullet_category = 0x1 << 4;

-(NSObject*)init:(float)_angle :(float)x_pos :(float)y_pos {
    self.velocity = 30.0;
    self.acceleration = 3.0;
    self.damage = 4.0;
    self.explode_area = 2.0;
    self.has_collided = false;
    self.angle = _angle;
    
    //Setting up the sprite for a 9mm bullet
    self.sprite = [SKSpriteNode spriteNodeWithImageNamed:@"9mm"];
    self.sprite.position = CGPointMake(x_pos + 50.0*cos(_angle), y_pos + 50*sin(_angle));
    self.sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.sprite.size];
    [self.sprite.physicsBody setAffectedByGravity:false];
    //self.sprite.physicsBody.dynamic = YES;
    self.sprite.physicsBody.mass= 0.0001;
    //sprite.physicsBody.restitution=1;
    //sprite.physicsBody.linearDamping=0.2f;
    //sprite.physicsBody.angularDamping=0;
    
    self.sprite.physicsBody.categoryBitMask = bullet_category;
    self.sprite.physicsBody.collisionBitMask = player_category | enemy_category;
    self.sprite.physicsBody.contactTestBitMask = player_category | enemy_category;
    
	return self;
}

@end
