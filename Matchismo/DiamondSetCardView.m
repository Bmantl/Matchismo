// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "DiamondSetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation DiamondSetCardView

#define SHAPE_WIDTH 0.6
#define SHAPE_HEIGHT 0.2

- (UIBezierPath *)makeShapeCenteredAt:(CGPoint)center {
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
@end

NS_ASSUME_NONNULL_END
