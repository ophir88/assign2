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
//    NSLog(@"bound size: %f X %f", [self.view bounds].size.he , [self.view bounds].size.width );

    _grid.size = self.cardHolderView.frame.size;
    
    //TODO - set const aspect value
}

- (NSMutableArray*) createCardViews
{
    NSUInteger cardRunningIndex = 0;
    NSMutableArray *cardViews = [[NSMutableArray alloc] init];
    self.cardAndViewHolder = [[NSMutableArray alloc]init];
    for (int row = 0; row<self.grid.rowCount; row++) {
        for (int col = 0; col<self.grid.columnCount; col++)
        {
            
            if(cardRunningIndex<self.game.initialNumberOfCards)
            {
                UIView *view = [self getNewView:[self.grid frameOfCellAtRow:row inColumn:col] forCard:[self.game.cards objectAtIndex:cardRunningIndex]];
                [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCardButton:)]];
                [cardViews addObject:view];
                CardViewParams *cvp = [[CardViewParams alloc] init ];
                cvp.view = view;
                cvp.card = [self.game.cards objectAtIndex:cardRunningIndex];
                [self.cardAndViewHolder addObject:cvp];
                cardRunningIndex++;
            }
            
            
        }
    }
    return cardViews;
}

-(NSMutableArray*) cardViews
{
    if(!_cardViews)
    {
        _cardViews = [self createCardViews];
    }
    return _cardViews;
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
    // Dispose of any resources that can be recreated.
}



- (void)touchCardButton:(UIGestureRecognizer *)sender {

//    NSInteger a = [self.cardAndViewHolder indexOfObject:sender.view];
    NSInteger cardIndex = [self.cardViews indexOfObject:sender.view];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    
}





- (IBAction)redealButton:(UIButton *)sender {
    
    _game = nil;
    [self updateUI];
    
}


-(void) updateUI
{
    
    self.grid.minimumNumberOfCells = self.game.currentlyAvailableCards;
    NSUInteger runningViewIndex = 0;
    UIView *view;
    self.cardViews = [[NSMutableArray alloc] init];
    self.cardAndViewHolder = [[NSMutableArray alloc]init];
    for (int row = 0; row<self.grid.rowCount; row++) {
        for (int col = 0; col<self.grid.columnCount; col++)
        {
            //get next visible view
            Card *card;

            for (NSUInteger viewIndex = runningViewIndex; viewIndex<self.game.currentlyAvailableCards; viewIndex++) {
                
                view = nil;
                if(!(card = [self.game.cards objectAtIndex:viewIndex]).isMatched)
                {
                    view = [self.cardViews objectAtIndex:viewIndex];
                    runningViewIndex = (++viewIndex);
                    break;
                }
                
            }
            if(card)
            {
                view = [self getNewView:[self.grid frameOfCellAtRow:row inColumn:col] forCard:card];
                [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCardButton:)]];
                [self.cardViews addObject:view];
//                view.frame = [self.grid frameOfCellAtRow:row inColumn:col];
                    NSLog(@"added card %@", view );

                [self.cardHolderView addSubview:view];
                CardViewParams *cvp = [[CardViewParams alloc] init];
                cvp.view = view;
                cvp.card = card;
                [self.cardAndViewHolder addObject:cvp];
            }
            else{
                view.hidden = YES;
            }
            
        }
    }
}




@end
