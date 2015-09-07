//
//  AbstractCardGame.m
//  Machizmo
//
//  Created by ophir abitbol on 8/30/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "AbstractCardGame.h"

@implementation AbstractCardGame



- (instancetype) initWithCardCount: (NSUInteger) count usingDeck: (Deck *) deck
{
    return nil;
}

- (void) chooseCardAtIndex: (NSUInteger) index
{
    
}


-(NSString *) gameStatus
{
    return nil;

}


-(NSUInteger) score
{
    return 0;

}


-(NSMutableArray*) cards
{
    if(!_cards)
    {
        _cards = [[NSMutableArray alloc] init];
        
    }
    return _cards;
}



-(void) setCardsAsMatch: (NSMutableArray *) cardsCurrentlyChosen

{
    for (Card * card in cardsCurrentlyChosen) {
        card.matched = YES;
    }
    
}

-(void) setCardsAsNotChosen: (NSMutableArray *) cardsCurrentlyChosen

{
    for (Card * card in cardsCurrentlyChosen) {
        card.chosen = NO;
    }
    
}

-(Card *) cardAtIndex:(NSUInteger)index fromCards: (NSMutableArray *) cards
{
    if(index < [cards count])
    {
        return cards[index];
        
    }
    return nil;
    
}

@end
