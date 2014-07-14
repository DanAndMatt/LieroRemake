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
//@property CGPoint *location;

-(void)moveCameraUp;
-(void)moveCameraDown;
-(void)moveCameraRight;
-(void)moveCameraLeft;
-(id)initWithPosition: (CGPoint)position;
@end
