//
//  MainMenu.m
//  LieroRemake
//
//  Created by Daniel Vaknine on 2014-07-03.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

#import "MainMenu.h"

@implementation MainMenu
#define KEY_M 46
#define KEY_N 45
@synthesize mapLabel,gameLabel;


-(id)initYo: (CGSize)size {
    
    if(self = [super initWithSize:size]){
        mapLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        mapLabel.text = @"Map Editor";
        mapLabel.fontColor = [SKColor redColor];
        mapLabel.fontSize = 50;
        mapLabel.position = CGPointMake(self.frame.size.width-300, self.frame.size.height/2);

        [self addChild:mapLabel];
        
        gameLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        gameLabel.text = @"New Game";
        gameLabel.fontSize = 50;
        gameLabel.fontColor = [SKColor blueColor];
        gameLabel.position = CGPointMake(300, self.frame.size.height/2);
        
        [self addChild:gameLabel];
    }
    return self;
}



-(void)startNewGame{
    SKTransition *reveal = [SKTransition
                            revealWithDirection:SKTransitionDirectionDown duration:1.0];
    MyScene *gameScene = [[MyScene alloc] initWithSize: CGSizeMake(1024,768)];
    
    [self.scene.view presentScene:gameScene transition:reveal ];
}

-(void)startMapEditor{
    SKTransition *reveal = [SKTransition
                            revealWithDirection:SKTransitionDirectionDown duration:1.0];
    MapEditor *mapScene = [[MapEditor alloc] initWithSize: CGSizeMake(1024,768)];
    
    [self.scene.view presentScene:mapScene transition:reveal ];
}

-(void)keyDown:(NSEvent *)theEvent{
    switch(theEvent.keyCode){
        case KEY_N:
            [self startNewGame];
            break;
        case KEY_M:
            [self startMapEditor];
            break;
        default:
            break;
    }
}


-(void)update:(NSTimeInterval)currentTime{

}

@end
