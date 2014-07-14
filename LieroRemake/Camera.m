//
//  Camera.m
//  LieroRemake
//
//  Created by Daniel Vaknine on 2014-07-13.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "KeyHeader.h"
@implementation Camera
@synthesize node;
static const int speed = 32;

-(id)initWithPosition: (CGPoint)position{
    if(self = [super init]){
        NSLog(@"Camera Funkar");
        node = [SKNode node];
        node.position = position;
    }
    return self;
}

-(id)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)moveCameraUp{
    node.position = CGPointMake(node.position.x, node.position.y+speed);
}
-(void)moveCameraDown{
    node.position = CGPointMake(node.position.x, node.position.y-speed);
}
-(void)moveCameraRight{
    node.position = CGPointMake(node.position.x+speed, node.position.y);
}
-(void)moveCameraLeft{
    node.position = CGPointMake(node.position.x-speed, node.position.y);
}

@end
