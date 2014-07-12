//
//  MapEditor.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-30.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "KeyHeader.h"


@implementation MapEditor

@synthesize player,platform,platformList,enemy,paths,docDir,fullFileName,audio,currentIcon,cursorBrickSprite,cursorCharSprite,dockIcon1,dockIcon2,mousePostionLabel,isErasing,platformLabel,eraseLabel,saveLabel,currentToolLabel;


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        NSTrackingArea *trackingArea= [[NSTrackingArea alloc]initWithRect:[self.view bounds] options:NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingInVisibleRect owner:self.scene  userInfo:nil];
        [self.view addTrackingArea:trackingArea];
        self.backgroundColor = [SKColor grayColor];
       // NSLog(trackingArea.debugDescription);
        [self createMousePositionLabel];
        [self loadMapGrid];
        [self loadPlatforms];
        [self createDock];

    }
    return self;
}



-(void)createMousePositionLabel{
    mousePostionLabel = [SKLabelNode labelNodeWithFontNamed:@"chalkduster"];
    mousePostionLabel.position = CGPointMake(100, self.frame.size.height-100);
    mousePostionLabel.text = @"Hi";
    mousePostionLabel.fontColor = [SKColor blackColor];
    mousePostionLabel.fontSize = 15;
    mousePostionLabel.zPosition = 0.5;
    [self addChild:mousePostionLabel];
    
    platformLabel = [SKLabelNode labelNodeWithFontNamed:@"chalkduster"];
    platformLabel.position = CGPointMake(100, self.frame.size.height-120);
    
    platformLabel.text =@"Platform: ";
    platformLabel.fontSize = 15;
    platformLabel.fontColor = [SKColor blackColor];
    platformLabel.zPosition = 0.5;
    [self addChild:platformLabel];
    
    eraseLabel = [SKLabelNode labelNodeWithFontNamed:@"chalkduster"];
    eraseLabel.position = CGPointMake(100, self.frame.size.height-140);
    
    eraseLabel.text = @"Erase: FALSE";
    eraseLabel.fontSize = 15;
    eraseLabel.fontColor = [SKColor blackColor];
    eraseLabel.zPosition = 0.5;
    [self addChild:eraseLabel];
    
    saveLabel = [SKLabelNode labelNodeWithFontNamed:@"chalkduster"];
    saveLabel.position = CGPointMake(100, self.frame.size.height-160);
    
    saveLabel.text = @"Loaded: ";
    saveLabel.fontSize = 15;
    saveLabel.fontColor = [SKColor blackColor];
    saveLabel.zPosition = 0.5;
    [self addChild:saveLabel];
    
    currentToolLabel = [SKLabelNode labelNodeWithFontNamed:@"chalkduster"];
    currentToolLabel.position = CGPointMake(100, self.frame.size.height-180);
    
    currentToolLabel.text = @"Tool: Mouse";
    currentToolLabel.fontSize = 15;
    currentToolLabel.fontColor = [SKColor blackColor];
    currentToolLabel.zPosition = 0.5;
    [self addChild:currentToolLabel];
    
    
    

}


/*
 *
 * MOuse Events AND KEYBOARD
 *
 */

-(NSPoint)checkPostionInGrid:(NSPoint)location{
    
    int modX = (int)location.x / TILE_SIZE;
    int modY = (int)location.y / TILE_SIZE;
    int x = 0;
    int y = 0;
   // CGPoint gridPostion = CGPointMake(0, 0);
    for(x = 0; x < SCREEN_WIDHT/TILE_SIZE; x++){
        if(modX == x){
            for(y = 0; y < SCREEN_HEIGHT/TILE_SIZE; y++){
                if(modY == y){
                    location = CGPointMake(x*TILE_SIZE + TILE_SIZE/2,y*TILE_SIZE + TILE_SIZE/2);
                    //NSLog(@"NEW POS: [X: %d, Y: %d ]",(int)gridPostion.x,(int)gridPostion.y);
                    break;
                }
            }
        }
        
    }
    NSString * string =[ NSString stringWithFormat:@"X: %d Y: %d\n[%d|%d]",(int)location.x,(int)location.y,modX,modY];
    mousePostionLabel.text = string;
    
    return location;
}



