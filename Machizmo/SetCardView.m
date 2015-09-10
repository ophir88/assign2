//
//  SetCardView.m
//  Machizmo
//
//  Created by ophir abitbol on 9/9/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import "SetCardView.h"
#import "SetCard.h"
@interface SetCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@property (nonatomic) SetCard *card;

@end


@implementation SetCardView

#pragma mark - Properties

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.50

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
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
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
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
//    NSLog([NSString stringWithFormat:@"origin: %f, %f" , roundedRect.bounds.origin.x, roundedRect.bounds.origin.y]);
//    [roundedRect addClip];
    
    CGRect shapeRect = [self getRectForRank:self.rank withBounds:self.bounds];
//    CGRect *shapeRect = CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2, self.bounds.size.width/2, self.bounds.size.height/2);
    
    
    
    UIBezierPath *square = [UIBezierPath bezierPathWithRect:shapeRect];
    [square addClip];
    [[UIColor redColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blueColor] setStroke];
    [square stroke];
    
    
}

-(CGRect) getRectForRank:(NSNumber*)rank withBounds:(CGRect)bounds
{
 
    NSUInteger center = bounds.size.height/2;
    NSUInteger squareHeight = bounds.size.height/5;
    NSUInteger yOrigin = center - [rank intValue]*squareHeight/2;
    NSUInteger height = [rank intValue]*squareHeight;
    NSUInteger xOrigin = bounds.size.height/3;
    NSUInteger width = bounds.size.height/3;
    return CGRectMake(xOrigin, yOrigin, width, height);

    
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
