//
//  Aim.m
//  macSpriteGame
//
//  Created by Mattias Linder on 2014-07-01.
//  Copyright (c) 2014 Mattias Linder. All rights reserved.
//

#import "KeyHeader.h"
@interface Aim() 

-(void) moveAimDown:(float)player_x_pos :(float)player_y_pos :(bool)aims_right;

-(void) moveAimUp:(float)player_x_pos :(float)player_y_pos :(bool)aims_right;

@end

@implementation Aim

@synthesize sprite,up,down,angle,radius;

-(NSObject*) init:(float)player_x_pos :(float)player_y_pos {
    radius = 200.0;
    angle = 0.0;
	sprite = [SKSpriteNode spriteNodeWithImageNamed:@"aim"];
	sprite.position = CGPointMake(radius * cos(angle) + player_x_pos, radius * sin(angle) + player_y_pos);
    return self;
}

-(void) moveAimDown:(float)player_x_pos :(float)player_y_pos :(bool)aims_right{
    if (180*acos(cos(angle))/M_PI <= 93 && aims_right) {
        angle -= 0.03;
    } else if (180*acos(cos(angle))/M_PI >90 && !aims_right) {
    	angle -= 0.03;
    }
	//sprite.position = CGPointMake(radius * cos(angle) + player_x_pos, radius * sin(angle) + player_y_pos);
}

-(void) moveAimUp:(float)player_x_pos :(float)player_y_pos :(bool)aims_right{
    if (180*acos(cos(angle))/M_PI < 86 && aims_right) {
    	angle += 0.03;
    } else if (180*acos(cos(angle))/M_PI > 90 && !aims_right){
    	angle += 0.03;
    }
	//sprite.position = CGPointMake(radius * cos(angle) + player_x_pos, radius * sin(angle) + player_y_pos);
}

-(void) updateAim:(float)player_x_pos :(float)player_y_pos :(bool)player_aims_right{
    
    if (up) {
        if (player_aims_right)
            [self moveAimUp:player_x_pos :player_y_pos :player_aims_right];
        else {
        	[self moveAimDown:player_x_pos :player_y_pos :player_aims_right];
        }
    } if (down) {
        if (player_aims_right) {
        	[self moveAimDown:player_x_pos :player_y_pos :player_aims_right];
        } else {
            [self moveAimUp:player_x_pos :player_y_pos :player_aims_right];
        }
    } else {
    	//sprite.position = CGPointMake(player_x_pos + radius * cos(angle), sprite.position.y);
    }
    
    sprite.position = CGPointMake(radius * cos(angle) + player_x_pos, radius * sin(angle) + player_y_pos);
}
@end
