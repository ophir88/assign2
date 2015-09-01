//
//  GameStatus.h
//  Machizmo
//
//  Created by ophir abitbol on 8/31/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GameStatus : NSObject

@property (nonatomic) NSMutableArray * cardsCurrentlyChosen;
@property (nonatomic,getter=isMatch) BOOL match;
@property (nonatomic) int currentGain;


@end
