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




- (AbstractCardGame*)game:(NSUInteger)count; // abstract

- (Deck*) createDeck; // abstract


- (IBAction)touchCardButton:(UIButton *)sender;

-(void) updateUI;

-(NSString *) titleForCard: (Card*) card;

-(UIImage *) imageForCard: (Card*) card;

- (IBAction)redealButton:(UIButton *)sender;
@end

