//
//  MapEditor.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-30.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "KeyHeader.h"
#import "Camera.h"
@implementation MapEditor

@synthesize player,platform,platformList,enemy,paths,docDir,fullFileName,audio,currentTool,cursorBrickSprite,cursorCharSprite,dockIcon1,dockIcon2,mousePostionLabel,isErasing,platformLabel,eraseLabel,saveLabel,currentToolLabel,dockIcon3,dockIcon4,myWorld,camera;
static const uint32_t player_category = 0x1 << 0;
static const uint32_t enemy_category = 0x1 << 3;
static const uint32_t bullet_category = 0x1 << 4;
static const uint32_t rain_particle_category = 0x1 <<5;
static const uint32_t platform_category = 0x1 << 6;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        NSTrackingArea *trackingArea= [[NSTrackingArea alloc]initWithRect:[self.view bounds] options:NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingInVisibleRect owner:self.scene  userInfo:nil];
        [self.view addTrackingArea:trackingArea];
        self.backgroundColor = [SKColor grayColor];
       // NSLog(trackingArea.debugDescription);
        [self setUpWorldAndCamera];
        
        /*
        myWorld = [SKNode node];
        myWorld.name = @"theWorld";
        [self addChild:myWorld];
*/
        
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
   // [self addChild:mousePostionLabel];
    [myWorld addChild:mousePostionLabel];
    platformLabel = [SKLabelNode labelNodeWithFontNamed:@"chalkduster"];
    platformLabel.position = CGPointMake(100, self.frame.size.height-120);
    
    platformLabel.text =@"Platform: ";
    platformLabel.fontSize = 15;
    platformLabel.fontColor = [SKColor blackColor];
    platformLabel.zPosition = 0.5;
   // [self addChild:platformLabel];
    [myWorld addChild:platformLabel];
    
    eraseLabel = [SKLabelNode labelNodeWithFontNamed:@"chalkduster"];
    eraseLabel.position = CGPointMake(100, self.frame.size.height-140);
    
    eraseLabel.text = @"Erase: FALSE";
    eraseLabel.fontSize = 15;
    eraseLabel.fontColor = [SKColor blackColor];
    eraseLabel.zPosition = 0.5;
  //  [self addChild:eraseLabel];
    [myWorld addChild:eraseLabel];
    
    saveLabel = [SKLabelNode labelNodeWithFontNamed:@"chalkduster"];
    saveLabel.position = CGPointMake(100, self.frame.size.height-160);
    
    saveLabel.text = @"Loaded: ";
    saveLabel.fontSize = 15;
    saveLabel.fontColor = [SKColor blackColor];
    saveLabel.zPosition = 0.5;
   // [self addChild:saveLabel];
    [myWorld addChild:saveLabel];
    
    currentToolLabel = [SKLabelNode labelNodeWithFontNamed:@"chalkduster"];
    currentToolLabel.position = CGPointMake(100, self.frame.size.height-180);
    
    currentToolLabel.text = @"Tool: Mouse";
    currentToolLabel.fontSize = 15;
    currentToolLabel.fontColor = [SKColor blackColor];
    currentToolLabel.zPosition = 0.5;
    //[self addChild:currentToolLabel];
    [myWorld addChild:currentToolLabel];
    
    
    

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

