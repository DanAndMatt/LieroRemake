//
//  Camera.h
//  LieroRemake
//
//  Created by Daniel Vaknine on 2014-07-13.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//


@class Camera;
@interface Camera : NSObject


@property SKNode *node;
@property bool isMovingRight;
@property bool isMovingLeft;
@property bool isMovingUp;
@property bool isMovingDown;
@property int speed;
//@property CGPoint *location;

-(void)moveCameraUp;
-(void)moveCameraDown;
-(void)moveCameraRight;
-(void)moveCameraLeft;
-(void)moveCamera;
-(id)initWithPosition: (CGPoint)position :(int)_speed;
@end
