//
//  MainMenu.m
//  LieroRemake
//
//  Created by Daniel Vaknine on 2014-07-03.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "MainMenu.h"

@implementation MainMenu

@synthesize mapScene,gameScene;

-(id)initWidthSize: (CGSize)size {
    
    if(self = [super initWithSize:size]){
        
        
    }
    
    return self;
}



-(void)startNewGame{
    SKTransition *reveal = [SKTransition
                            revealWithDirection:SKTransitionDirectionDown duration:1.0];
    gameScene = [[MyScene alloc] initWithSize: CGSizeMake(1024,768)];
    
    [self.scene.view presentScene:gameScene transition:reveal ];
}

-(void)startMapEditor{
    SKTransition *reveal = [SKTransition
                            revealWithDirection:SKTransitionDirectionDown duration:1.0];
    mapScene = [[MapEditor alloc] initWithSize: CGSizeMake(1024,768)];
    
    [self.scene.view presentScene:mapScene transition:reveal ];
}

-(void)keyDown:(NSEvent *)theEvent{
    switch(theEvent.keyCode){
        case 8:
            [self startNewGame];
            break;
        case 9:
            [self startMapEditor];
            break;
        default:
            break;
    }
}


@end
