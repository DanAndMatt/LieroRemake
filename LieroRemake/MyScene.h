//
//  DVMyScene.h
//  macSpriteGame
//

//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//
#import "Bullet.h"
@class MyScene;
@interface MyScene : SKScene <SKPhysicsContactDelegate> //This tells that we are using the SKPhysicsContactDelegate delegate

@property Player *player;
@property Enemy *enemy;
@property Platform *platform;
@property NSMutableArray *platformList;
@property NSArray *paths;
@property NSString *docDir;
@property NSString *fullFileName;
@property Audio *audio;
@property (strong, nonatomic) SKEmitterNode *engineEmitter;
@property (strong, nonatomic) SKEmitterNode *engineSmokeEmitter;
@property SKNode *myWorld;
@property SKNode *camera;

@property SKLabelNode *positionLabel;
@property SKLabelNode *collisionLabel;
@end

