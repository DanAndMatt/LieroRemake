//
//  MainMenu.h
//  LieroRemake
//
//  Created by Daniel Vaknine on 2014-07-03.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"
#import "Platform.h"
#import "Enemy.h"
#import "Audio.h"
#import "MapEditor.h"
#import "Bullet.h"
#import "MapEditor.h"
#import "MyScene.h"
@interface MainMenu : SKScene

@property MyScene *gameScene;
@property MapEditor *mapScene;
@end
