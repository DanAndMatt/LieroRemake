//
//  Camera.m
//  LieroRemake
//
//  Created by Daniel Vaknine on 2014-07-13.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "KeyHeader.h"
@implementation Camera
@synthesize node,isMovingDown,isMovingUp,isMovingLeft,isMovingRight,speed;

-(id)initWithPosition: (CGPoint)position :(int)_speed{
    if(self = [super init]){
        node = [SKNode node];
        node.position = position;
        speed = _speed;
    }
    return self;
}

-(id)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)moveCamera{
    if(isMovingRight){
        [self moveCameraRight];
    }
    if(isMovingLeft){
        [self moveCameraLeft];
    }
    if(isMovingDown){
        [self moveCameraDown];
    }
    if(isMovingUp){
        [self moveCameraUp];
    }
}

-(void)moveCameraUp{
    if(node.position.y < 0){
        node.position = CGPointMake(node.position.x, node.position.y+speed);
    }
}
-(void)moveCameraDown{
   if(node.position.y > -SCREEN_HEIGHT){
        
        node.position = CGPointMake(node.position.x, node.position.y-speed);
    }
}
-(void)moveCameraRight{
    if(node.position.x < SCREEN_WIDHT){
        
        node.position = CGPointMake(node.position.x+speed, node.position.y);
    }
}
-(void)moveCameraLeft{
    if(node.position.x > 0){
        
        node.position = CGPointMake(node.position.x-speed, node.position.y);
    }
}

@end
