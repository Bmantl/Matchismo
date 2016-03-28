// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "SetCardDeck.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardDeck()
@property (nonatomic, strong, readwrite) NSArray *validColors;
@end

@implementation SetCardDeck

- (instancetype)initWithShapes:(NSArray *) shapes
                    withColors:(NSArray *) colors
{
  self = [super init];
  
  if(self)
  {
    self.validColors = colors;
    for (NSString *shape in shapes) {
      for (NSUInteger colorIndex = 0; colorIndex < [colors count]; colorIndex++) {
        for (NSUInteger rank = 1; rank <= [SetCard maxRank]; rank++) {
          for (NSString *shading in [SetCard validShades]) {
            SetCard * card = [[SetCard alloc] init];
            card.shape = shape;
            card.colorIndex = colorIndex;
            card.rank = rank;
            card.shade = shading;
            [self addCard:card];
          }
        }
      }
    }
  }
  
  return self;
}

@end

NS_ASSUME_NONNULL_END
