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
@interface ViewController : UIViewController

- (Deck*) createDeck; // abstract

@end

