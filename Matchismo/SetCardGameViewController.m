// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "SetCardDeck.h"
#import "SetCardGameViewController.h"
#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCardGameViewController()
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
  if (!_validShapes) _validShapes = @[@"oval", @"squiggle", @"diamond"];
  return _validShapes;
}

- (NSUInteger)matchType
{
  return 3;
}

- (UIView *) newCardView{
  return [[SetCardView alloc] init];
}

- (void)updateView:(UIView *)view
          withCard:(Card *)card
          animated:(BOOL)animated
        completion:(void (^)(BOOL))completion{
  if (![view isKindOfClass:[SetCardView class]]) return;
  if (![card isKindOfClass:[SetCard class]]) return;
  
  SetCard *setCard = (SetCard *)card;
  SetCardView *setCardView = (SetCardView *)view;
  
  [UIView animateWithDuration:0.5 * (int)animated
                   animations:^{
                     setCardView.shade = setCard.shade;
                     setCardView.shape = setCard.shape;
                     setCardView.color = self.validColors[setCard.colorIndex];
                     setCardView.rank = setCard.rank;
                     setCardView.chosen = setCard.chosen;
                   } completion:completion];
}

- (Deck *) newDeck
{
  return [[SetCardDeck alloc] initWithShapes:self.validShapes
                                  withColors:self.validColors];
}

- (NSUInteger)numberOfCardsToDeal{
  return 3;
}

@end

NS_ASSUME_NONNULL_END
