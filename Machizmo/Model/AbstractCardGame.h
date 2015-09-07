//
//  AbstractCardGame.h
//  Machizmo
//
//  Created by ophir abitbol on 8/30/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface AbstractCardGame : NSObject





// init:
- (instancetype) initWithCardCount: (NSUInteger) count usingDeck: (Deck *) deck;

// This method is performed every time a card is chosen.
// The method checks which cards are chosen, and calculates a score
- (void) chooseCardAtIndex: (NSUInteger) index;


// This method returns the current status of the chosen cards & points gained/lost, as a string
-(NSString *) getGameStatus;


// This method returns the current score of the game
-(NSUInteger) score;

// This method recieves cards and returns a string representation of them
-(NSString * ) createStringFromCards: (NSMutableArray *) cards;




// This array contains a history of the results
@property (nonatomic) NSUInteger initialNumberOfCards;
// This array contains a history of the results
@property (nonatomic) NSUInteger currentlyAvailableCards;
@property (nonatomic) NSMutableArray *cards;


//  -------------
// |  PROTECTED  |
//  -------------


// This Method returns the card at the given index
- (Card *) cardAtIndex: (NSUInteger) index fromCards: (NSMutableArray *) cards;

// This method changes the received card's status to "match"
-(void) setCardsAsMatch: (NSMutableArray *) cardsCurrentlyChosen;

// This method changes the received card's status to "not chosen"
-(void) setCardsAsNotChosen: (NSMutableArray *) cardsCurrentlyChosen;

@end
