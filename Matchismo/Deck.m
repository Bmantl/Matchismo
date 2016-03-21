//
//  Deck.m
//  Matchismo
//
//  Created by Boris Talesnik on 07/03/2016.
//
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

- (NSMutableArray *) cards
{
  if (!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (void) addCard:(Card *)newCard atTop:(BOOL)atTop
{
  if (atTop)
  {
    [self.cards insertObject:newCard atIndex:0];
  }
  else
  {
    [self.cards addObject:newCard];
  }
}

- (void) addCard:(Card *)newCard
{
  [self addCard:newCard atTop:NO];
}

- (Card *)drawRandomCard
{
  Card * randomCard = nil;
  
  if([self.cards count])
  {
    unsigned index = arc4random() % [self.cards count];
    randomCard = self.cards[index];
    [self.cards removeObjectAtIndex:index];
  }
  
  return randomCard;
}

@end