-(void)mouseDown:(NSEvent *)theEvent {

    

    CGPoint location = [theEvent locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:location];
    //NSLog(@"%@",node.name);
    platformLabel.text = [NSString stringWithFormat:@"Pressed: %@",node.name];
    if([node.name isEqualToString:@"brickIcon"]){
        currentIcon = ICON_BRICK;
        currentToolLabel.text = @"Tool: Box";

        
    }
    if([node.name isEqualToString:@"cloudIcon"]){
        currentIcon = ICON_CLOUD;
        currentToolLabel.text = @"Tool: Cloud";

    }
    
    
    
	if(isErasing == true){
        for (int i = 0; i < platformList.count; i++) {
            NSString *str = [NSString stringWithFormat:@"platform%i",i];
            if([node.name isEqualToString:str]){
                SKNode *node = [self childNodeWithName:str];
                [node removeFromParent];
                [platformList removeObjectIdenticalTo:[platformList objectAtIndex:i]];
                platformLabel.text = [NSString stringWithFormat:@"Removed: %@",str];

                [self renamePlatforms];
                break;
            }
        }
    }
    
    else if (isErasing == false && [node.name isEqualToString:@"Background"] == true){
        CGPoint gridPosition = [self checkPostionInGrid:location];
        if(currentIcon == ICON_BRICK){
            [self createPlatform:gridPosition.x :gridPosition.y :@"HeartShapedBox"];
        }
        if(currentIcon == ICON_CLOUD){
            [self createPlatform:gridPosition.x :gridPosition.y : @"Cload"];
            
        }
        saveLabel.text =@"Not Saved";
    }
    
    
    


}



-(void)renamePlatforms{
    int i = 0;
    for(i = 0; i < platformList.count; i++){
        NSString *str = [NSString stringWithFormat:@"platform%i",i];
        Platform *p = [platformList objectAtIndex:i];
        p.sprite.name = str;
    }


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
        case KEY_SPACE:
            if(isErasing == true){
                isErasing = false;
                eraseLabel.text =@"ERASE: FALSE";

            }
            else if(isErasing == false){
                isErasing = true;
                eraseLabel.text =@"ERASE: TRUE";

            }
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


/*
 *
 * MAP CRETATOR
 *
 */

-(void)loadMapGrid{
    SKSpriteNode *backgroundSprite = [SKSpriteNode spriteNodeWithImageNamed:@"MapEditor32pxGrid.png"];
    backgroundSprite.name = @"Background";
    backgroundSprite.anchorPoint = CGPointMake(0, 0);
    backgroundSprite.position = CGPointMake(0, 0);
    backgroundSprite.zPosition = 0.1;
    [self addChild:backgroundSprite];
}


-(void)createDock{
    currentIcon = 0;
    
    dockIcon1 = [SKSpriteNode spriteNodeWithImageNamed:@"HeartShapedBox.png"];
    dockIcon1.position = [self checkPostionInGrid:CGPointMake(14*TILE_SIZE,TILE_SIZE )];
    dockIcon1.name = @"brickIcon";
    dockIcon1.zPosition = 0.3;
    [self addChild:dockIcon1];
    
    dockIcon2 = [SKSpriteNode spriteNodeWithImageNamed:@"Cload.png"];
    dockIcon2.position = [self checkPostionInGrid:CGPointMake(11*TILE_SIZE,TILE_SIZE )];
    dockIcon2.name = @"cloudIcon";
    dockIcon2.zPosition = 0.3;
    [self addChild:dockIcon2];
}
-(void)changeToMenuScene{
    SKTransition *reveal = [SKTransition
                            revealWithDirection:SKTransitionDirectionDown duration:1.0];
    MainMenu *newScene = [[MainMenu alloc] initYo: CGSizeMake(1024,768)];
    
    [self.scene.view presentScene:newScene transition:reveal ];
}





/*
 *
 * L O A D   & &  S A V E   && R E M O V E
 *
 */



-(void)createPlatform: (float)x : (float)y : (NSString*) spriteName{
    int size = (int)platformList.count;
    NSString *str = [NSString stringWithFormat:@"platform%i",size];
    platform = [[Platform alloc]init];
    [platform createPlatform:x :y : spriteName];
    platform.sprite.name = str;
    platform.sprite.zPosition = 0.2;
    [platformList addObject:platform];
    [self addChild:platform.sprite];
    platformLabel.text = [NSString stringWithFormat:@"Created: %@",str];
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
    saveLabel.text = [NSString stringWithFormat:@"Saved Map"];

    
}

-(void)loadPlatforms{
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docDir = [paths objectAtIndex:0];
    fullFileName = [NSString stringWithFormat:@"%@/platforms",docDir];
    platformList = [NSKeyedUnarchiver unarchiveObjectWithFile:fullFileName];
    //NSLog(@"Loaded at: %@",fullFileName);
    saveLabel.text = [NSString stringWithFormat:@"Loaded Map"];

    for(Platform *p in platformList){
        [self addChild:p.sprite];
    }
    
}

@end
