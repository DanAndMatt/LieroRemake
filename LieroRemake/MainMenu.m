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
#define KEY_LEFT 123
#define KEY_RIGHT 124
#define KEY_ENTER 36
@synthesize mapLabel,gameLabel,cursorSprite,pressedEnterKey,cursor;


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
        
        cursorSprite = [SKSpriteNode spriteNodeWithImageNamed:@"cursor2"];
        cursorSprite.position = CGPointMake(300, self.frame.size.height/2);
        
        [self addChild:cursorSprite];
        
        pressedEnterKey = false;
        cursor = KEY_LEFT;
    }
    return self;
}



-(void)startNewGame{
    if (pressedEnterKey) {
        SKTransition *reveal = [SKTransition
                                revealWithDirection:SKTransitionDirectionDown duration:1.0];
        MyScene *gameScene = [[MyScene alloc] initWithSize: CGSizeMake(1024,768)];
        
        [self.scene.view presentScene:gameScene transition:reveal ];
    }

}

-(void)startMapEditor{
    if (pressedEnterKey) {
        SKTransition *reveal = [SKTransition
                            revealWithDirection:SKTransitionDirectionDown duration:1.0];
        MapEditor *mapScene = [[MapEditor alloc] initWithSize: CGSizeMake(1024,768)];
    
        [self.scene.view presentScene:mapScene transition:reveal ];
    }
}

-(void)keyDown:(NSEvent *)theEvent{
    NSLog(@"%i",theEvent.keyCode);
    switch(theEvent.keyCode){
        case KEY_LEFT:
            cursor = KEY_LEFT;
            cursorSprite.position = CGPointMake(300, self.frame.size.height/2);
            break;
        case KEY_RIGHT:
            cursor = KEY_RIGHT;
            cursorSprite.position = CGPointMake(self.frame.size.width-300, self.frame.size.height/2);
            break;
        case KEY_ENTER:
            pressedEnterKey = true;
            if(cursor == KEY_LEFT){
                [self startNewGame];
            }
            else
                [self startMapEditor];
            break;
        default:

            break;
    }
}


-(void)update:(NSTimeInterval)currentTime{

}

@end
