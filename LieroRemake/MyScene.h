//
//  DVMyScene.h
//  macSpriteGame
//

//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"
#import "Platform.h"
#import "Enemy.h"
#import "Audio.h"
#import "MapEditor.h"
@interface MyScene : SKScene <SKPhysicsContactDelegate> //This tells that we are using the SKPhysicsContactDelegate delegate

@property Player *player;
@property Enemy *enemy;
@property Platform *platform;
@property NSMutableArray *platformList;
@property NSArray *paths;
@property NSString *docDir;
@property NSString *fullFileName;
@property Audio *audio;
@end
