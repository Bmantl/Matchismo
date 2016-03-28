// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "PlayingCardContentMaker.h"
#import "PlayingCardDeck.h"
#import "PlayingCardGameViewController.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardGameViewController

- (NSAttributedString *)titleForCard:(Card *)card
{
  NSString *title = card.isChosen ? card.contents : @"";
  NSDictionary *attributes = @{ NSForegroundColorAttributeName : [UIColor blackColor] };

  return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (UIImage *)imageForCard:(Card *)card
{
  return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

- (Deck *)newDeck
{
  return [[PlayingCardDeck alloc] init];
}

- (id<CardContentMaker>)newCardContentMaker
{
  return [[PlayingCardContentMaker alloc] init];
}

@end

NS_ASSUME_NONNULL_END
