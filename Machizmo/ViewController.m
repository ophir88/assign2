//
//  ViewController.m
//  Machizmo
//
//  Created by ophir abitbol on 8/17/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()


@property(nonatomic, strong) Deck * deck;


@end

@implementation ViewController


bool isBack = false;
bool isOver = false;

- (AbstractCardGame*)game:(NSUInteger)count //abstract
{
    return nil;
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
    

    assert(NO);
}


-(void) updateUI
{
    assert(NO);
}



- (IBAction)redealButton:(UIButton *)sender {
    
    assert(NO);
    
    
}



@end
