//
//  HelloWorldLayer.m
//  cocos2dfun
//
//  Created by Ben Scheirman on 5/22/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

enum {
    RunAnimationTag = 12,
    JumpAnimationTag
};

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void)setupRunAnimation {
    runAnimation = [[CCAnimation animation] retain];
    const int NUM_FRAMES = 10;
    const int WIDTH = 42;
    const int HEIGHT = 52;
    const int Y = 285;
    const int Frames[] = {0, 42, 84, 126, 168, 210, 252, 294, 341, 383};

    int x = 0;
    for (int i=0; i < NUM_FRAMES; i++) {
        x = Frames[i];
        CCSpriteFrame *frame = 
            [CCSpriteFrame frameWithTexture:spriteSheet.texture 
                                       rect:CGRectMake(x, Y, WIDTH, HEIGHT)];
        [runAnimation addFrame:frame];
    }
    runAnimation.delay = 0.05;
}

- (void)setupBackground {
    CGSize size = [[CCDirector sharedDirector] winSize];
    CGPoint center =  ccp( size.width /2 , size.height/2 );

    CCSprite *bg = [CCSprite spriteWithFile:@"bg.png"];
    bg.position = center;
    bg.scale = 1.8;
    [self addChild:bg z:ZIndexSpace];
}

- (void)setupGround {
    CCSprite *ground = [CCSprite spriteWithFile:@"ground.png"];
    ground.scale = 0.8;
    
    int x = ground.textureRect.size.width * ground.scale / 2;
    int y = ground.textureRect.size.height * ground.scale / 2;
    ground.position = ccp(x, y);
    
    [self addChild:ground z:ZIndexGround];            
}

- (void)setupPlayer {
    spriteSheet = [CCSpriteBatchNode 
                    batchNodeWithFile:@"SuperMetroidSamus.gif"];
    player = [CCSprite spriteWithBatchNode:spriteSheet
                                      rect:CGRectMake(0, 0, 30, 56)];
    
    // the scaled up version looks ugly, 
    // we want the "8-bit" blocky look
    ccTexParams texParams = { GL_NEAREST, GL_NEAREST, 
        GL_CLAMP_TO_EDGE, GL_CLAMP_TO_EDGE };
    
    [player.texture setTexParameters:&texParams];
    
    player.position = ccp(100, 150);
    player.scale = 3.0f;
    
    [spriteSheet addChild:player];
    [self addChild:spriteSheet z:ZIndexPlayer];
}

// HelloWorldLayer.m
- (id)init {
    self = [super init];
    if (self) {
        [self setupBackground];
        [self setupGround];
        [self setupPlayer];
        
        [self setupRunAnimation];
        [self startRunning];
    }
    return self;
}

- (void)startRunning {
    id animateAction = [CCAnimate actionWithAnimation:runAnimation
                                 restoreOriginalFrame:YES];
    CCAction *repeatAnimationAction = [CCRepeatForever 
                                       actionWithAction:animateAction];
    repeatAnimationAction.tag = RunAnimationTag;
    [player runAction:repeatAnimationAction];
}

- (void)stopRunning {
    [player stopActionByTag:RunAnimationTag];    
}

- (void)dealloc {
    [runAnimation release];
    [super dealloc];
}

@end

