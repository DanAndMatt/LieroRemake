//
//  DVMyScene.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-25.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "KeyHeader.h"

@implementation MyScene
@synthesize player,platform,platformList,enemy,paths,docDir,fullFileName,audio,engineEmitter,engineSmokeEmitter,myWorld,camera;

static const uint32_t player_category = 0x1 << 0;
static const uint32_t enemy_category = 0x1 << 3;
static const uint32_t bullet_category = 0x1 << 4;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
      //  self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
       self.backgroundColor = [SKColor colorWithRed:0.40 green:0.15 blue:0.3 alpha:1.0];
        // ----NEW------
        //self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        //--------------
        
       //[self createBackground];
        //

        [self setUpWorldAndCamera];
        [self loadPlatforms];
        [self createEnemy];
        [player superAnimateFunction:@"worm" :3 :@"WormRight"];
        [self createRain];
        [self createSmoke];
        [self playThemeSong];
        

        
    }
    return self;
}


-(void)setUpWorldAndCamera{
    self.anchorPoint = CGPointMake(0.5, 0.2);
    myWorld = [SKNode node];
    myWorld.name = @"theWorld";
    [self addChild:myWorld];
    [self createPlayer];
    [myWorld addChild:player.sprite];
}

-(void)didSimulatePhysics{
    [self centerOnNode:[myWorld childNodeWithName:@"Player"]];
}

-(void)centerOnNode:(SKNode*)node{
    CGPoint cameraPositionInScene = [node.scene convertPoint:node.position fromNode:node.parent];
    node.parent.position = CGPointMake(node.parent.position.x - cameraPositionInScene.x, node.parent.position.y - cameraPositionInScene.y);
}

-(void)playThemeSong{
    SKAction *song = [SKAction playSoundFileNamed:@"Raining.wav" waitForCompletion:YES];
    song = [SKAction repeatActionForever:song];
    [self runAction:song];
}

-(void)createBackground{
    SKSpriteNode *backgroundSprite = [SKSpriteNode spriteNodeWithImageNamed:@"RainbowBG.png"];
    backgroundSprite.anchorPoint = CGPointMake(0, 0);
    backgroundSprite.position = CGPointMake(0, 0);
    backgroundSprite.name = @"MySceneBackgroundSprite";
    //[self addChild:backgroundSprite];
    [myWorld addChild:backgroundSprite];
}

/*
 *  C R E A T E  S E T T I N G S
 */

-(void)createPlayer{
    player = [[Player alloc]init];
    player.sprite.name = @"Player";
    //[self addChild:player.sprite];
    // [player animateChar];
    //[player.sprite.physicsBody setAffectedByGravity:false];
    player.sprite.physicsBody.categoryBitMask = player_category;
    player.sprite.physicsBody.collisionBitMask = enemy_category | bullet_category;
    player.sprite.physicsBody.contactTestBitMask = enemy_category | bullet_category;
    [myWorld addChild:player.aim.sprite];
    
}
-(void)createEnemy{
    enemy = [[Enemy alloc]init];
    enemy.sprite.name = @"Enemy";
    //[self addChild:enemy.sprite];
    //[enemy.sprite.physicsBody setAffectedByGravity:false];
    enemy.sprite.physicsBody.categoryBitMask = enemy_category;
	enemy.sprite.physicsBody.collisionBitMask = player_category;
    enemy.sprite.physicsBody.contactTestBitMask = player_category;
    [myWorld addChild:enemy.sprite];
    
}


-(void)createRain{
    engineEmitter = [NSKeyedUnarchiver
                          unarchiveObjectWithFile:
                          [[NSBundle mainBundle]
                           pathForResource:@"RainParticle" ofType:@"sks"]];
    engineEmitter.position = CGPointMake(self.frame.size.width/2 +100, self.frame.size.height);
    engineEmitter.name = @"rainParticle";
   // [self addChild:engineEmitter];
    engineEmitter.hidden = NO;
}



-(void)createSmoke{
    engineSmokeEmitter = [NSKeyedUnarchiver
                     unarchiveObjectWithFile:
                     [[NSBundle mainBundle]
                      pathForResource:@"SmokeParticle" ofType:@"sks"]];
    engineSmokeEmitter.position = CGPointMake(848, 400);
    engineSmokeEmitter.name = @"smokeParticle";
   // [self addChild:engineSmokeEmitter];
    engineSmokeEmitter.hidden = NO;
}



//Change Scene To MapEdit


-(void)changeToMenuScene{
    SKTransition *reveal = [SKTransition
                            revealWithDirection:SKTransitionDirectionDown duration:1.0];
    MainMenu *newScene = [[MainMenu alloc] initYo: CGSizeMake(1024,768)];
    
    [self.scene.view presentScene:newScene transition:reveal ];
}
-(void)keyDown:(NSEvent *)theEvent{
    
    //NSLog(@"%i",theEvent.keyCode);
    switch (theEvent.keyCode) {

		case KEY_Z: //Z
        {
            //z, is for shooting
            //(float)_angle :(float)_velocity :(float)_acceleration :(int)_damage :(NSString*)sprite_name :(float)_explode_area :(float)x_pos :(float)y_pos
            [player createBullet:player.aim.angle :10.0 :1.0 :1 :@"pistol_bullet" :1.0 :player.sprite.position.x :player.sprite.position.y];
			Bullet* bulleter = [player.bullets objectAtIndex:player.bullet_index];
			player.bullet_index++;
            //NSLog(@"-------------");
           // [self addChild:bulleter.sprite];
            [myWorld addChild:bulleter.sprite];
            //NSLog(@"++++++++++++++");
        }
            break;
        case KEY_C:
        {
            //[myWorld addChild:[player shoot]];
        }
            break;
        case KEY_SPACE: //Space
            player.isJumping = YES;
            [player jump];
            break;
        case KEY_RIGHT: //Right
            [player setMovingRightToTrue];
            break;
        case KEY_LEFT: //left
            [player setMovingLeftToTrue];
            break;
        case KEY_M: //M MAP
            player.sprite.position = CGPointMake(100, 600);
            break;
            
        case KEY_DOWN: //Down
            player.aim.down = true;
            break;
        case KEY_UP: //UP
            player.aim.up = true;
            break;
            
        case KEY_ESQ: //ESq
            [self changeToMenuScene];
            break;
        default:
            break;
    }
    
}

