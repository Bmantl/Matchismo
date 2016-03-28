// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import <Foundation/Foundation.h>

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CardContentMaker <NSObject>
- (NSAttributedString *)contentsForCard:(Card*)card;
@end

NS_ASSUME_NONNULL_END
