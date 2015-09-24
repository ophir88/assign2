//
//  SetCardView.h
//  Machizmo
//
//  Created by ophir abitbol on 9/9/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
@interface SetCardView : UIView


@property (strong,nonatomic) NSNumber *shape;
@property (strong,nonatomic) NSNumber *color;
@property (strong,nonatomic) NSNumber *hue;
@property (nonatomic) NSNumber *rank;
@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;
- (void)assignCard:(Card *)card;
+ (CGFloat) getCellAspectRatio;


@end
