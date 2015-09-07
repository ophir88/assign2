//
//  CardMatchingGame.m
//  Machizmo
//
//  Created by ophir abitbol on 8/18/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "CardMatchingGame.h"
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
@interface CardMatchingGame()

@property (nonatomic,readwrite) NSInteger score;
//@property (nonatomic, strong) NSMutableArray * cards;
@property (nonatomic, strong) NSString * stats; // current game status represented as string

@end


@implementation CardMatchingGame


int numCurrentlyChosen = 0;




- (instancetype) initWithCardCount: (NSUInteger) count usingDeck: (Deck *) deck;
{
    self = [super init];
    if(self)
    {
        for (int i = 0 ; i<count; i++) {
            if([deck isDeckEmpty] || count<2)
            {
                self = nil;
                break;
            }
            Card *card = [deck drawRandomCard];
            [self.cards addObject:card];
        }
        self.matchNumber = 2;
        self.initialNumberOfCards = 5;
        self.currentlyAvailableCards = 5;

    }
    
    return self;
}

-(Card *) cardAtIndex:(NSUInteger)index
{
    if(index < [self.cards count])
    {
        return self.cards[index];
        
    }
    return nil;
    
}

-(void) chooseCardAtIndex:(NSUInteger)index
{
    
    NSString *tempStatus = @"";
    
    NSMutableArray * chosenCards  = [NSMutableArray array];
    numCurrentlyChosen = 1;
    int tempScore = 0;
    Card * card = [self cardAtIndex:index];
    if(!card.isMatched)
    {
        if(card.isChosen)
        {
            card.chosen = NO;
        }
        else{
            // match card;
            for(Card* otherCard in self.cards)
            {
                if(otherCard.isChosen && !otherCard.isMatched)
                {
                    numCurrentlyChosen++;
                    [chosenCards addObject: otherCard];
                    tempScore += [card match:otherCard];
                    
                }
            }
            if(numCurrentlyChosen>2)
            {
                tempScore += [chosenCards[0] match:chosenCards[1]];
                
            }
            [chosenCards addObject: card];
            
            
            if(numCurrentlyChosen==self.matchNumber)
            {
                
                if(tempScore>0) // at least one of the cards matches it
                {
                    self.score+=tempScore*(self.matchNumber-1)*MATCH_BONUS; // add totalScore:
                    
                    for(Card * chosenCard in chosenCards)
                    {
                        tempStatus = [NSString stringWithFormat:@"%@ %@", tempStatus,chosenCard.contents];
                        
                        chosenCard.matched = YES;
                    }
                    tempStatus = [NSString stringWithFormat:@"%@ %@ %lu %@", tempStatus,@"matches! you gain",(tempScore*(self.matchNumber-1)*MATCH_BONUS), @"points!" ];
                    
                    
                }
                else{ // no matches
                    for(Card * chosenCard in chosenCards)
                    {
                        tempStatus = [NSString stringWithFormat:@"%@ %@", tempStatus,chosenCard.contents];
                        
                        chosenCard.chosen = NO;
                    }
                    tempStatus = [NSString stringWithFormat:@"%@ %@ %d %@", tempStatus,@"doesn't match! you loose",MISMATCH_PENALTY, @"points!" ];
                    
                    self.score -= MISMATCH_PENALTY;
                }
            }
            else
            {
                for(Card * chosenCard in chosenCards)
                {
                    tempStatus = [NSString stringWithFormat:@"%@ %@", tempStatus,chosenCard.contents];
                    
                }
            }
            
        }
        self.score -= COST_TO_CHOOSE;
        card.chosen = YES;
        
    }
    self.stats = tempStatus;
   
}


//returns the current game status represented as string
-(NSString *) gameStatus
{
    return self.stats ? self.stats : @"";
}

- (NSString*) addString:(NSString*)stringA withString:(NSString*)stringB
{
    NSString *finalString = [NSString stringWithFormat:@"%@ %@", stringA,
                             stringB];
    return finalString;
}

@end
