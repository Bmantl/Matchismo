// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "SetCardContentMaker.h"
#import "SetCard.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@implementation SetCardContentMaker

//returns a contents string for a card
- (NSAttributedString *)contentsForCard:(Card*)card
{
  return [self stringForCard:card withSeparator:@""];
}

//Gets a string for a card concatanated by a given saparator.
- (NSAttributedString *)stringForCard:(Card *)card
                        withSeparator:(NSString *)separator
{
  if (![card isKindOfClass:[SetCard class]])
  {
    return [[NSAttributedString alloc] initWithString:@""];
  }
  
  SetCard *setCard = (SetCard *)card;
  NSMutableArray *shapes = [[NSMutableArray alloc] init];
  for (int i = 0; i < setCard.rank; i++) {
    shapes[i] = setCard.shape;
  }
  
  NSString * cardString = [shapes componentsJoinedByString:separator];
  NSDictionary *attributes = @{ NSStrokeWidthAttributeName: @-3.0,
                                NSStrokeColorAttributeName: [self strokeColorForCard:setCard],
                                NSForegroundColorAttributeName: [self fillForCard:setCard]};
  
  return [[NSAttributedString alloc] initWithString:cardString attributes:attributes];
}

- (UIColor *)fillForCard:(SetCard *)card
{
  CGFloat alpha = 0.0f;
  if ([card.shade isEqualToString:@"solid"]){
    alpha = 1.0f;
  } else if ([card.shade isEqualToString:@"striped"]){
    alpha = 0.4f;
  }
  return [[self strokeColorForCard:card] colorWithAlphaComponent:alpha];
}

- (UIColor *)strokeColorForCard:(SetCard *)card
{
  return self.validColors[card.colorIndex];
}

@end

NS_ASSUME_NONNULL_END
