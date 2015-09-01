//
//  GameHistoryViewController.m
//  Machizmo
//
//  Created by ophir abitbol on 9/1/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "GameHistoryViewController.h"

@interface GameHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextBox;

@end

@implementation GameHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) setHistoryToDisplay:(NSMutableArray *) historyArray
{
    _history = historyArray;
    if (self.view.window)
    {
        [self updateUI];
    }
    
}

-(void) updateUI
{
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc]init];
    for (NSAttributedString *historyLine in self.history){
        [resultString appendAttributedString:historyLine];
        [resultString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\r"]];

    }
    self.historyTextBox.attributedText = resultString;
//    self.historyTextBox.editable = NO;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}
@end
