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
#import "Bullet.h"
#import "MyScene.h"
#import "MapEditor.h"

@class MainMenu;
@interface MainMenu : SKScene

@property SKLabelNode *gameLabel;
@property SKLabelNode *mapLabel;
@property SKSpriteNode *cursorSprite;
@property bool pressedEnterKey;
@property int cursor;

-(id)initYo: (CGSize)size;
@end
