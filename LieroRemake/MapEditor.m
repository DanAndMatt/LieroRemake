//
//  MapEditor.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-30.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "MapEditor.h"

@implementation MapEditor

@synthesize player,platform,platformList,enemy,paths,docDir,fullFileName,audio;


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self loadPlatforms];

    }
    return self;
}


-(void)changeSceneToGameMode{
    SKTransition *reveal = [SKTransition
                            revealWithDirection:SKTransitionDirectionDown duration:1.0];
    MyScene *gameScene = [[MyScene alloc] initWithSize: CGSizeMake(1024,768)];
    
    [self.scene.view presentScene:gameScene transition:reveal ];
}

-(void)keyDown:(NSEvent *)theEvent{
    NSLog(@"%i",theEvent.keyCode);
    switch (theEvent.keyCode) {
        case 1: //S Save
            [self savePlatforms];
            break;
        case 46: //M MAP
            [self changeSceneToGameMode];
            break;
            
        case 8: //C Clean
            [self removePlatforms];
            break;
        default:
            break;
    }
}




-(void)mouseDown:(NSEvent *)theEvent {
    CGPoint location = [theEvent locationInNode:self];
    [self createPlatform:location.x :location.y];
}


/*
 * L O A D   & &  S A V E   && R E M O V E
 */

-(void)createPlatform: (float)x : (float)y{
    
    platform = [[Platform alloc]init];
    [platform createPlatform:x :y : @"platform"];
    [platformList addObject:platform];
    [self addChild:platform.sprite];
}


-(void)removePlatforms{
    [platformList removeAllObjects];
    [self savePlatforms];
    [self removeAllChildren];
    [self addChild:player.sprite];
    [self addChild:enemy.sprite];
}

-(void)savePlatforms{
    //NSLog(@"Platform i listan %d", (int)platforms.count);
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docDir = [paths objectAtIndex:0];
    fullFileName = [NSString stringWithFormat:@"%@/platforms",docDir];
    [NSKeyedArchiver archiveRootObject:platformList toFile:fullFileName];
    NSLog(@"Saved at: %@",fullFileName);
    
}

-(void)loadPlatforms{
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docDir = [paths objectAtIndex:0];
    fullFileName = [NSString stringWithFormat:@"%@/platforms",docDir];
    platformList = [NSKeyedUnarchiver unarchiveObjectWithFile:fullFileName];
    NSLog(@"Loaded at: %@",fullFileName);
    
    for(Platform *p in platformList){
        [self addChild:p.sprite];
    }
    
}

@end
