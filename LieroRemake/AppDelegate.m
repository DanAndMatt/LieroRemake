//
//  DVAppDelegate.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-25.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window,mapScene,gameScene,menuScene;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

    
    menuScene = [[MainMenu alloc ]initYo:CGSizeMake(1024, 768)];
    
    menuScene.scaleMode = SKSceneScaleModeAspectFit;
    [self.skView presentScene:menuScene];
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
}



- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
