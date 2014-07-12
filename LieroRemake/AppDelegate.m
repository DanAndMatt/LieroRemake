//
//  DVAppDelegate.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-25.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "KeyHeader.h"
@implementation AppDelegate

@synthesize window = _window,mapScene,menuScene;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{


    


    menuScene = [[MainMenu alloc ]initYo:CGSizeMake(SCREEN_WIDHT, SCREEN_HEIGHT)];
    
    menuScene.scaleMode = SKSceneScaleModeAspectFit;
    [self.skView presentScene:menuScene];
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
    
    
}




- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
