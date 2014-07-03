//
//  Player.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-25.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize hp,sprite,x,y,name,location,hpLabel,angle,isMovingRight,isStopingPlayer,isMovingLeft,isJumping,aim,aims_right,bullets,bullet_index;



-(void)createPlayer{
    isJumping = true;
    name = @"Player";
    hp = 10;
    hpLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    hpLabel.text = [NSString stringWithFormat:@"%@: %d",name, hp];
    hpLabel.fontSize = 20;
    hpLabel.color = [SKColor redColor];
    hpLabel.position = CGPointMake(100 , 100);
    //sprite = [SKSpriteNode spriteNodeWithImageNamed:@"BothLeg"];
    
    SKTexture *f1 = [SKTexture textureWithImageNamed:@"BothLeg.png"];
    sprite = [SKSpriteNode spriteNodeWithTexture:f1];
    location = CGPointMake(100, 600);
    sprite.position = location;
    //Fysik
    sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
    sprite.physicsBody.mass= 70;
    sprite.physicsBody.categoryBitMask = 10;
    [sprite.physicsBody setAllowsRotation:false];
    [sprite.physicsBody setDynamic:true];
    
	bullets = [[NSMutableArray alloc] init];
    bullet_index = 0;
}


-(void)createAim{
    aim = [[Aim alloc]init:sprite.position.x :sprite.position.y];
    aims_right = true;
}


-(void)createBullet:(float)_angle :(float)_velocity :(float)_acceleration :(int)_damage :(NSString *)sprite_name :(float)_explode_area :(float)x_pos :(float)y_pos {
	Bullet* bullet = [[Bullet alloc] init:_angle :_velocity :_acceleration :_damage :sprite_name :_explode_area :x_pos :y_pos];
    [bullets addObject:bullet];
    //NSLog(@"CREATED BULLET");
}

-(id)init{
    [self createPlayer];
    [self createAim];
    return self;
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


-(void)jumpPlayer{
    
    if(isJumping == true){
        x = sprite.position.x;
        y = sprite.position.y;
        sprite.position = CGPointMake(x, y+50);
        isJumping = true;
    }
}


-(void)superAnimateFunction: (NSString*) sprite_name : (int) suffix : (NSString*) atlas_name {
    NSMutableArray *stringArray = [[NSMutableArray alloc]init];

    for(int i = 1; i <= suffix; i++ ){
        NSString * generic_sprite_name = [NSString localizedStringWithFormat:@"%@%i",sprite_name,i];
        [stringArray addObject:generic_sprite_name];
    }
    
    NSMutableArray *sprite_textures = [[NSMutableArray alloc]init];
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:atlas_name];
    for(int i = 0; i < suffix; i++){
        SKTexture *texture =[atlas textureNamed:[stringArray objectAtIndex:i]];
        [sprite_textures addObject:texture ];
    }
    
    SKAction *animation = [SKAction animateWithTextures:sprite_textures timePerFrame:0.05];
    animation = [SKAction repeatActionForever:animation];
    [sprite runAction:animation];
}

-(void)moveBullets {
	for(int i = 0; i < bullet_index; i++) {
    	Bullet* bullet = [bullets objectAtIndex:i];
        bullet.sprite.position = CGPointMake(bullet.sprite.position.x + cos(bullet.angle)*bullet.velocity, bullet.sprite.position.y + sin(bullet.angle)*bullet.velocity);
    }
}
@end










/*
 -(void)animateChar{
 SKTextureAtlas *atlasRightLeg = [SKTextureAtlas atlasNamed:@"RightLeg"];
 SKTexture *bothLegs = [atlasRightLeg textureNamed:@"BothLeg"];
 SKTexture *rightLeg1 = [atlasRightLeg textureNamed:@"RightLeg1.png"];
 SKTexture *rightLeg2 = [atlasRightLeg textureNamed:@"RightLeg2.png"];
 SKTexture *rightLeg3 = [atlasRightLeg textureNamed:@"RightLeg3.png"];
 
 SKTextureAtlas *atlasLeftLeg = [SKTextureAtlas atlasNamed:@"LeftLeg"];
 SKTexture *leftLeg1 = [atlasLeftLeg textureNamed:@"LeftLeg1.png"];
 SKTexture *leftLeg2 = [atlasLeftLeg textureNamed:@"LeftLeg2.png"];
 SKTexture *leftLeg3 = [atlasLeftLeg textureNamed:@"LeftLeg3.png"];
 
 
 
 NSArray *enemyWalkTextures = @[bothLegs,rightLeg1,rightLeg2,rightLeg3,rightLeg2,rightLeg2,rightLeg1,bothLegs,leftLeg1,leftLeg2,leftLeg3,leftLeg2,leftLeg1];
 
 SKAction *walkAnimation = [SKAction animateWithTextures:enemyWalkTextures
 timePerFrame:0.05];
 
 
 walkAnimation = [SKAction repeatActionForever:walkAnimation];
 [sprite runAction:walkAnimation];
 }
 
 */