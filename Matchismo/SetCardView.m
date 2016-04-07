// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardView

- (void)setColor:(UIColor *)color{
  _color = color;
  [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank{
  _rank = rank;
  [self setNeedsDisplay];
}

- (void)setShade:(NSString *)shade{
  _shade = shade;
  [self setNeedsDisplay];
}

- (void)setShape:(NSString *)shape{
  _shape = shape;
  [self setNeedsDisplay];
}

- (void)setChosen:(BOOL)chosen{
  _chosen = chosen;
  [self setNeedsDisplay];
}

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect{
  // Drawing code
  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
  
  [roundedRect addClip];
  
  [[UIColor whiteColor] setFill];
  UIRectFill(self.bounds);
  
  if(self.chosen){
    [[UIColor purpleColor] setStroke];
    roundedRect.lineWidth *=2.5;
  }else{
    [[UIColor blackColor] setStroke];
    roundedRect.lineWidth /=2;
  }
  
  [roundedRect stroke];
  
  [self drawShapes];

}

//Shape size definitions are by relativity to the size of the view

#define SHAPE_OFFSET 0.275;
#define SHAPE_LINE_WIDTH 0.015;
#define SHAPE_WIDTH 0.6
#define SHAPE_HEIGHT 0.2

- (void)drawShapes
{
  [self.color setStroke];
  CGPoint cardCenter = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
  if (self.rank == 1) {
    [self drawShapeCenteredAt:cardCenter];
    return;
  }
  CGFloat yOffset = self.bounds.size.height * SHAPE_OFFSET;
  if (self.rank >= 2) {
    [self drawShapeCenteredAt:CGPointMake(cardCenter.x, cardCenter.y - yOffset / (4 - self.rank))];
    [self drawShapeCenteredAt:CGPointMake(cardCenter.x, cardCenter.y + yOffset / (4 - self.rank))];
    if (self.rank == 3) {
      [self drawShapeCenteredAt:cardCenter];
    }
  }
  
}

- (NSDictionary *)shapeMakerDictionary{
  NSDictionary * shapeMakerDictionary = @{@"oval": NSStringFromSelector(@selector(makeOvalCenteredAt:)),
                                          @"squiggle": NSStringFromSelector(@selector(makeSquiggleCenteredAt:)),
                                          @"diamond": NSStringFromSelector(@selector(makeDiamondCenteredAt:))};
  return shapeMakerDictionary;
}

- (void)drawShapeCenteredAt:(CGPoint)center
{
  UIBezierPath * path;
  if ([self.shape isEqualToString:@"oval"]) {
    path = [self makeOvalCenteredAt:center];
  }
  else if ([self.shape isEqualToString:@"diamond"]) {
    path = [self makeDiamondCenteredAt:center];
  }
  else if ([self.shape isEqualToString:@"squiggle"]) {
    path = [self makeSquiggleCenteredAt:center];
  }
  
  if (path) {
    path.lineWidth = self.bounds.size.width * SHAPE_LINE_WIDTH;
    [self fillPath:path];
    [path stroke];
  }
}

- (UIBezierPath *)makeOvalCenteredAt:(CGPoint)center;
{
  CGFloat ovalHeight = self.bounds.size.height * SHAPE_HEIGHT;
  CGFloat ovalWidth = self.bounds.size.width * SHAPE_WIDTH;
  
  UIBezierPath *oval = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(center.x - ovalWidth / 2, center.y - ovalHeight / 2, ovalWidth, ovalHeight)
                                                  cornerRadius:ovalHeight / 2];

  return oval;
}

- (UIBezierPath *)makeDiamondCenteredAt:(CGPoint)center;
{
  CGFloat diamondHeight = self.bounds.size.height * SHAPE_HEIGHT;
  CGFloat diamondWidth = self.bounds.size.width * SHAPE_WIDTH;
  UIBezierPath *diamond = [[UIBezierPath alloc]init];
  [diamond moveToPoint:CGPointMake(center.x - diamondWidth / 2, center.y)];
  [diamond addLineToPoint:CGPointMake(center.x, center.y - diamondHeight / 2)];
  [diamond addLineToPoint:CGPointMake(center.x + diamondWidth / 2, center.y)];
  [diamond addLineToPoint:CGPointMake(center.x, center.y + diamondHeight / 2)];
  [diamond closePath];
  
  return diamond;
}

#define SQUIGGLE_FACTOR 1

- (UIBezierPath *)makeSquiggleCenteredAt:(CGPoint)center;
{
  CGFloat dx = self.bounds.size.width * SHAPE_WIDTH / 2.0;
  CGFloat dy = self.bounds.size.height * SHAPE_HEIGHT / 2.0;
  CGFloat dsqx = dx * SQUIGGLE_FACTOR;
  CGFloat dsqy = dy * SQUIGGLE_FACTOR;
  UIBezierPath *squiggle = [[UIBezierPath alloc] init];
  [squiggle moveToPoint:CGPointMake(center.x - dx, center.y - dy)];
  [squiggle addQuadCurveToPoint:CGPointMake(center.x - dx, center.y + dy)
               controlPoint:CGPointMake(center.x - dx - dsqx, center.y - dsqy)];
  [squiggle addCurveToPoint:CGPointMake(center.x + dx, center.y + dy)
          controlPoint1:CGPointMake(center.x - dx + dsqx, center.y + dy + dsqy)
          controlPoint2:CGPointMake(center.x + dx - dsqx, center.y + dy - dsqy)];
  [squiggle addQuadCurveToPoint:CGPointMake(center.x + dx, center.y - dy)
               controlPoint:CGPointMake(center.x + dx + dsqx, center.y + dsqy)];
  [squiggle addCurveToPoint:CGPointMake(center.x - dx, center.y - dy)
          controlPoint1:CGPointMake(center.x + dx - dsqx, center.y - dy - dsqy)
          controlPoint2:CGPointMake(center.x - dx + dsqx, center.y - dy + dsqy)];
  
  return squiggle;
}

#define STRIPES_OFFSET 0.06
#define STRIPES_ANGLE 3

- (void)fillPath:(UIBezierPath *)path
{
  if ([self.shade isEqualToString:@"blank"]) {
    [[UIColor clearColor] setFill];
  } else if ([self.shade isEqualToString:@"striped"]) {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [path addClip];
    
    //initialize stripe origins
    UIBezierPath *stripes = [[UIBezierPath alloc] init];
    CGPoint lineStart = path.bounds.origin;
    CGPoint lineEnd = lineStart;
    CGFloat xOffset = self.bounds.size.width * STRIPES_OFFSET;
    lineEnd.y += path.bounds.size.height;
    lineStart.x -= xOffset * STRIPES_ANGLE;
    while (lineStart.x < path.bounds.origin.x + path.bounds.size.width) {
      [stripes moveToPoint:lineStart];
      [stripes addLineToPoint:lineEnd];
      lineStart.x += xOffset;
      lineEnd.x += xOffset;
    }
    stripes.lineWidth = self.bounds.size.width * SHAPE_LINE_WIDTH;
    [stripes stroke];
    
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
  } else if ([self.shade isEqualToString:@"solid"]) {
    [self.color setFill];
    [path fill];
  }
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
  return self;
}


@end

NS_ASSUME_NONNULL_END
