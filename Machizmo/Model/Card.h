//
//  Card.h
//  Machizmo
//
//  Created by ophir abitbol on 8/18/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

//contains the contents of card:
@property (strong,nonatomic) NSString *contents;


@property (nonatomic,getter=isChosen) BOOL chosen;
@property (nonatomic,getter=isMatched) BOOL matched;
@property (nonatomic,getter=isNewlyChosen) BOOL newlyChosen;


-(int) match: (Card *) card;
@end
