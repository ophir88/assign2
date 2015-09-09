//
//  PlayingCardDeck.m
//  Machizmo
//
//  Created by ophir abitbol on 8/18/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"
@implementation PlayingCardDeck


-(instancetype) init
{
    
    self = [super init];
    
    if (self)
    {
     
        for (NSString * suit in [PlayingCard validSuits]) {
            for( NSUInteger rank = 1 ; rank <= [[PlayingCard rankString]count]-1 ; rank ++)
            {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                card.matched = NO;

                [self addCard:card];
            }
        }
        
    }
    
    return self;
}



@end
