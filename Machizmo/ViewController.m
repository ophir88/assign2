//
//  ViewController.m
//  Machizmo
//
//  Created by ophir abitbol on 8/17/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
@interface ViewController ()
@property (strong, nonatomic)IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UIButton *redealButton;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishedLbl;
@property (weak, nonatomic) IBOutlet UILabel *gameScore;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameType;
@property (weak, nonatomic) IBOutlet UILabel *results;
@property (nonatomic) int flipCount;
@property(nonatomic, strong) Deck * deck;
@property(nonatomic, strong) CardMatchingGame * game;


@end

@implementation ViewController


bool isBack = false;
bool isOver = false;
- (CardMatchingGame *) game
{
    if(!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck: [self createDeck]];
    }
    return _game;
}

- (Deck*) createDeck // abstract
{
    return nil;
}

@synthesize deck = _deck;
// deck getter
-(Deck *) deck
{
    return _deck;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// action when card is flipped
- (IBAction)touchCardButton:(UIButton *)sender {
    
    // disable gameType chooser;
    self.gameType.enabled = false;
    
    int cardIndex = [self.cardButtons indexOfObject:sender];
//    NSLog(@" data %@", self.videoMetaData)
    
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}


-(void) updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle: [self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage: [self imageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.gameScore.text = [NSString stringWithFormat:@"Score: %ld",(long)self.game.score];
    }
    self.results.text =[NSString stringWithFormat:@"Results: %@",[self.game gameStatus]];
}

-(NSString *) titleForCard: (Card*) card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *) imageForCard: (Card*) card
{
    return [UIImage imageNamed:card.isChosen? @"cardFront" : @"cardBack"];
}


//This method re-deals the cards and resets the score
- (IBAction)redealButton:(UIButton *)sender {
    
    self.gameType.enabled = true;
    self.game = nil;
    [self updateUI];
    
}

//This method allows user to choose the game type (2/3 card matching)
- (IBAction)chooseGameType:(UISegmentedControl *)sender {
    
    if(sender.selectedSegmentIndex==0)
    {
        self.game.matchNumber=2;
    }
    else{
        self.game.matchNumber=3;
    }

}


@end
