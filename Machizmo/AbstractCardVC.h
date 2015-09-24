//
//  AbstractCardVC.h
//  Machizmo
//
//  Created by ophir abitbol on 9/6/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractCardGame.h"
#import "Grid.h"
#import "CardViewParams.h"
@interface AbstractCardVC : UIViewController

@property (nonatomic) NSInteger score;
@property (nonatomic,strong) AbstractCardGame *game;
@property (nonatomic,strong) NSMutableArray *cards;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) IBOutlet NSMutableArray *cardViews;
@property (nonatomic,strong) NSMutableArray *cardAndViewHolder;
@property (strong, nonatomic)  Grid *grid;

-(UIView*) getNewView:(CGRect)frame forCard:(Card*)card; //Abstract
-(void) updateView:(UIView *)view withFrame:(CGRect)frame forCard:(Card*)card;
-(Deck *)deck; //Abstract
-(void) updateUI;

@end
