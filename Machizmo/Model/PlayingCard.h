//
//  PlayingCard.h
//  Machizmo
//
//  Created by ophir abitbol on 8/18/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface PlayingCard : Card

//suit of card:
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
+(NSArray *) validSuits;
+(NSArray *) rankString;
@end
