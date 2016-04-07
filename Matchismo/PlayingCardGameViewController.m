// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "PlayingCardDeck.h"
#import "PlayingCardGameViewController.h"
#import "PlayingCardView.h"

NS_ASSUME_NONNULL_BEGIN

@implementation PlayingCardGameViewController

- (Deck *)newDeck
{
  return [[PlayingCardDeck alloc] init];
}

- (UIView *) newCardView{
  return [[PlayingCardView alloc] init];
}

- (void)updateView:(UIView *)view
          withCard:(Card *)card
          animated:(BOOL)animated
        completion:(void (^)(BOOL))completion{
  if (![view isKindOfClass:[PlayingCardView class]]) return;
  if (![card isKindOfClass:[PlayingCard class]]) return;
  
  PlayingCard *playingCard = (PlayingCard *)card;
  PlayingCardView *playingCardView = (PlayingCardView *)view;
  playingCardView.rank = playingCard.rank;
  playingCardView.suit = playingCard.suit;
  if(animated && (playingCardView.faceUp != playingCard.isChosen)){
    [self animateFlipForView:playingCardView WithCompletion:completion];
  }
}

- (void)animateFlipForView:(PlayingCardView*)playingCardView
            WithCompletion:(void (^)(BOOL))completion{
  [UIView transitionWithView:playingCardView
                    duration:0.5
                     options:UIViewAnimationOptionTransitionFlipFromLeft
                  animations:^{
                    playingCardView.faceUp = !playingCardView.faceUp;
                  } completion:completion];
}

- (NSUInteger)numberOfCardsToDeal{
  return 2;
}

@end

NS_ASSUME_NONNULL_END
