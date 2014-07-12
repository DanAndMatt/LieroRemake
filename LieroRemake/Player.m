//
//  Player.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-25.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "KeyHeader.h"

@implementation Player

@synthesize hp,sprite,x,y,name,location,hpLabel,angle,isMovingRight,isStopingPlayer,isMovingLeft,isJumping,aim,aims_right,bullets,bullet_index,sprite_textures;



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

-(void)createSmgKaliber:(float)_angle :(float)x_pos :(float)y_pos {
	Smg_kaliber* bullet = [[Smg_kaliber alloc] init:_angle :x_pos :y_pos];
    [bullets addObject:bullet];
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
    x = sprite.position.x;
    y = sprite.position.y;
    SKAction *moveUp = [SKAction moveBy:CGVectorMake(0, 150) duration:0.3];
    [sprite runAction:moveUp];
        isJumping = false;
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



-(void)animateMovement{
    SKAction *animation = [SKAction animateWithTextures:sprite_textures timePerFrame:0.05];
    animation = [SKAction repeatAction:animation count:1];
    [sprite runAction:animation];
}

-(void)moveBullets {
	for(int i = 0; i < bullet_index; i++) {
    	Bullet* bullet = [bullets objectAtIndex:i];
        bullet.sprite.position = CGPointMake(bullet.sprite.position.x + cos(bullet.angle)*bullet.velocity, bullet.sprite.position.y + sin(bullet.angle)*bullet.velocity);
    }
}
@end