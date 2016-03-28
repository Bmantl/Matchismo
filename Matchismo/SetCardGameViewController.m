// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "SetCardContentMaker.h"
#import "SetCardDeck.h"
#import "SetCardGameViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardGameViewController()
@property (nonatomic, weak) SetCardContentMaker * setCardContentMaker;
@end

@implementation SetCardGameViewController

- (NSArray *)validColors
{
  if (!_validColors) _validColors = @[[UIColor redColor], [UIColor greenColor],
                                      [UIColor purpleColor]];
  return _validColors;
}

- (NSArray *)validShapes
{
  if (!_validShapes) _validShapes = @[@"●", @"◼︎", @"▲"];
  return _validShapes;
}

- (SetCardContentMaker *)setCardContentMaker
{
  if (!_setCardContentMaker) {
    _setCardContentMaker = (SetCardContentMaker *)self.cardContentMaker;
  }
  
  return _setCardContentMaker;
}

- (NSUInteger)matchType
{
  return 3;
}

- (NSAttributedString *)titleForCard:(Card *)card
{
  return [self.setCardContentMaker stringForCard:card withSeparator:@"\t"];
}

- (UIImage *)imageForCard:(Card *)card
{
  return [UIImage imageNamed:card.isChosen ? @"setCardChosen" : @"cardFront"];
}

- (Deck *) newDeck
{
  return [[SetCardDeck alloc] initWithShapes:self.validShapes
                                  withColors:self.validColors];
}

- (id<CardContentMaker>)newCardContentMaker
{
  SetCardContentMaker * setCardContentMaker= [[SetCardContentMaker alloc] init];
  setCardContentMaker.validColors = self.validColors;
  return setCardContentMaker;
}

@end

NS_ASSUME_NONNULL_END
