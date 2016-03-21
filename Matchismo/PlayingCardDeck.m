//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Boris Talesnik on 07/03/2016.
//
//

#import "PlayingCardDeck.h"

@implementation PlayingCardDeck

- (instancetype)init
{
  self = [super init];
  if(self)
  {
    for (NSString *suit in [PlayingCard validSuits]) {
      for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
        PlayingCard * card = [[PlayingCard alloc] init];
        card.suit = suit;
        card.rank = rank;
        [self addCard:card];
      }
    }
  }
  
  return self;
}

@end
