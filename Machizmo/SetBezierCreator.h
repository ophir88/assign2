//
//  SetBezierCreator.h
//  Machizmo
//
//  Created by ophir abitbol on 9/16/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetBezierCreator : UIView




- (UIBezierPath *)bezierPathForShapeType:(NSNumber *)shape forRect:(CGRect)rect;

@end