-(void)keyUp:(NSEvent *)theEvent{
    switch (theEvent.keyCode) {
        case KEY_RIGHT: //RIGHT
            player.isMovingRight = false;
            break;
        case KEY_LEFT: //LEFT
            player.isMovingLeft = false;
            break;
            
        case KEY_DOWN: //Down
            player.aim.down = false;
            break;
        case KEY_UP: //UP
            player.aim.up = false;
            break;
        default:
            break;
    }
}

/*
 * P L A Y    S O U N D S
 */


-(void)playSound{
    audio = [[Audio alloc]init];[audio playAudio:@"introLevel.wav"];
    [self runAction:audio.audioAction];
}


/*
 * L O A D  &  S A V E   &  R E M O V E
 */



-(void)loadPlatforms{
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docDir = [paths objectAtIndex:0];
    fullFileName = [NSString stringWithFormat:@"%@/platforms",docDir];
    platformList = [NSKeyedUnarchiver unarchiveObjectWithFile:fullFileName];
    for(Platform *p in platformList){
        [myWorld addChild:p.sprite];
    }
    
}


/*
 * C O L L I S I O N
 */
-(void) didBeginContact:(SKPhysicsContact *)contact {
    
	// Collision between enemy and a bullet
   	if (((contact.bodyA.categoryBitMask == bullet_category) &&
        (contact.bodyB.categoryBitMask == enemy_category))
        					||
        ((contact.bodyB.categoryBitMask == bullet_category) &&
        (contact.bodyA.categoryBitMask == enemy_category))) {
       
    	[enemy.sprite removeFromParent];
        enemy = NULL;
        [self createEnemy];
    
    }
    // Collision beetween player and a bullet
    if(((contact.bodyA.categoryBitMask == bullet_category) &&
        (contact.bodyB.categoryBitMask == player_category))
       						||
       ((contact.bodyB.categoryBitMask == bullet_category) &&
        (contact.bodyA.categoryBitMask == player_category))) {
    
    	[player.sprite removeFromParent];
        [player.aim.sprite removeFromParent];
        player.aim = NULL;
        player = NULL;
        [self createPlayer]; 
    }
    //Collision between the floor and a bullet
    if(((contact.bodyA.categoryBitMask == bullet_category) &&
        (contact.bodyB.categoryBitMask == -1))
       						||
       ((contact.bodyB.categoryBitMask == bullet_category) &&
        (contact.bodyA.categoryBitMask == -1))) {
			if (contact.bodyA.categoryBitMask == bullet_category) {
                SKNode* bullet = contact.bodyA.node;
				[bullet runAction:[SKAction removeFromParent]];
			} else {
                SKNode* bullet = contact.bodyB.node;

                //add explosion sprite
                CGPoint location = CGPointMake(bullet.position.x, bullet.position.y);
                SKSpriteNode* explosion = [SKSpriteNode spriteNodeWithImageNamed:@"explosion"];
				explosion.position = location;
                explosion.name = @"explosionId";
                //[self addChild:explosion];
                [myWorld addChild:explosion];
                //make it move
                NSMutableArray *explosionFrames = [NSMutableArray array];
                SKTextureAtlas *explosionAtlas =
                [SKTextureAtlas atlasNamed:@"explosions"];
                for (int i = 1; i <= explosionAtlas.textureNames.count; ++i)
                {
                    NSString *texture =
                    [NSString stringWithFormat:@"explosion%d", i];
                    [explosionFrames addObject:[explosionAtlas textureNamed:texture]];
                }
                //SKNode *explosionNode = [self childNodeWithName:@"explosionNode"];
                SKAction *animate = [SKAction animateWithTextures:explosionFrames timePerFrame:0.05 resize:YES restore:YES];
				[animate setDuration:1.0];

                [explosion runAction:animate withKey:@"theExplosion"];

                [bullet runAction:[SKAction removeFromParent]];
            }
       }
}


-(void)removeExplosionAction{
    SKNode *node = [self childNodeWithName:@"explosionId"];
    if(![node hasActions]){
        [node removeFromParent];
    }
}
/*
 *  U P D A T E
 */
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [player moveDirection];
    [player.aim updateAim:player.sprite.position.x :player.sprite.position.y :player.aims_right];
    [player moveBullets];
    [self removeExplosionAction];
    
    //NSLog(@"Player Postion X: %i Y: %i",(int)player.sprite.position.x,(int)player.sprite.position.y);
    [myWorld addChild:[player shoot]];
    
}

@end
