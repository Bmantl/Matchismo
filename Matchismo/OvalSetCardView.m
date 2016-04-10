// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "OvalSetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation OvalSetCardView
#define SHAPE_WIDTH 0.6
#define SHAPE_HEIGHT 0.2

- (UIBezierPath *)makeShapeCenteredAt:(CGPoint)center {
  CGFloat ovalHeight = self.bounds.size.height * SHAPE_HEIGHT;
  CGFloat ovalWidth = self.bounds.size.width * SHAPE_WIDTH;
  
  UIBezierPath *oval =
    [UIBezierPath bezierPathWithRoundedRect:CGRectMake(center.x - ovalWidth / 2, center.y - ovalHeight / 2, ovalWidth, ovalHeight)
                               cornerRadius:ovalHeight / 2];
  
  return oval;
}
@end

NS_ASSUME_NONNULL_END
