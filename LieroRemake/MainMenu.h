//
//  MainMenu.h
//  LieroRemake
//
//  Created by Daniel Vaknine on 2014-07-03.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

@class MainMenu;
@interface MainMenu : SKScene

@property SKLabelNode *gameLabel;
@property SKLabelNode *mapLabel;
@property SKSpriteNode *cursorSprite;
@property bool pressedEnterKey;
@property int cursor;
@property Audio *menuSong;
-(id)initYo: (CGSize)size;
@end
