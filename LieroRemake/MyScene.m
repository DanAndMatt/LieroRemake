//
//  DVMyScene.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-25.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "MyScene.h" 

@implementation MyScene
@synthesize player,platform,platformList,enemy,paths,docDir,fullFileName,audio;

static const uint32_t player_category = 0x1 << 0;
static const uint32_t enemy_category = 0x1 << 3;
static const uint32_t bullet_category = 0x1 << 4;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
       self.backgroundColor = [SKColor colorWithRed:0.40 green:0.15 blue:0.3 alpha:1.0];
        // ----NEW------
        //self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        //--------------
        
        [self loadPlatforms];
        [self createEnemy];
        [self createPlayer];
        [player superAnimateFunction:@"worm" :3 :@"WormRight"];
    }
    return self;
}

/*
 *  C R E A T E  S E T T I N G S
 */

-(void)createPlayer{
    player = [[Player alloc]init];
    [self addChild:player.sprite];
    // [player animateChar];
    player.sprite.physicsBody.categoryBitMask = player_category;
    player.sprite.physicsBody.collisionBitMask = enemy_category;
    player.sprite.physicsBody.contactTestBitMask = enemy_category;
    [self addChild:player.aim.sprite];
    
}
-(void)createEnemy{
    enemy = [[Enemy alloc]init];
    //[self addChild:enemy.sprite];
    enemy.sprite.physicsBody.categoryBitMask = enemy_category;
	enemy.sprite.physicsBody.collisionBitMask = player_category;
    enemy.sprite.physicsBody.contactTestBitMask = player_category;
    [self addChild:enemy.sprite];
    
}


-(void)startRaing{
    SKSpriteNode *rainSprite = [SKSpriteNode spriteNodeWithImageNamed:@"char22"];
    rainSprite.position = CGPointMake(rand()*1000%1024, 600);
    rainSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rainSprite.size];
    [self addChild:rainSprite];
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

		case 6:
        {
            //z, is for shooting
            //(float)_angle :(float)_velocity :(float)_acceleration :(int)_damage :(NSString*)sprite_name :(float)_explode_area :(float)x_pos :(float)y_pos
            [player createBullet:player.aim.angle :10.0 :1.0 :1 :@"pistol_bullet" :1.0 :player.sprite.position.x :player.sprite.position.y];
			Bullet* bulleter = [player.bullets objectAtIndex:player.bullet_index];
			player.bullet_index++;
            //NSLog(@"-------------");
            [self addChild:bulleter.sprite];
            //NSLog(@"++++++++++++++");
        }
            break;
        case 49: //Space
            [player jumpPlayer];
            break;
        case 124: //Right
            [player setMovingRightToTrue];
            break;
        case 123: //left
            [player setMovingLeftToTrue];
            break;
        case 46: //M MAP
            break;
            
        case 125: //Down
            player.aim.down = true;
            break;
        case 126: //UP
            player.aim.up = true;
            break;
            
        case 53: //ESq
            [self changeToMenuScene];
            break;
        default:
            break;
    }
    
}

-(void)keyUp:(NSEvent *)theEvent{
    switch (theEvent.keyCode) {
        case 124: //RIGHT
            player.isMovingRight = false;
            break;
        case 123: //LEFT
            player.isMovingLeft = false;
            break;
            
        case 125: //Down
            player.aim.down = false;
            break;
        case 126: //UP
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
 * L O A D   & &  S A V E   && R E M O V E
 */



-(void)loadPlatforms{
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docDir = [paths objectAtIndex:0];
    fullFileName = [NSString stringWithFormat:@"%@/platforms",docDir];
    platformList = [NSKeyedUnarchiver unarchiveObjectWithFile:fullFileName];
    for(Platform *p in platformList){
        [self addChild:p.sprite];
    }
    
}

-(void) didBeginContact:(SKPhysicsContact *)contact {
    
	// Collision between enemy and a bullet
   	if (((contact.bodyA.categoryBitMask == bullet_category) &&
        (contact.bodyB.categoryBitMask == enemy_category))
        					||
        ((contact.bodyB.categoryBitMask == bullet_category) &&
        (contact.bodyA.categoryBitMask == enemy_category))) {
        NSLog(@"vad hande nu=!?!");
    	[enemy.sprite removeFromParent];
        enemy = NULL;
        [self createEnemy];
    }
    
    
    //NSLog(@"BodyA: %i, BodyB: %i",contact.bodyA.collisionBitMask,contact.bodyB.collisionBitMask);
    /*
    if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        first_body = contact.bodyA;
        second_body = contact.bodyB;
    } else {
        first_body = contact.bodyB;
        second_body = contact.bodyA;
    }
    
    if((first_body.categoryBitMask & enemy_category) == 1) {
        NSLog(@"enemy?");
    }
    if((first_body.categoryBitMask & player_category) == 1 && (first_body.collisionBitMask != -1) && (second_body.collisionBitMask != -1)) {
        //NSLog(@"player and enemy collide BOOM BOOM BOOM");
        //NSLog(@"first: %i, second: %i, player: %i, enemy: %i, %i, %i",first_body.categoryBitMask, second_body.categoryBitMask, player_category, enemy_category,first_body.collisionBitMask, second_body.collisionBitMask);
        //player = NULL;
		[player.sprite removeFromParent];
        [player.aim.sprite removeFromParent];
        player.aim = NULL;
        player = NULL;
        [self createPlayer];
    }
    if((first_body.categoryBitMask & enemy_category) == 1 && (first_body.collisionBitMask != -1) && (second_body.collisionBitMask != -1)) {
        NSLog(@"vad hande nu=!?!");
    	[enemy.sprite removeFromParent];
        enemy = NULL;
        [self createEnemy];
    }
    //if((second_body.categoryBitMask & enemy_category) == 1) {
    //	NSLog(@"vad hande nu=!?!");
    //}
    if((second_body.categoryBitMask & player_category) == 1) { //TROR DETTA ÄR MARK OCH SPELARE
      //  NSLog(@"WTFTWTFWF=!?!, category %i, testBit %i",second_body.categoryBitMask,second_body.contactTestBitMask);
    	NSLog(@"!!!""##");
    }
*/
}

/*
 *  U P D A T E
 */
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [player moveDirection];
    [player.aim updateAim:player.sprite.position.x :player.sprite.position.y :player.aims_right];
    [player moveBullets];
    
}
@end
