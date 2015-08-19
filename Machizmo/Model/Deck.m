//
//  Deck.m
//  Machizmo
//
//  Created by ophir abitbol on 8/18/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "Deck.h"

@interface Deck()
//array containing cards of deck
@property (strong,nonatomic) NSMutableArray *cards;
@end



@implementation Deck

-(NSMutableArray *) cards
{
    if(!_cards)
    {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(void) addCard:(Card *)card atTop:(BOOL)atTop
{
    if(atTop)
    {
        [self.cards insertObject:card atIndex:0];
    }
    else
    {
        [self.cards addObject:card];
    }
}

-(void) addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

-(Card *) drawRandomCard
{
 
    
    NSUInteger count; // num of cards currently in deck
    
    Card * randomCard = nil; // card to return
    
    
    if((count=[self.cards count])>0) // make sure there are cards in deck
    {
        NSUInteger idx = arc4random() % count;  // get random index of card from deck

        randomCard = self.cards[idx]; // get card form deck at index location
        
        [self.cards removeObjectAtIndex:idx];  //remove card from deck
    
    }

    return randomCard;
}

-(BOOL)isDeckEmpty
{
    if ([self.cards count] == 0) {
        return  YES;
    }
    return NO;
}


@end
