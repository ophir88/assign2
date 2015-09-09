

//  Machizmo
//
//  Created by ophir abitbol on 8/17/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "PlayingCardView.h"




static const int INITIAL_NUMBER_OF_CARDS_IN_DECK = 20;

@interface PlayingCardViewController ()


//@property (weak, nonatomic) IBOutlet UIButton *redealButton;
//@property (weak, nonatomic) IBOutlet UILabel *gameScore;




@end

@implementation PlayingCardViewController


//
//- (Deck *)deck
//{
//    return self.deck;
//}

-(UIView*) getNewView:(CGRect)frame forCard:(Card*)card
{
    
    PlayingCardView *view =[[PlayingCardView alloc] initWithFrame:frame];
    [view assignCard:card];
    return view;
    
}

-(void) updateView:(UIView *)view withFrame:(CGRect)frame forCard:(Card*)card
{
    
    PlayingCardView *pcv = (PlayingCardView *)view;
    pcv.frame = frame;
    [pcv assignCard:card];
}


- (AbstractCardGame *) createGame
{
    CardMatchingGame *game = [[CardMatchingGame alloc ] initWithCardCount:INITIAL_NUMBER_OF_CARDS_IN_DECK usingDeck: [self createDeck]];
    return game;
}




- (Deck *) createDeck
{
    PlayingCardDeck *deck =  [[PlayingCardDeck alloc]init];
    self.deck = deck;
    return deck;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
