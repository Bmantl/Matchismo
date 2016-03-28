// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import <UIKit/UIKit.h>

#import "PlayingCardContentMaker.h"


NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardContentMaker

- (NSAttributedString *)contentsForCard:(Card*)card
{
  NSDictionary *attributes = @{ NSForegroundColorAttributeName : [UIColor blackColor] };  
  return [[NSAttributedString alloc] initWithString:card.contents attributes:attributes];
}

@end

NS_ASSUME_NONNULL_END
