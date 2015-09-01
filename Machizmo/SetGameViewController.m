//
//  SetGameViewController.m
//  Machizmo
//
//  Created by ophir abitbol on 8/31/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetDeck.h"
#import "SetCard.h"
#import "CardSetGame.h"
#import "GameHistoryViewController.h"

@interface SetGameViewController ()
@property(nonatomic, strong) CardSetGame * game;
@property (strong, nonatomic)IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic)NSMutableArray *colors;

@property (weak, nonatomic) IBOutlet UIButton *redealButton;
@property (weak, nonatomic) IBOutlet UILabel *finishedLbl;
@property (weak, nonatomic) IBOutlet UILabel *gameScore;
@property (weak, nonatomic) IBOutlet UILabel *results;
@property (nonatomic) int flipCount;
@property (nonatomic) NSUInteger cardCount;

@end


@implementation SetGameViewController



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showHistory"])
    {
      if([segue.destinationViewController isKindOfClass:[GameHistoryViewController class]])
      {
          GameHistoryViewController *historyVC = (GameHistoryViewController *) segue.destinationViewController;
          historyVC.history = self.game.historyArray;
      }
    }
}

- (AbstractCardGame*)game:(NSUInteger)count
{
    if(!_game)
    {
        _game = [[CardSetGame alloc] initWithCardCount:count usingDeck:[self createDeck]];
    }
    self.cardCount = count;

    return _game;
}


- (AbstractCardGame*)game

{
    if(!_game)
    {
        _game = [[CardSetGame alloc] initWithCardCount:self.cardCount usingDeck:[self createDeck]];
    }
    return _game;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}
- (Deck *) createDeck
{
    return [[SetDeck alloc] init ];
}

// action when redealButton is pressed:
- (IBAction)redealButton:(UIButton *)sender {
    
    _game = nil;
    [self updateUI];
    
    
}


// action when card is flipped
- (IBAction)touchCardButton:(UIButton *)sender {
    

    
    NSInteger cardIndex = [self.cardButtons indexOfObject:sender];
    //    NSLog(@" data %@", self.videoMetaData)
    
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}


-(void) updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        NSInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        
        SetCard *card = (SetCard *)[self.game cardAtIndex:cardIndex fromCards:[self.game cards]];
        // update button text and background
        [cardButton setAttributedTitle:[self createShapeAttributeString:card] forState:UIControlStateNormal ];
        [cardButton setBackgroundImage: [self imageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.gameScore.text = [NSString stringWithFormat:@"Score: %ld",(long)[self.game score]];
    
    NSAttributedString *result = [self createResultFromGameStatus];
    self.results.attributedText = result;
    [self.game.historyArray addObject:result];
}


-(UIImage *) imageForCard: (Card*) card
{
    
    return [UIImage imageNamed:card.isChosen? @"cardFront" : @"cardBackSet"];
}





// This method creates an attributed string representing the current status of the game
-(NSAttributedString*) createResultFromGameStatus
{

    GameStatus *gameStatus = [self.game gameStatus];

    NSMutableAttributedString *resultString = [self createCardsAttributeString:gameStatus.cardsCurrentlyChosen];
    
 
    if (gameStatus.isMatch) // matching set
    {
        
        NSString *result = [NSString stringWithFormat:@" is a match for %d points!",gameStatus.currentGain];
        [resultString appendAttributedString:[[NSAttributedString alloc] initWithString:result]];

        
    }
    else
    {
        if([gameStatus.cardsCurrentlyChosen count]==3) // 3 cards, no set
        {
            
            NSString *result = [NSString stringWithFormat:@" is not a match. you loose %d points.",gameStatus.currentGain];
            [resultString appendAttributedString:[[NSAttributedString alloc] initWithString:result]];

            
        }
        else // less than 3 cards chosen
        {
                // do nothing
        }
    
    }
    
    return resultString;
    
}



-(NSMutableAttributedString*) createCardsAttributeString:(NSArray*) cards
{
   
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc]init];
    [resultString appendAttributedString:[[NSAttributedString alloc] initWithString:@"Result:   "]];

    for (SetCard* card in cards){
        
        NSAttributedString *cardStringToAdd = [self createShapeAttributeString:card];
        [resultString appendAttributedString:cardStringToAdd];
        
        
    }
    return resultString;
}


-(NSAttributedString*) createShapeAttributeString:(SetCard *)fromCard
{
    
    SetCard *card = fromCard;
    NSString *cardString = @"";
        for (int i = 0; i<[card.rank intValue]; i++) {
            cardString  = [NSString stringWithFormat:@"%@%@ ",cardString,card.shape];
            
        }

     NSDictionary *attributes =
                                @{NSFontAttributeName : [UIFont fontWithName:@"Palatino-Roman" size:14.0],
                                NSForegroundColorAttributeName:[self UIColorCreator:card.color withHue:card.hue],
                                NSStrokeWidthAttributeName: @-4,
                                NSStrokeColorAttributeName : [self UIColorCreator:card.color]
                                };
    return [[NSAttributedString alloc] initWithString:cardString attributes:attributes];
}



-(UIColor *) UIColorCreator:(NSNumber*)color withHue:(NSNumber*)hue
{
    if([color intValue] == 1)
    {
        return [UIColor colorWithRed:1 green:0 blue:0 alpha:[self hueToFloat:hue]];
        
    }
    else if ([color intValue] == 2)
    {
        return [UIColor colorWithRed:0 green:1 blue:0 alpha:[self hueToFloat:hue]];
    }
    else
    {
        return [UIColor colorWithRed:0.5 green:0 blue:0.5 alpha:[self hueToFloat:hue]];
    }

}

-(UIColor *) UIColorCreator:(NSNumber*)color
{
    
    return [self UIColorCreator:color withHue:@3];
}

-(CGFloat) hueToFloat:(NSNumber*)hue
{
    
    if([hue intValue]==1)
    {
        return 0;
    }
    else if ([hue intValue]==2)
    {
        return 0.25;
    }
    else
    {
        return 1;
    }
}

@end
