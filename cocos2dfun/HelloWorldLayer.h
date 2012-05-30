//
//  HelloWorldLayer.h
//  cocos2dfun
//
//  Created by Ben Scheirman on 5/22/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

enum {
    ZIndexSpace = 0,
    ZIndexGround,
    ZIndexPlayer,
};

// HelloWorldLayer.h
@interface HelloWorldLayer : CCLayer
{
    CCSpriteBatchNode *spriteSheet;
    CCSprite *player;
    CCAnimation *runAnimation;
    NSMutableArray *groundSprites;
    CCAnimation *jumpAnimation;
}
    
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

- (void)startRunning;
- (void)stopRunning;

@end
