//
//  setDeck.m
//  Machizmo
//
//  Created by ophir abitbol on 8/23/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "setDeck.h"
#import "SetCard.h"
@implementation SetDeck


-(instancetype) init
{
    
    self = [super init];
    
    if (self)
    {
        
        for (NSString* shape in [SetCard validShapes]) {
            for (NSNumber* color in [SetCard validColors]) {
                for (NSNumber* hue in [SetCard validHues]) {
                    for( int rank = 1 ; rank <= [[SetCard validRanks]count] ; rank ++)
                    {
                        SetCard * card = [[SetCard alloc]init];
                        card.shape = shape;
                        card.color = color;
                        card.hue = hue;
                        card.rank = [NSNumber numberWithInt:rank];
                        [self addCard:card];
                        
                    }
                    
                }
                
            }
            
        }
    }
    
    return self;
}




@end
