//
//  Card.m
//  Machizmo
//
//  Created by ophir abitbol on 8/18/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "Card.h"

@interface Card()

@end


@implementation Card

-(int) match:(Card *)card
{
    if( [card.contents isEqualToString:self.contents])
    {
        return 1;
    }
    return 0;
}
@end
