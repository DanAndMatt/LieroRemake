//
//  Enemy.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-30.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "KeyHeader.h"
@implementation Enemy

@synthesize hp,sprite,x,y,name,location,hpLabel,angle,isMovingRight,isStopingPlayer,isMovingLeft,isJumping;


-(void)createEnemy{
    isJumping = true;
    name = @"Enemy";
    hp = 10;
    hpLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    hpLabel.text = [NSString stringWithFormat:@"%@: %d",name, hp];
    hpLabel.fontSize = 20;
    hpLabel.position = CGPointMake(200, 300);
    sprite = [SKSpriteNode spriteNodeWithImageNamed:@"char2"];
    sprite.position = CGPointMake(200, 200);
    
    location = CGPointMake(700, 600);
    sprite.position = location;
    //Fysik
    sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
    sprite.physicsBody.mass= 70;
    [sprite.physicsBody setAllowsRotation:false];
    [sprite.physicsBody setDynamic:true];
    
}

-(id)init{
    [self createEnemy];
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


-(void)jumpEnemy{
    
    if(isJumping == true){
        x = sprite.position.x;
        y = sprite.position.y;
        sprite.position = CGPointMake(x, y+50);
        isJumping = true;
    }
}

@end
