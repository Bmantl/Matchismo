// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "SquiggleSetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SquiggleSetCardView
#define SHAPE_WIDTH 0.6
#define SHAPE_HEIGHT 0.2

#define SQUIGGLE_FACTOR 1

- (UIBezierPath *)makeShapeCenteredAt:(CGPoint)center {
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
@end

NS_ASSUME_NONNULL_END
