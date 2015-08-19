//
//  PlayingCard.m
//  Machizmo
//
//  Created by ophir abitbol on 8/18/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int) match:(Card *) card;
{
    PlayingCard * otherCard = card;
    if(self.rank == otherCard.rank)
    {
        return 4;
    }
    else if([self.suit isEqualToString:otherCard.suit])
    {
        return 1;
    }
    return 0;
}


+(NSArray *) rankString
{
    return @[@"¿?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSArray *) validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}




@synthesize suit = _suit;

//suit setter
-(void) setSuit:(NSString *)suit
{
    
    // make sure it is a valid suit
    if([ [PlayingCard validSuits] containsObject:suit] )
    {
       _suit = suit;
    }
}

//suit getter
-(NSString *)suit
{
    return _suit? _suit:@"¿?";
}

// this method returns a string represeantation of the card
-(NSString *) contents
{
    return [[[PlayingCard rankString]objectAtIndex:self.rank] stringByAppendingString:self.suit];
}

// rank setter

-(void) setRank:(NSUInteger) rank
{
    if((rank <= [[PlayingCard rankString] count ] -1) && rank >0)
    {
        _rank = rank;
    }
}

@end
