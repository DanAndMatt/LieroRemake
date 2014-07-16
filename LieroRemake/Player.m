//
//  Player.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-25.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "KeyHeader.h"

@implementation Player

@synthesize hp,sprite,x,y,name,location,hpLabel,angle,isMovingRight,isStopingPlayer,isMovingLeft,isJumping,aim,aims_right,bullet_list,bullet_index,sprite_textures,bullet_type,isShooting,timer,grenade_ammo,smg_ammo,isRealoading;



-(void)createPlayer{
    smg_ammo = SMG_NEW_MAGAZINE;
    grenade_ammo = GRENADE_NEW_MAGAZINE;
    isJumping = true;
    name = @"Player";
    hp = 10;
    hpLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    hpLabel.text = [NSString stringWithFormat:@"%@: %d",name, hp];
    hpLabel.fontSize = 20;
    hpLabel.color = [SKColor redColor];
    hpLabel.position = CGPointMake(100 , 100);
    //sprite = [SKSpriteNode spriteNodeWithImageNamed:@"BothLeg"];
    
    //SKTexture *f1 = [SKTexture textureWithImageNamed:@"BothLeg.png"];
    SKTexture *f1 = [SKTexture textureWithImageNamed:@"Frog_walk_forward.png"];
    sprite = [SKSpriteNode spriteNodeWithTexture:f1];
    sprite.xScale *= 6.0;
    sprite.yScale *= 6.0;
    location = CGPointMake(100, 600);
    sprite.position = location;
    //Fysik
    sprite.zPosition = 1.0;
    sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
    sprite.physicsBody.mass= 70;
    sprite.physicsBody.categoryBitMask = 10;
    [sprite.physicsBody setAllowsRotation:false];
    [sprite.physicsBody setDynamic:true];
    
	bullet_list = [[NSMutableArray alloc] init];
    bullet_index = 0;
    bullet_type = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(hej) userInfo:self repeats:NO];
}

-(SKAction*)reload {
    smg_ammo = SMG_NEW_MAGAZINE;
    SKAction *reloadSound = [SKAction playSoundFileNamed:@"ReloadSound.wav" waitForCompletion:true];
    isRealoading = false;
    return reloadSound;
}

-(void)createAim{
    aim = [[Aim alloc]init:sprite.position.x :sprite.position.y];
    aims_right = true;
}


-(void)createBullet:(float)_angle :(float)_velocity :(float)_acceleration :(int)_damage :(NSString *)sprite_name :(float)_explode_area :(float)x_pos :(float)y_pos {
	Bullet* bullet = [[Bullet alloc] init:_angle :_velocity :_acceleration :_damage :sprite_name :_explode_area :x_pos :y_pos];
    [bullet_list addObject:bullet];
    //NSLog(@"CREATED BULLET");
}

-(void)createSmgKaliber:(float)_angle :(float)x_pos :(float)y_pos {
	Smg_kaliber* bullet = [[Smg_kaliber alloc] init:_angle :x_pos :y_pos];
    [bullet_list addObject:bullet];
}

-(id)init{
    [self createPlayer];
    [self createAim];
    return self;
}



-(void)setMovingRightToTrue{
    if(aims_right == false){
        aim.angle -= M_PI;
        aim.angle *= -1;
    }
    isMovingRight = true;
    isStopingPlayer = false;
    aims_right = true;
}
-(void)setMovingLeftToTrue{
    if(aims_right){
        aim.angle = M_PI - aim.angle;
    }
    isMovingLeft = true;
    isStopingPlayer = false;
    aims_right = false;
    
    //added this
    //aim.aim_at_max = false;
}

-(void)moveDirection{
    x = sprite.position.x;
    y = sprite.position.y;
    
    if(isMovingRight == true){
       sprite.position = CGPointMake(x+5,y);
    }
    if (isMovingLeft == true){
        sprite.position = CGPointMake(x-5, y);
    }
    //}
    
}

-(SKSpriteNode*)shoot{
    //SKAction *audioShot = [SKAction playSoundFileNamed:@"Shot.wav" waitForCompletion:YES];
    //[self runAction:audioShot];
    if(timer.isValid) {
        return nil;
    } else {
	    switch (bullet_type) {
    	    case SMG: {
                if(smg_ammo > 0) {
        			[self createSmgKaliber:aim.angle :sprite.position.x :sprite.position.y];
                    smg_ammo--;
                } else {
                	//TIMER WIHO
                    isRealoading = true;
                    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(hej) userInfo:self repeats:NO];
                    return nil;

                }
            	break;
        	case GRENADE:
                if(grenade_ammo > 0) {
            	[self createBullet:aim.angle :10.0 :1.0 :1 :@"pistol_bullet" :1.0 :sprite.position.x :sprite.position.y];
                grenade_ammo--;
                } else {
                	//TIMER WIHO
                    grenade_ammo = GRENADE_NEW_MAGAZINE;
                    return nil;
                }
            	break;
            }
    	}
        Bullet* b = [bullet_list objectAtIndex:bullet_index];
    	bullet_index++;
    	return b.sprite;
    }
}

-(void)jump{
    x = sprite.position.x;
    y = sprite.position.y;
  //  SKAction *moveUp = [SKAction moveBy:CGVectorMake(0, 150) duration:0.3];
    //[sprite runAction:moveUp];
        isJumping = false;
    sprite.physicsBody.velocity = CGVectorMake(0, 800);
}


-(void)superAnimateFunction: (NSString*) sprite_name : (int) suffix : (NSString*) atlas_name {
    NSMutableArray *stringArray = [[NSMutableArray alloc]init];

    for(int i = 1; i <= suffix; i++ ){
        NSString * generic_sprite_name = [NSString localizedStringWithFormat:@"%@%i",sprite_name,i];
        [stringArray addObject:generic_sprite_name];
    }
    
    sprite_textures = [[NSMutableArray alloc]init];
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:atlas_name];
    for(int i = 0; i < suffix; i++){
        SKTexture *texture =[atlas textureNamed:[stringArray objectAtIndex:i]];
        [sprite_textures addObject:texture];
    }
    

}

-(void)handle_timer {

}

-(void)animateMovement{
    SKAction *animation = [SKAction animateWithTextures:sprite_textures timePerFrame:0.05];
    animation = [SKAction repeatAction:animation count:1];
    [sprite runAction:animation];
}

-(void)moveBullets {
	for(int i = 0; i < bullet_index; i++) {
    	Bullet* bullet = [bullet_list objectAtIndex:i];
        bullet.sprite.position = CGPointMake(bullet.sprite.position.x + cos(bullet.angle)*bullet.velocity, bullet.sprite.position.y + sin(bullet.angle)*bullet.velocity);
    }
}
@end