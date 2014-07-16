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

@synthesize sprite,up,down,angle_in_radians,radius,aim_at_max;

-(NSObject*) init:(float)player_x_pos :(float)player_y_pos {
    radius = 200.0;
    angle_in_radians = 0.0;
	sprite = [SKSpriteNode spriteNodeWithImageNamed:@"aim2.png"];
	sprite.position = CGPointMake(radius * cos(angle_in_radians) + player_x_pos, radius * sin(angle_in_radians) + player_y_pos);
    return self;
}

-(void) moveAimDown:(float)player_x_pos :(float)player_y_pos :(bool)aims_right{
    /*if (180*acos(cos(angle))/M_PI >= 90 && aims_right) {
        aim_at_max = true;
        angle = M_PI/2;
	} else if (180*acos(cos(angle))/M_PI <= 90 && !aims_right) {
        aim_at_max = true;
        angle = M_PI/2;
    } else*/ if ((180*acos(cos(angle_in_radians))/M_PI <= 90 && aims_right) || (180*acos(cos(angle_in_radians))/M_PI >= 90 && aims_right)) {
        angle_in_radians -= 0.03;
    } else if (180*acos(cos(angle_in_radians))/M_PI <= 90 && !aims_right) {
    	aim_at_max = true;
        angle_in_radians = M_PI/2;
    } else if ((180*acos(cos(angle_in_radians))/M_PI >= 90 && !aims_right) || (180*acos(cos(angle_in_radians))/M_PI <= 90 && !aims_right)) {
    	angle_in_radians -= 0.03;
    }
}

-(void) moveAimUp:(float)player_x_pos :(float)player_y_pos :(bool)aims_right{
    /*if(aim_at_max && aims_right) {
        NSLog(@"aimsright aimmax");
    	return;
    } else if (aim_at_max && !aims_right) {
		NSLog(@"aimsleft aimmax");
        return;
    } else */if (AIM_ANGLE(angle_in_radians) >= 90 && aims_right) {
        aim_at_max = true;
        angle_in_radians = M_PI/2;
    } else if (AIM_ANGLE(angle_in_radians) <= 90 && aims_right) {
		aim_at_max = false;
    	angle_in_radians += 0.03;
    } else if (AIM_ANGLE(angle_in_radians) >= 90 && !aims_right){
		aim_at_max = false;
    	angle_in_radians += 0.03;
    } 
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
    
    sprite.position = CGPointMake(radius * cos(angle_in_radians) + player_x_pos, radius * sin(angle_in_radians) + player_y_pos);
}
@end
