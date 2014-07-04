//
//  DVAppDelegate.h
//  macSpriteGame
//

//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

@class AppDelegate;
@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet SKView *skView;
@property MapEditor *mapScene;
@property MainMenu *menuScene;

@end
