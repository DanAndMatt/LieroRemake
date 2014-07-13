//
//  MapEditor.h
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-30.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//



@class MapEditor;

@interface MapEditor : SKScene
@property Player *player;
@property Enemy *enemy;
@property Platform *platform;
@property NSMutableArray *platformList;
@property NSArray *paths;
@property NSString *docDir;
@property NSString *fullFileName;
@property Audio *audio;
@property int currentIcon;
@property SKSpriteNode *cursorBrickSprite;
@property SKSpriteNode *cursorCharSprite;
@property SKSpriteNode *dockIcon1;
@property SKSpriteNode *dockIcon2;
@property SKSpriteNode *dockIcon3;
@property SKSpriteNode *dockIcon4;
@property SKLabelNode *mousePostionLabel;
@property Boolean isErasing;
@property SKLabelNode *eraseLabel;
@property SKLabelNode *platformLabel;
@property SKLabelNode *saveLabel;
@property SKLabelNode *currentToolLabel;
@end

