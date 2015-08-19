//
//  CardMatchingGame.h
//  Machizmo
//
//  Created by ophir abitbol on 8/18/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
@interface CardMatchingGame : NSObject

- (instancetype) initWithCardCount: (NSUInteger) count usingDeck: (Deck *) deck;

- (void) chooseCardAtIndex: (NSUInteger) index;

- (Card *) cardAtIndex: (NSUInteger) index;

// This property holds the current score of the game.
@property (nonatomic, readonly) NSInteger score;


// This property defines wether it is a 2-card or 3-card matching game.
@property (nonatomic) NSUInteger matchNumber;

// This method returns the current status of the chosen cards & points gained/lost, as a string
-(NSString *) gameStatus;

@end
