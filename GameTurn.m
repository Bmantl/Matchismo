// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "GameTurn.h"

NS_ASSUME_NONNULL_BEGIN

@implementation GameTurn

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.score = 0;
  }
  return self;
}
@end

NS_ASSUME_NONNULL_END
