//
//  MapEditor.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-30.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "KeyHeader.h"

@implementation MapEditor

@synthesize player,platform,platformList,enemy,paths,docDir,fullFileName,audio,currentIcon,cursorBrickSprite,cursorCharSprite,dockIcon1,dockIcon2,mousePostionLabel,isErasing,platformLabel,eraseLabel,saveLabel,currentToolLabel,dockIcon3,dockIcon4;


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


/* * * * * * * *
 *             *
 *             *
 * L A B E L S *
 *             *
 *             *
 * * * * * * * */


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



/* * * * * * * *
 *             *
 *             *
 * M O U S E   *
 *    &        *
 *  K E Y S    *
 *             *
 * * * * * * * */


-(void)mouseDown:(NSEvent *)theEvent {

    CGPoint location = [theEvent locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    [self checkMouseLocationOnMapAndCallCreateFunctions:node :location];

    

    
    
    


}

//NÄR EN PLATFORMS TAS BORT UPPDATERAS HELA LISTAN POSITIONER

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


/* * * * * * * *
 *             *
 *             *
 *    M A P    *
 *      &      *
 *   D O C K   *
 *             *
 * * * * * * * */

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
    
    dockIcon1 = [SKSpriteNode spriteNodeWithImageNamed:@"HeartShapedBox"];
    dockIcon1.position = [self checkPostionInGrid:CGPointMake(TILE_SIZE,11*TILE_SIZE )];
    dockIcon1.name = @"heartIcon";
    dockIcon1.zPosition = 0.3;
    [self addChild:dockIcon1];
    
    dockIcon2 = [SKSpriteNode spriteNodeWithImageNamed:@"Cload"];
    dockIcon2.position = [self checkPostionInGrid:CGPointMake(TILE_SIZE,12*TILE_SIZE )];
    dockIcon2.name = @"cloudIcon";
    dockIcon2.zPosition = 0.3;
    [self addChild:dockIcon2];
    
    dockIcon3 = [SKSpriteNode spriteNodeWithImageNamed:@"Water"];
    dockIcon3.position = [self checkPostionInGrid:CGPointMake(TILE_SIZE,13*TILE_SIZE )];
    dockIcon3.name = @"waterIcon";
    dockIcon3.zPosition = 0.3;
    [self addChild:dockIcon3];
    
    dockIcon4 = [SKSpriteNode spriteNodeWithImageNamed:@"Brick"];
    dockIcon4.position = [self checkPostionInGrid:CGPointMake(TILE_SIZE,14*TILE_SIZE )];
    dockIcon4.name = @"brickIcon";
    dockIcon4.zPosition = 0.3;
    [self addChild:dockIcon4];
}
-(void)changeToMenuScene{
    SKTransition *reveal = [SKTransition
                            revealWithDirection:SKTransitionDirectionDown duration:1.0];
    MainMenu *newScene = [[MainMenu alloc] initYo: CGSizeMake(1024,768)];
    
    [self.scene.view presentScene:newScene transition:reveal ];
}






-(NSPoint)checkPostionInGrid:(NSPoint)location{
    
    int modX = (int)location.x / TILE_SIZE;
    int modY = (int)location.y / TILE_SIZE;
    int x = 0;
    int y = 0;
    
    for(x = 0; x < SCREEN_WIDHT/TILE_SIZE; x++){
        if(modX == x){
            for(y = 0; y < SCREEN_HEIGHT/TILE_SIZE; y++){
                if(modY == y){
                    location = CGPointMake(x*TILE_SIZE + TILE_SIZE/2,y*TILE_SIZE + TILE_SIZE/2);
                    break;
                }
            }
        }
        
    }
    NSString * string =[ NSString stringWithFormat:@"X: %d Y: %d\n[%d|%d]",(int)location.x,(int)location.y,modX,modY];
    mousePostionLabel.text = string;
    
    return location;
}




-(void)checkMouseLocationOnMapAndCallCreateFunctions: (SKNode*)node : (CGPoint)location{
    platformLabel.text = [NSString stringWithFormat:@"Pressed: %@",node.name];
    if([node.name isEqualToString:@"heartIcon"]){
        currentIcon = ICON_HEART;
        currentToolLabel.text = @"Tool: Box";
        
        
    }
    if([node.name isEqualToString:@"cloudIcon"]){
        currentIcon = ICON_CLOUD;
        currentToolLabel.text = @"Tool: Cloud";
        
    }
    if([node.name isEqualToString:@"waterIcon"]){
        currentIcon = ICON_WATER;
        currentToolLabel.text = @"Tool: Water";
        
    }
    if([node.name isEqualToString:@"brickIcon"]){
        currentIcon = ICON_BRICK;
        currentToolLabel.text = @"Tool: Brick";
        
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
        if(currentIcon == ICON_HEART){
            [self createPlatform:gridPosition.x :gridPosition.y :@"HeartShapedBox"];
        }
        if(currentIcon == ICON_BRICK){
            [self createPlatform:gridPosition.x :gridPosition.y :@"Brick"];
        }
        if(currentIcon == ICON_CLOUD){
            [self createPlatform:gridPosition.x :gridPosition.y : @"Cload"];
            
        }
        if(currentIcon == ICON_WATER){
            [self createPlatform:gridPosition.x :gridPosition.y : @"Water"];
            
        }
        saveLabel.text =@"Not Saved";
    }
}



-(void)createPlatform: (float)x : (float)y : (NSString*) spriteName{
    int size = (int)platformList.count;
    NSString *str = [NSString stringWithFormat:@"platform%i",size];
    platform = [[Platform alloc]init];
    [platform createPlatform:x :y : spriteName];
    platform.sprite.name = str;
    platform.sprite.zPosition = 0.2;
    if([spriteName isEqualToString:@"HeartShapedBox"] || [spriteName isEqualToString:@"Brick"]){
        platform.sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platform.sprite.size];
        [platform.sprite.physicsBody setAffectedByGravity:false];
        [platform.sprite.physicsBody setAllowsRotation:false];
        [platform.sprite.physicsBody setDynamic:false];
    }
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





/*
 *
 * L O A D   & &  S A V E   && R E M O V E
 *
 */


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