-(void)mouseDragged:(NSEvent *)theEvent{
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
    NSLog(@"%i",theEvent.keyCode);
    switch (theEvent.keyCode) {
            
        case KEY_1:
            currentTool = ICON_BRICK;
            currentToolLabel.text = @"Tool: Brick";
            break;
        case KEY_2:
            currentTool = ICON_CLOUD;
            currentToolLabel.text = @"Tool: Cloud";

            break;
        case KEY_3:
            currentTool = ICON_HEART;
            currentToolLabel.text = @"Tool: Box";
            break;
        case KEY_4:
            currentTool = ICON_WATER;
            currentToolLabel.text = @"Tool: Water";

            break;
            
        case KEY_S:
            [self savePlatforms];
            break;
        case KEY_BACKSTEP:
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
            
        case KEY_UP:
            if(camera.node.position.y < 0){
            [camera moveCameraUp];
            mousePostionLabel.position = CGPointMake(mousePostionLabel.position.x, mousePostionLabel.position.y+32);
            eraseLabel.position = CGPointMake(eraseLabel.position.x, eraseLabel.position.y+32);
            platformLabel.position = CGPointMake(platformLabel.position.x, platformLabel.position.y+32);
            saveLabel.position = CGPointMake(saveLabel.position.x, saveLabel.position.y+32);
            currentToolLabel.position = CGPointMake(currentToolLabel.position.x, currentToolLabel.position.y +32);
            }
            break;
        case KEY_DOWN:
            if(camera.node.position.y > -SCREEN_HEIGHT){
            [camera moveCameraDown];
            mousePostionLabel.position = CGPointMake(mousePostionLabel.position.x, mousePostionLabel.position.y-32);
            eraseLabel.position = CGPointMake(eraseLabel.position.x, eraseLabel.position.y-32);
            
            platformLabel.position = CGPointMake(platformLabel.position.x, platformLabel.position.y-32);
            saveLabel.position = CGPointMake(saveLabel.position.x, saveLabel.position.y-32);
            currentToolLabel.position = CGPointMake(currentToolLabel.position.x, currentToolLabel.position.y -32);
            }
            break;
        case KEY_RIGHT:
            if(camera.node.position.x < SCREEN_WIDHT){

            [camera moveCameraRight];
            mousePostionLabel.position = CGPointMake(mousePostionLabel.position.x+32, mousePostionLabel.position.y);
            eraseLabel.position = CGPointMake(eraseLabel.position.x+32, eraseLabel.position.y);

            platformLabel.position = CGPointMake(platformLabel.position.x+32, platformLabel.position.y);
            saveLabel.position = CGPointMake(saveLabel.position.x+32, saveLabel.position.y);
            currentToolLabel.position = CGPointMake(currentToolLabel.position.x+32, currentToolLabel.position.y);
            }
            break;
        case KEY_LEFT:
            if(camera.node.position.x > 0){
            [camera moveCameraLeft];
            mousePostionLabel.position = CGPointMake(mousePostionLabel.position.x-32, mousePostionLabel.position.y);
            eraseLabel.position = CGPointMake(eraseLabel.position.x-32, eraseLabel.position.y);
            
            platformLabel.position = CGPointMake(platformLabel.position.x-32, platformLabel.position.y);
            saveLabel.position = CGPointMake(saveLabel.position.x-32, saveLabel.position.y);

            currentToolLabel.position = CGPointMake(currentToolLabel.position.x-32, currentToolLabel.position.y);
            }
        default:
            break;
    }
}


-(void)setUpWorldAndCamera{
    self.anchorPoint = CGPointMake(0.0, 0.0);
    myWorld = [SKNode node];
    myWorld.name = @"theWorld";
    //camera = [[Camera alloc ]initWithPosition:CGPointMake(self.frame.size.width/2,self.frame.size.height/2)];
    camera = [[Camera alloc ]initWithPosition:CGPointMake(0,0)];
    camera.node.name = @"camera";
    [self addChild:myWorld];
    [myWorld addChild:camera.node];
}

-(void)didSimulatePhysics{
    [self centerOnNode:[myWorld childNodeWithName:@"camera"]];
}

-(void)centerOnNode:(SKNode*)node{
    CGPoint cameraPositionInScene = [node.scene convertPoint:node.position fromNode:node.parent];
    node.parent.position = CGPointMake(node.parent.position.x - cameraPositionInScene.x, node.parent.position.y - cameraPositionInScene.y);
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
    SKSpriteNode *backgroundSprite1 = [SKSpriteNode spriteNodeWithImageNamed:@"MapEditor32pxGrid.png"];
    backgroundSprite1.name = @"Background";
    backgroundSprite1.anchorPoint = CGPointMake(0, 0);
    backgroundSprite1.position = CGPointMake(0, 0);
    backgroundSprite1.zPosition = 0.1;
    
    SKSpriteNode *backgroundSprite2 = [SKSpriteNode spriteNodeWithImageNamed:@"MapEditor32pxGrid.png"];
    backgroundSprite2.name = @"Background";
    backgroundSprite2.anchorPoint = CGPointMake(0, 0);
    backgroundSprite2.position = CGPointMake(SCREEN_WIDHT, 0);
    backgroundSprite2.zPosition = 0.1;
    
    SKSpriteNode *backgroundSprite3 = [SKSpriteNode spriteNodeWithImageNamed:@"MapEditor32pxGrid.png"];
    backgroundSprite3.name = @"Background";
    backgroundSprite3.anchorPoint = CGPointMake(0, 0);
    backgroundSprite3.position = CGPointMake(SCREEN_WIDHT, -SCREEN_HEIGHT);
    backgroundSprite3.zPosition = 0.1;
    
    
    SKSpriteNode *backgroundSprite4 = [SKSpriteNode spriteNodeWithImageNamed:@"MapEditor32pxGrid.png"];
    backgroundSprite4.name = @"Background";
    backgroundSprite4.anchorPoint = CGPointMake(0, 0);
    backgroundSprite4.position = CGPointMake(0, -SCREEN_HEIGHT);
    backgroundSprite4.zPosition = 0.1;

    [myWorld addChild:backgroundSprite1];
    [myWorld addChild:backgroundSprite2];
    [myWorld addChild:backgroundSprite3];
    [myWorld addChild:backgroundSprite4];

}


