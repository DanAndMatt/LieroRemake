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
@end
