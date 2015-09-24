//
//  SetBezierCreator.m
//  Machizmo
//
//  Created by ophir abitbol on 9/16/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "SetBezierCreator.h"


@interface SetBezierCreator()


@end

@implementation SetBezierCreator

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


- (UIBezierPath *)bezierPathForShapeType:(NSNumber *)shapeType forRect:(CGRect)rect
{
    
    rect.size.width -=4;
    rect.origin.x +=2;
    
    int shapeTypeInt = [shapeType intValue];
    
    if (shapeTypeInt==1){
        return [self createOval:rect];
    }
    if (shapeTypeInt==2){
        return [self createDiamond:rect];
        
    }
    if (shapeTypeInt==3){
        return [self createSquiggle:rect];
        
    }
    
    return nil;
}

- (UIBezierPath *)createOval:(CGRect)rect
{
    return [UIBezierPath bezierPathWithOvalInRect:rect];
}

- (UIBezierPath *)createDiamond:(CGRect)rect
{
    
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(rect.size.width/2 , 2 )];
    [path addLineToPoint:CGPointMake(rect.size.width - 2  , rect.size.height/2 )];
    [path addLineToPoint:CGPointMake(rect.size.width/2 , rect.size.height - 2 )];
    [path addLineToPoint:CGPointMake(2 ,  rect.size.height/2 )];
    [path closePath];
    [path applyTransform:CGAffineTransformMakeTranslation(rect.origin.x , rect.origin.y)];
    return path;
}

- (UIBezierPath *)createSquiggle:(CGRect)rect
{
    
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(104, 15)];
    [path addCurveToPoint:CGPointMake(63, 54) controlPoint1:CGPointMake(112.4, 36.9) controlPoint2:CGPointMake(89.7, 60.8)];
    [path addCurveToPoint:CGPointMake(27, 53) controlPoint1:CGPointMake(52.3, 51.3) controlPoint2:CGPointMake(42.2, 42)];
    [path addCurveToPoint:CGPointMake(5, 40) controlPoint1:CGPointMake(9.6, 65.6) controlPoint2:CGPointMake(5.4, 58.3)];
    [path addCurveToPoint:CGPointMake(36, 12) controlPoint1:CGPointMake(4.6, 22) controlPoint2:CGPointMake(19.1, 9.7)];
    [path addCurveToPoint:CGPointMake(89, 14) controlPoint1:CGPointMake(59.2, 15.2) controlPoint2:CGPointMake(61.9, 31.5)];
    [path addCurveToPoint:CGPointMake(104, 15) controlPoint1:CGPointMake(95.3, 10) controlPoint2:CGPointMake(100.9, 6.9)];
    
    [path applyTransform:CGAffineTransformMakeScale(0.9524*rect.size.width/100, 0.9524*rect.size.height/50)];
    [path applyTransform:CGAffineTransformMakeTranslation(rect.origin.x , rect.origin.y)];
    
    return path;
    
}

@end
