//
//  CardSetGame.m
//  Machizmo
//
//  Created by ophir abitbol on 8/23/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "CardSetGame.h"
#import "SetCard.h"
static const int MISMATCH_PENALTY = -2;
static const int MATCHING_SET = 5;
static const int COST_TO_CHOOSE = -1;

@interface CardSetGame()

@property (nonatomic,readwrite) NSUInteger gameScore;
@property (nonatomic) NSMutableArray * cardsCurrentlyChosenProperty;
@property (nonatomic) BOOL currentChoiceIsSetMatchProperty;
@property (nonatomic) int currentGainProperty;


@end


@implementation CardSetGame

- (instancetype) initWithCardCount: (NSUInteger) count usingDeck: (Deck *) deck
{
    
    self = [super init];
    if(self)
    {
        for (int i = 0 ; i<count; i++) {
            if([deck isDeckEmpty])
            {
                self = nil;
                break;
            }
            SetCard *card = (SetCard*)[deck drawRandomCard];
            [[self cards] addObject:card];
        }
        
        
        self.initialNumberOfCards = count;
        self.currentlyAvailableCards = count;
        
    }
    return self;
}







- (void) chooseCardAtIndex: (NSUInteger) index
{
    // get current card
    SetCard *card = (SetCard*)[self cardAtIndex:index fromCards:[self cards] ];
    if(!card.isMatched)
    {
        
        // First make sure current card isn't already chosen.
        if(card.isChosen)
        {
            card.chosen = NO; // if so, unchoose
            [self updateStatus:nil areMatched:NO pointsGained:COST_TO_CHOOSE];
            return;
        }
        else{
            
            // If card wasn't pre-chosen, get all currently chosen card:

            NSMutableArray *cardsCurrentlyChosenIncludingCurrentChoice = [self getCardsCurrentlyChosen];

            [cardsCurrentlyChosenIncludingCurrentChoice addObject:card];
            
            // if there are 3 chosen cards, we can check for sets. O.W. we take no action (except for the score update).
            if([cardsCurrentlyChosenIncludingCurrentChoice count]>2)
            {
                
                // in case cards represent a set:
                if([CardSetGame checkMatch:cardsCurrentlyChosenIncludingCurrentChoice])
                {
                    [self setCardsAsMatch: cardsCurrentlyChosenIncludingCurrentChoice];
                    [self updateScore:MATCHING_SET];
                    [self updateStatus:cardsCurrentlyChosenIncludingCurrentChoice areMatched:YES pointsGained:MATCHING_SET];

                }
                // O.W.
                else{
                   
                    [self setCardsAsNotChosen: [self getCardsCurrentlyChosen]];
                    [self updateScore:MISMATCH_PENALTY];
                    [self updateStatus:cardsCurrentlyChosenIncludingCurrentChoice areMatched:NO pointsGained:MISMATCH_PENALTY];
                    card.chosen = YES;
                }
                
            }
            
            else{ //(less than 3 cards are chosen)
                [self updateStatus:cardsCurrentlyChosenIncludingCurrentChoice areMatched:NO pointsGained:COST_TO_CHOOSE];
            }
            
            
            
        }
        [self updateScore:COST_TO_CHOOSE];
        card.chosen = YES;
    }
    
}






// This method iterates through all the cards in the deck and returns
// an array of all cards currently chosen

-(NSMutableArray * ) getCardsCurrentlyChosen
{
    NSMutableArray *cardsCurrentlyChosen  = [NSMutableArray array];
    
    for(SetCard *card in self.cards)
    {
        if(card.isChosen && !card.isMatched)
        {
            [cardsCurrentlyChosen addObject: card];
        }
    }
    return cardsCurrentlyChosen;
}





// This method iterates through all the cards in the deck and returns
// an array of all cards currently chosen

+(BOOL) checkMatch: (NSMutableArray *) cardsCurrentlyChosen

{
    
    SetCard *card1 = [cardsCurrentlyChosen objectAtIndex:0];
    SetCard *card2 = [cardsCurrentlyChosen objectAtIndex:1];
    SetCard *card3 = [cardsCurrentlyChosen objectAtIndex:2];
    
    // get sum of each property. a legal choice should leave a 0 modulus
    NSUInteger totalRank = [card1.rank intValue] + [card2.rank intValue] + [card3.rank intValue];
    
    NSUInteger totalShape = [[SetCard validShapes] indexOfObject:card1.shape]
    + [[SetCard validShapes] indexOfObject:card2.shape]
    + [[SetCard validShapes] indexOfObject:card3.shape];
    
    NSUInteger cardColor = [[SetCard validColors] indexOfObject:card1.color]
    + [[SetCard validColors] indexOfObject:card2.color]
    + [[SetCard validColors] indexOfObject:card3.color];
    
    NSUInteger cardHue = [[SetCard validHues] indexOfObject:card1.hue]
    + [[SetCard validHues] indexOfObject:card2.hue]
    + [[SetCard validHues] indexOfObject:card3.hue];
    
    if(totalRank%3==0 && totalShape%3==0 && cardColor%3==0 && cardHue%3==0)
    {
        // card match
        return YES;
    }
    else{
        // card mismatch
        return NO;
    }
    
    return NO;
    
}



// This method updates the current game staus object
-(void) updateStatus:  (NSMutableArray *) cardsCurrentlyChosen areMatched:(BOOL)match pointsGained:(int)points
{
    self.cardsCurrentlyChosenProperty = cardsCurrentlyChosen;
    self.currentChoiceIsSetMatchProperty = match;
    self.currentGainProperty = points;
    
}

-(void) updateScore: (NSInteger) pointsToAdd
{
    self.gameScore += pointsToAdd;
}

// This method updates the gameStatus object with the current status:
-(GameStatus *) gameStatus
{
    if(!_gameStatus)
    {
        _gameStatus = [[GameStatus alloc] init];
    }
    _gameStatus.cardsCurrentlyChosen = self.cardsCurrentlyChosenProperty;
    _gameStatus.match = self.currentChoiceIsSetMatchProperty;
    _gameStatus.currentGain = self.currentGainProperty;
    return _gameStatus;
}


-(NSUInteger) score
{
    return self.gameScore;
    
}




@end
