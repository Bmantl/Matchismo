// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "CardContentMaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardContentMaker : NSObject <CardContentMaker>
- (NSAttributedString *)stringForCard:(Card *)card
                        withSeparator:(NSString *)separator;

@property (nonatomic, weak) NSArray *validColors;
@end

NS_ASSUME_NONNULL_END
