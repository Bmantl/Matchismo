// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCard : Card

+ (NSArray *)validShades;
+ (NSUInteger)maxRank;

@property (nonatomic) NSString * shade;
@property (nonatomic) NSUInteger colorIndex;
@property (nonatomic) NSUInteger rank;
@property (nonatomic, readonly) NSUInteger amountOfCardsForMatching;
@property (nonatomic, strong) NSString *shape;

@end

NS_ASSUME_NONNULL_END
