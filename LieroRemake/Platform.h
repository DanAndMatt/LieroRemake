//
//  Platform.h
//  macSpriteGame
//
//  Created by Daniel Vaknine on 2014-06-27.
//  Copyright (c) 2014 Daniel Vaknine. All rights reserved.
//

@class Platform;
@interface Platform : NSObject{
    SKSpriteNode *sprite;
}
@property (nonatomic, retain)SKSpriteNode *sprite;

-(void)createPlatform:(float)x :(float)y :(NSString*)name;
@end
