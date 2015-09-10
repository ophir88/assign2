//
//  AbstractCardVC.m
//  Machizmo
//
//  Created by ophir abitbol on 9/6/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "AbstractCardVC.h"

@interface AbstractCardVC ()


@property (weak, nonatomic) IBOutlet UIView *cardHolderView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic) BOOL firstLoad;

@end

@implementation AbstractCardVC



#pragma Abstract methods
- (Deck *)deck
{
    if(!_deck)
    {
        _deck = [self createDeck];
    }
    return _deck;
}

- (Deck *)createDeck
{
    assert(NO);
}

-(UIView*) getNewView:(CGRect)frame forCard:(Card*)card
{
    assert(NO);
}

-(void) updateView:(UIView *)view withFrame:(CGRect)frame forCard:(Card*)card
{
    assert(NO);
}

- (AbstractCardGame *) game
{
    if (!_game)
    {
        _game = [self createGame];
    }
    return _game;
}

- (AbstractCardGame *) createGame
{
    assert(NO);
}




#pragma class methods


-(NSString *)getScoreText
{
    return [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}


- (Grid *)grid
{
    if(!_grid)
    {
        [self createGrid];
    }
    return _grid;
}

- (void) createGrid
{
    _grid = [[Grid alloc]init];
    _grid.minimumNumberOfCells = _game.initialNumberOfCards;
    _grid.cellAspectRatio = 0.75;
    _grid.size = self.cardHolderView.frame.size;
}

- (void) createCardViews
{
    NSUInteger cardRunningIndex = 0;
    self.cardAndViewHolder = [[NSMutableArray alloc]init];
    for (int row = 0; row<self.grid.rowCount; row++) {
        for (int col = 0; col<self.grid.columnCount; col++)
        {
            
            if(cardRunningIndex<self.game.initialNumberOfCards)
            {
                UIView *view = [self getNewView:[self.grid frameOfCellAtRow:row inColumn:col] forCard:[self.game.cards objectAtIndex:cardRunningIndex]];
                [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCardButton:)]];
                CardViewParams *cvp = [[CardViewParams alloc] init ];
                cvp.view = view;
                cvp.card = [self.game.cards objectAtIndex:cardRunningIndex];
                [self.cardAndViewHolder addObject:cvp];
                [self.cardHolderView addSubview:cvp.view];
                cardRunningIndex++;
            }
        }
    }
}






-(NSMutableArray*) cards
{
    Card *card;
    if(!_cards)
    {
        for (int index = 0; self.game.initialNumberOfCards; index++) {
            card = self.deck.drawRandomCard;
            [_cards addObject:card];
        }
    }
    return _cards;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstLoad = YES;
    
}


-(void)viewDidAppear:(BOOL)animated
{
    if(self.firstLoad)
    {
        _game = [self createGame];
        [self createGrid];
        [self createCardViews];
        [self updateUI];
        self.firstLoad = NO;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void)touchCardButton:(UIGestureRecognizer *)sender {
    
    NSInteger cardIndex = [self getCardIndex:sender.view];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    
}





- (IBAction)redealButton:(UIButton *)sender {
    _game = nil;
    [self updateUI];
    
}


-(void) updateUI
{
//    int prevRowCount = (int)
//    int prevColCount = (int)

    self.grid.minimumNumberOfCells = self.game.currentlyAvailableCards;
    int runningViewIndex = 0;
    int numberOfViewsAdded = 0;
    CardViewParams *cvp;
    for (int row = 0; row<self.grid.rowCount; row++) {
        for (int col = 0; col<self.grid.columnCount; col++)
        {
            if (numberOfViewsAdded<self.game.currentlyAvailableCards) {
                //get next visible view
                Card *card;
                for (int viewIndex = runningViewIndex; viewIndex<[self.game.cards count]; viewIndex++) {
                    if(!(card = [self.game.cards objectAtIndex:viewIndex]).isMatched)
                    {
                        cvp = [self.cardAndViewHolder objectAtIndex:numberOfViewsAdded];
                        cvp.card = card;
                        [self updateView:cvp.view withFrame:[self.grid frameOfCellAtRow:row inColumn:col] forCard:card];
                        cvp.view.hidden = NO;
                        runningViewIndex = (++viewIndex);
                        numberOfViewsAdded++;
                        break;
                    }
                }
                
            }
        }
    }
    for (int viewIndex = numberOfViewsAdded; viewIndex<self.game.initialNumberOfCards; viewIndex++) {
        cvp =[self.cardAndViewHolder objectAtIndex:numberOfViewsAdded];
        cvp.view.hidden = YES;
        numberOfViewsAdded++;
    }
    self.scoreLabel.text = [self getScoreText];
    
}


-(NSUInteger) getCardIndex:(UIView *)view
{
    CardViewParams *cvp;
    for (int index = 0; index<self.game.currentlyAvailableCards; index++) {
        cvp =[self.cardAndViewHolder objectAtIndex:index];
        if(cvp.view == view)
        {
            return [self.game.cards indexOfObject:cvp.card];
        }
    }
    return nil;
}

@end
