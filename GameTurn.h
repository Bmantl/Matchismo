// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameTurn : NSObject
@property (nonatomic) NSInteger score;;
@property (nonatomic, strong) NSArray * matchedCards;
@end

NS_ASSUME_NONNULL_END
