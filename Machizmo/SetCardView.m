//
//  SetCardView.m
//  Machizmo
//
//  Created by ophir abitbol on 9/9/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "SetCardView.h"
#import "SetCard.h"
#import "SetBezierCreator.h"
@interface SetCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@property (nonatomic) SetCard *card;

@end


@implementation SetCardView

#pragma mark - Properties

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.50
#define DEFAULT_CELL_ASPECT_RATIO 1.25


@synthesize faceCardScaleFactor = _faceCardScaleFactor;


- (void)assignCard:(Card *)card
{
    self.card = (SetCard *)card;
    SetCard *setCard = (SetCard *)card;
    self.rank = setCard.rank;
    self.shape = setCard.shape;
    self.color = setCard.color;
    self.hue = setCard.hue;
    
    
    [self setFaceUp:setCard.chosen];
    
}


- (CGFloat)faceCardScaleFactor
{
    if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}



- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

+ (CGFloat) getCellAspectRatio
{
    return DEFAULT_CELL_ASPECT_RATIO;
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    if (self.faceUp) {
        [self drawBezier];

    } else {
        [[UIImage imageNamed:@"cardBack"] drawInRect:self.bounds];
    }
}

- (void)pushContextAndRotateUpsideDown
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

#pragma mark - Corners







-(void) drawBezier
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           cornerRadius:[self cornerRadius]];

    CGRect shapeRect = [self getRectForRank:self.rank withBounds:self.bounds];
    
    SetBezierCreator *creator = [[SetBezierCreator alloc] init];
    
    
    for (int i = 0; i<[self.rank intValue]; i++) {
        CGRect rect = shapeRect;
        rect.origin.x = shapeRect.origin.x + i * shapeRect.size.width/[self.rank intValue];
        rect.size.width = shapeRect.size.width/[self.rank intValue];

        UIBezierPath *shape = [creator bezierPathForShapeType:self.shape forRect:rect];
        [self fillShape:shape];


    }
    
//    [square addClip];
//    [[UIColor redColor] setFill];
//    UIRectFill(self.bounds);
//    
//    [[UIColor blueColor] setStroke];
//    [square stroke];
    
    
}

-(CGRect) getRectForRank:(NSNumber*)rank withBounds:(CGRect)bounds
{
 
    NSUInteger center = bounds.size.width/2;
    NSUInteger squareWitdh = bounds.size.width/4;
    NSUInteger yOrigin = bounds.size.height/4;
//    NSUInteger yOrigin = center - [rank intValue]*squareHeight/2;
    NSUInteger height = bounds.size.height/2;
    NSUInteger xOrigin = center - [rank intValue]*squareWitdh/2;
    NSUInteger width = [rank intValue]*bounds.size.width/4;
    return CGRectMake(xOrigin, yOrigin, width, height);

    
}

             
 -(void)fillShape:(UIBezierPath *)shape
{
    
    
    UIColor *color = [self UIcolorFromCardColor:self.color];

    if ([self.hue intValue]==1)
    {
        [color setFill];
        [shape fill];
        [color setStroke];
        [shape stroke];
    }
    if ([self.hue intValue]==2)
    {
        [color setStroke];
        [shape stroke];
    }
    if ([self.hue intValue]==3)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        
        CGContextAddPath(context, shape.CGPath);
        CGContextClip(context);
        
        // Perform clipped drawing here
        UIBezierPath *stripes = [UIBezierPath bezierPath];
        for ( int x = 0; x < shape.bounds.size.width; x += 2 )
        {
            [stripes moveToPoint:CGPointMake( shape.bounds.origin.x + x, shape.bounds.origin.y )];
            [stripes addLineToPoint:CGPointMake( shape.bounds.origin.x + x, shape.bounds.origin.y + shape.bounds.size.height )];
        }
        [stripes setLineWidth:1];
        [color setStroke];
        [shape stroke];
        [stripes stroke];
        // Restore the state
        CGContextRestoreGState(context);
        
        
    }
    
}

-(UIColor *) UIcolorFromCardColor:(NSNumber *)cardColor
{
    if ([cardColor intValue]==1)
    {
        return [UIColor redColor];

    }
    if ([cardColor intValue]==2)
    {
        return [UIColor greenColor];

    }
    if ([cardColor intValue]==3)
    {
        return [UIColor purpleColor];

    }
    return nil;
}


#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    self.faceUp = YES;
    return self;
}

@end
