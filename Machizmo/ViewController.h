//
//  ViewController.h
//  Machizmo
//
//  Created by ophir abitbol on 8/17/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
// ______________
// abstract class
// --------------
//


#import <UIKit/UIKit.h>
#import "Deck.h"
#import "AbstractCardGame.h"

@interface ViewController : UIViewController




// Initialize a game.
- (AbstractCardGame*)game:(NSUInteger)count; // abstract

// create a deck of cards.
- (Deck*) createDeck; // abstract

// Action when a card is pressed
- (IBAction)touchCardButton:(UIButton *)sender;

// This method updates the UI
-(void) updateUI;

// redeal a deck
- (IBAction)redealButton:(UIButton *)sender;
@end

