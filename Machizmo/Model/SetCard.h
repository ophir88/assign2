//
//  SetCard.h
//  Machizmo
//
//  Created by ophir abitbol on 8/20/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "Card.h"
#define COLOR 0
#define SHAPE 1
#define RANK 2
#define HUE 3
#define NUM_PROPERTIES 4
@interface SetCard : Card


// setCard properties which will define each card:
@property (strong,nonatomic) NSString *shape;
@property (strong,nonatomic) NSString *color;
@property (strong,nonatomic) NSString *hue;
@property (nonatomic) NSUInteger rank;


// possible variations of the different properties:
+(NSArray *) validShapes;
+(NSArray *) validColors;
+(NSArray *) validHues;
+(NSArray *) validRanks;

// This method checks wether two card match:
// it returns an array containing YES/NO at each index
// if the specific property matches.
-(NSArray *) match:(Card *) card;



@end
