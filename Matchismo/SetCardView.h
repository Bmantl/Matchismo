// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetCardView : UIView

@property (nonatomic, strong) UIColor *color;
@property (nonatomic) NSUInteger rank;
@property (nonatomic, strong) NSString *shape;
@property (nonatomic) NSString * shade;

@property (nonatomic) BOOL chosen;
@end

NS_ASSUME_NONNULL_END
