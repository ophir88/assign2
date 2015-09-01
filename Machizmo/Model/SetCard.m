//
//  SetCard.m
//  Machizmo
//
//  Created by ophir abitbol on 8/20/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


// valid properties of the cards:
// -----------------------------
+(NSArray *) validShapes
{
//    return @[@1,@2,@3];
    return @[@"▲",@"●",@"■"];
    
}

+(NSArray *) validColors
{
    return @[@1,@2,@3];
}
+(NSArray *) validHues
{
    return @[@1,@2,@3];
}
+(NSArray *) validRanks
{
    return @[@1,@2,@3];
}


// Setters for the cards:
// ----------------------
-(void) setShape:(NSString *)shape
{
    // make sure it is a valid suit
    if([ [SetCard validShapes] containsObject:shape] )
    {
        _shape = shape;
    }
}
-(void) setColor:(NSNumber *)color
{
    // make sure it is a valid suit
    if([ [SetCard validColors] containsObject:color] )
    {
        _color = color;
    }
}
-(void) setHue:(NSNumber *)hue
{
    // make sure it is a valid suit
    if([ [SetCard validHues] containsObject:hue] )
    {
        _hue = hue;
    }
}

-(void) setRank:(NSNumber *) rank
{
    if(([rank intValue] <= [[SetCard validRanks] count ]) && rank >0)
    {
        _rank = rank;
    }
}




-(NSArray *) match:(Card *) card;
{
    SetCard * otherCard = (SetCard *) card;
    
    return @[@([self.color isEqualToNumber:otherCard.color]), @([self.hue isEqualToNumber:otherCard.hue]), @([self.shape isEqualToString:otherCard.shape]), @([self.rank isEqualToNumber:otherCard.rank])];
}




@end
