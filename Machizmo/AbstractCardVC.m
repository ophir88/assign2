//
//  AbstractCardVC.m
//  Machizmo
//
//  Created by ophir abitbol on 9/6/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "AbstractCardVC.h"

@interface AbstractCardVC ()

@property (nonatomic) NSInteger score;
@property (nonatomic,strong) AbstractCardGame *game;
@property (nonatomic,strong) NSMutableArray *cards;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) IBOutlet NSMutableArray *cardViews;
@property (nonatomic,strong) NSMutableArray *cardAndViewHolder;
@property (strong, nonatomic)  Grid *grid;
@property (weak, nonatomic) IBOutlet UIView *cardHolderView;


@end

@implementation AbstractCardVC



#pragma Abstract methods
- (Deck *)deck
{
    assert(NO);
}

-(UIView*) getNewView:(CGRect)frame
{
    assert(NO);
}

- (AbstractCardGame *) game
{
    assert(NO);
}




#pragma class methods

- (Grid *)grid
{
    if(!_grid)
    {
        _grid = [[Grid alloc]init];
        _grid.minimumNumberOfCells = _game.initialNumberOfCards;
        _grid.size = [_cardHolderView bounds].size;
        
        //TODO - set const aspect value
        _grid.cellAspectRatio = 1.5;
    }
    return _grid;
}



-(NSMutableArray*) cardViews
{
    NSUInteger cardRunningIndex = 0;
    if(!_cardViews)
    {
        self.cardAndViewHolder = [[NSMutableArray alloc]init];
        for (int row = 0; row<self.grid.rowCount; row++) {
            for (int col = 0; col<self.grid.columnCount; col++)
            {
                
                if(cardRunningIndex<self.game.initialNumberOfCards)
                {
                    UIView *view = [self getNewView:[self.grid frameOfCellAtRow:row inColumn:col]];
                    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchCardButton:)]];
                    [self.cardViews addObject:view];
                    CardViewParams *cvp = [[CardViewParams alloc] init ];
                    cvp.view = view;
                    cvp.card = [self.cards objectAtIndex:cardRunningIndex];
                    [self.cardAndViewHolder addObject:cvp];
                    cardRunningIndex++;
                }

                
            }
        }
        
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
            [self.cards addObject:card];
        }
    }
    return _cardViews;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)touchCardButton:(UIView *)sender {
    
    NSInteger cardIndex = [self.cardViews indexOfObject:sender];
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
    self.cardAndViewHolder = [[NSMutableArray alloc]init];
    for (int row = 0; row<self.grid.rowCount; row++) {
        for (int col = 0; col<self.grid.columnCount; col++)
        {
            //get next visible view
            Card *card;

            for (NSUInteger viewIndex = runningViewIndex; viewIndex<[self.cardViews count]; viewIndex++) {
                
                view = nil;
                if(!(card = [self.cards objectAtIndex:viewIndex]).isMatched)
                {
                    view = [self.cardViews objectAtIndex:viewIndex];
                    runningViewIndex = (++viewIndex);
                    
                    break;
                }
                
            }
            if(view)
            {
                view.frame = [self.grid frameOfCellAtRow:row inColumn:col];
                CardViewParams *cvp = [[CardViewParams alloc] init];
                cvp.view = view;
                cvp.card = card;
                [self.cardAndViewHolder addObject:cvp];
            }
            
        }
    }
}




@end
