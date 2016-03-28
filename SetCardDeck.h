// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "Deck.h"
#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardDeck : Deck

- (instancetype)initWithShapes:(NSArray *) shapes
                        withColors:(NSArray *) colors;

@property (nonatomic, strong, readonly) NSArray *validColors;

@end

NS_ASSUME_NONNULL_END
