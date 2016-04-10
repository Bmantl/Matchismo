// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///Object used to graphically represent a Set Card
@interface SetCardView : UIView

//Abstract
///Returns a path of a shape centered at \c center
- (UIBezierPath *)makeShapeCenteredAt:(CGPoint)center;

@property (nonatomic, strong) UIColor *color;
@property (nonatomic) NSUInteger rank;
@property (nonatomic) NSString * shade;

@property (nonatomic) BOOL chosen;
@end

NS_ASSUME_NONNULL_END
