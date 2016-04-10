// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardView

- (void)setColor:(UIColor *)color {
  _color = color;
  [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank {
  _rank = rank;
  [self setNeedsDisplay];
}

- (void)setShade:(NSString *)shade {
  _shade = shade;
  [self setNeedsDisplay];
}

- (void)setChosen:(BOOL)chosen {
  _chosen = chosen;
  [self setNeedsDisplay];
}

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
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

- (void)drawShapes {
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

- (void)drawShapeCenteredAt:(CGPoint)center {
  UIBezierPath * path = [self makeShapeCenteredAt:center];
  if (path) {
    path.lineWidth = self.bounds.size.width * SHAPE_LINE_WIDTH;
    [self fillPath:path];
    [path stroke];
  }
}

#define STRIPES_OFFSET 0.06
#define STRIPES_ANGLE 3

- (void)fillPath:(UIBezierPath *)path {
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
    //draw lines
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

- (void)setup {
  self.backgroundColor = nil;
  self.opaque = NO;
  self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
  [self setup];
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  [self setup];
  return self;
}

#pragma mark - Abstract Methods

- (UIBezierPath *)makeShapeCenteredAt:(CGPoint)center {
  return nil;
}

@end

NS_ASSUME_NONNULL_END
