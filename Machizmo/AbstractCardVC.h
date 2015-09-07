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


-(UIView*) getNewView:(CGRect)frame; //Abstract

-(Deck *)deck; //Abstract

@end
