//
//  Platform.m
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-27.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "KeyHeader.h"
@implementation Platform

@synthesize sprite;



-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.sprite forKey:@"sprite"];
  //  NSLog(@"encoded sprite");
}

-(id)initWithCoder:(NSCoder *) decoder {
    //    NSLog(@"decoded sprite");
    if(self = [super init]){
      self.sprite = [decoder decodeObjectForKey:@"sprite"];
    }
    return self;
}



-(void)createPlatform: (float)x : (float)y  :(NSString *)name {
    
    sprite = [SKSpriteNode spriteNodeWithImageNamed:name];
    //sprite.anchorPoint = CGPointMake(0, 0);
    sprite.position = CGPointMake(x, y);

}

@end
