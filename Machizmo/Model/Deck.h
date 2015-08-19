//
//  Deck.h
//  Machizmo
//
//  Created by ophir abitbol on 8/18/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject


-(void) addCard:(Card *)card atTop:(BOOL)atTop;
-(void) addCard:(Card *)card;

-(Card*) drawRandomCard;
-(BOOL)isDeckEmpty;

@end
