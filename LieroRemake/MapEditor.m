//
//  MapEditor.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-30.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "KeyHeader.h"

@implementation MapEditor

@synthesize player,platform,platformList,enemy,paths,docDir,fullFileName,audio,currentIcon;


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self loadPlatforms];
        [self createDock];
        
    }
    return self;
}



-(void)createDock{
    currentIcon = 0;
    float xMidle =self.frame.size.width/2;
    float y = 50;
    SKSpriteNode *dockSprite = [SKSpriteNode spriteNodeWithImageNamed:@"DockForMapEditor.png"];
    dockSprite.position = CGPointMake(xMidle,y);
    [self addChild:dockSprite];
    
    
    SKSpriteNode *dockIcon1 = [SKSpriteNode spriteNodeWithImageNamed:@"platform"];
    dockIcon1.position = CGPointMake((xMidle-45), y);
    dockIcon1.name = @"brickIcon";
    [self addChild:dockIcon1];
    
    SKSpriteNode *dockIcon2 = [SKSpriteNode spriteNodeWithImageNamed:@"char22"];
    dockIcon2.position = CGPointMake(xMidle-140, y);
    dockIcon2.name = @"charIcon";
    [self addChild:dockIcon2];
}
-(void)changeToMenuScene{
    SKTransition *reveal = [SKTransition
                            revealWithDirection:SKTransitionDirectionDown duration:1.0];
    MainMenu *newScene = [[MainMenu alloc] initYo: CGSizeMake(1024,768)];
    
    [self.scene.view presentScene:newScene transition:reveal ];
}

-(void)keyDown:(NSEvent *)theEvent{
   // NSLog(@"%i",theEvent.keyCode);
    switch (theEvent.keyCode) {
        case KEY_S:
            [self savePlatforms];
            break;
        case KEY_X:
            [self removeLastPlatform];
            break;
        case KEY_M:
            break;
        case KEY_C:
            [self removePlatforms];
            break;
        case KEY_ESQ:
            [self changeToMenuScene];
            break;
        default:
            break;
    }
}




-(void)mouseDown:(NSEvent *)theEvent {
    CGPoint location = [theEvent locationInNode:self];
    NSLog(@"[X: %f Y: %f]",location.x,location.y);
    SKNode *node = [self nodeAtPoint:location];
    NSLog(@"%@",node.name);
    if([node.name isEqualToString:@"brickIcon"]){
        currentIcon = ICON_BRICK;
    }
    if([node.name isEqualToString:@"charIcon"]){
        currentIcon = ICON_CHAR;
    }
    
    if(currentIcon == ICON_BRICK && location.y > 120){
        [self createPlatform:location.x :location.y];
        
    }
    if(currentIcon == ICON_CHAR && location.y > 120){
        [self createChar:location.x :location.y];
        
    }
    //[self createPlatform:location.x :location.y];
}


/*
 * L O A D   & &  S A V E   && R E M O V E
 */

-(void)createChar:(float)x : (float)y{

    SKSpriteNode *charSprite =  [SKSpriteNode spriteNodeWithImageNamed:@"char22"];
    charSprite.position = CGPointMake(x, y);
    charSprite.name = @"charSprite";
    [self addChild:charSprite];
}
-(void)createPlatform: (float)x : (float)y{
    
    platform = [[Platform alloc]init];
    [platform createPlatform:x :y : @"platform"];
    platform.sprite.name = @"platform";
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

-(void)removeLastPlatform{
    if(platformList.count > 0){
        Platform *p = [platformList objectAtIndex:platformList.count-1];
        [p.sprite removeFromParent];
        [platformList removeLastObject];
    }

    
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