-(void)createDock{
    currentTool = 0;
    
    dockIcon1 = [SKSpriteNode spriteNodeWithImageNamed:@"HeartShapedBox"];
    dockIcon1.position = [self checkPostionInGrid:CGPointMake(TILE_SIZE,11*TILE_SIZE)];
    dockIcon1.name = @"heartIcon";
    dockIcon1.zPosition = 0.3;
    //[self addChild:dockIcon1];
    [myWorld addChild:dockIcon1];
    
    dockIcon2 = [SKSpriteNode spriteNodeWithImageNamed:@"Cload"];
    dockIcon2.position = [self checkPostionInGrid:CGPointMake(TILE_SIZE,12*TILE_SIZE)];
    dockIcon2.name = @"cloudIcon";
    dockIcon2.zPosition = 0.3;
    //[self addChild:dockIcon2];
    [myWorld addChild:dockIcon2];
    
    dockIcon3 = [SKSpriteNode spriteNodeWithImageNamed:@"Water"];
    dockIcon3.position = [self checkPostionInGrid:CGPointMake(TILE_SIZE,13*TILE_SIZE)];
    dockIcon3.name = @"waterIcon";
    dockIcon3.zPosition = 0.3;
    //[self addChild:dockIcon3];
    [myWorld addChild:dockIcon3];
    
    dockIcon4 = [SKSpriteNode spriteNodeWithImageNamed:@"Brick"];
    dockIcon4.position = [self checkPostionInGrid:CGPointMake(TILE_SIZE,14*TILE_SIZE )];
    dockIcon4.name = @"brickIcon";
    dockIcon4.zPosition = 0.3;
    [myWorld addChild:dockIcon4];
    //[self addChild:dockIcon4];
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
                    //location = CGPointMake(x*TILE_SIZE + TILE_SIZE/2,y*TILE_SIZE + TILE_SIZE/2);
                    location = CGPointMake(x*TILE_SIZE + TILE_SIZE/2 +camera.node.position.x,y*TILE_SIZE + TILE_SIZE/2+camera.node.position.y);
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
    [self checkPostionInGrid:location];
    if([node.name isEqualToString:@"heartIcon"]){
        currentTool = ICON_HEART;
        currentToolLabel.text = @"Tool: Box";
        
        
    }
    if([node.name isEqualToString:@"cloudIcon"]){
        currentTool = ICON_CLOUD;
        currentToolLabel.text = @"Tool: Cloud";
        
    }
    if([node.name isEqualToString:@"waterIcon"]){
        currentTool = ICON_WATER;
        currentToolLabel.text = @"Tool: Water";
        
    }
    if([node.name isEqualToString:@"brickIcon"]){
        currentTool = ICON_BRICK;
        currentToolLabel.text = @"Tool: Brick";
        
    }
    
    if(isErasing == true){
        for (int i = 0; i < platformList.count; i++) {
            NSString *str = [NSString stringWithFormat:@"platform%i",i];
            if([node.name isEqualToString:str]){
                Platform *p = [platformList objectAtIndex:i];
                [p.sprite removeFromParent];
                [platformList removeObject:p];
                platformLabel.text = [NSString stringWithFormat:@"Removed: %@",str];                
                [self renamePlatforms];
                break;
            }
        }
    }
    
    else if (isErasing == false && [node.name isEqualToString:@"Background"] == true){
        CGPoint gridPosition = [self checkPostionInGrid:location];
        if(currentTool == ICON_HEART){
            [self createPlatform:gridPosition.x :gridPosition.y :@"HeartShapedBox"];
        }
        if(currentTool == ICON_BRICK){
            [self createPlatform:gridPosition.x :gridPosition.y :@"Brick"];
        }
        if(currentTool == ICON_CLOUD){
            [self createPlatform:gridPosition.x :gridPosition.y : @"Cload"];
            
        }
        if(currentTool == ICON_WATER){
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
    platform.sprite.physicsBody.categoryBitMask = platform_category;
    platform.sprite.physicsBody.collisionBitMask = rain_particle_category;
    platform.sprite.physicsBody.contactTestBitMask = rain_particle_category;
    if([spriteName isEqualToString:@"HeartShapedBox"] || [spriteName isEqualToString:@"Brick"]){
        platform.sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:platform.sprite.size];
        [platform.sprite.physicsBody setAffectedByGravity:false];
        [platform.sprite.physicsBody setAllowsRotation:false];
        [platform.sprite.physicsBody setDynamic:false];
    }
    [platformList addObject:platform];
   // [self addChild:platform.sprite];
    [myWorld addChild:platform.sprite];
    platformLabel.text = [NSString stringWithFormat:@"Created: %@",str];
}


-(void)removePlatforms{
    [platformList removeAllObjects];
    [self savePlatforms];
    [self removeAllChildren];
    //[self addChild:player.sprite];
    //[self addChild:enemy.sprite];
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
      //  [self addChild:p.sprite];
        [myWorld addChild:p.sprite];
    }
    
}

@end
