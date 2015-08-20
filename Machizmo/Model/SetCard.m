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
    return @[@"▲",@"●",@"■"];
}

+(NSArray *) validColors
{
    return @[@"red",@"green",@"purple"];
}
+(NSArray *) validHues
{
    return @[@"soft",@"medium",@"strong"];
}
+(NSArray *) validRanks
{
    return @[@"1",@"2",@"3"];
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
-(void) setColor:(NSString *)color
{
    // make sure it is a valid suit
    if([ [SetCard validColors] containsObject:color] )
    {
        _color = color;
    }
}
-(void) setHue:(NSString *)hue
{
    // make sure it is a valid suit
    if([ [SetCard validHues] containsObject:hue] )
    {
        _hue = hue;
    }
}

-(void) setRank:(NSUInteger ) rank
{
    if((rank <= [[SetCard validRanks] count ] -1) && rank >0)
    {
        _rank = rank;
    }
}




-(NSArray *) match:(Card *) card;
{
    SetCard * otherCard = (SetCard *) card;
    return @[@([self.color isEqualToString: otherCard.color]), @(self.shape==otherCard.shape), @(self.rank==otherCard.rank), @(self.hue==otherCard.hue)];
}




@end
