//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Boris Talesnik on 08/03/2016.
//
//

#import "Card.h"
#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, readwrite) NSUInteger numberOfDealtCards;
@end

@implementation CardMatchingGame

static const int kMatchBonus = 4;
static const int kMismatchPenalty = 2;
static const int kChoosePenalty = 1;

- (NSMutableArray*)cards
{
  if(!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
  self = [super init];
  if(self){
    self.deck = deck;
    for(int i = 0; i < count; i++){
      Card * card = [deck drawRandomCard];
      self.numberOfDealtCards++;
      if(card){
        [self.cards addObject:card];
      }else{
        self = nil;
        break;
      }
    }
  }
  
  return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
  return index < [self.cards count] ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
  Card * card = [self cardAtIndex:index];
  if(card) {
    if(card.isChosen) {
      card.chosen = NO;
    } else {
      NSArray *chosenCards = [self getChosenCards];
      NSInteger turnScore = 0;
      if([chosenCards count] == self.matchType - 1){
        turnScore = [self getTurnScoreForCard:card withCards:chosenCards];
      }
      self.score += turnScore - kChoosePenalty;
      card.chosen = YES;
    }
  }
}

//finds the currently chosen cards that are mot matched and returns them
- (NSArray *)getChosenCards
{
  NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
  for (Card *otherCard in self.cards) {
    if(otherCard.isChosen && !otherCard.isMatched){
      [chosenCards addObject:otherCard];
    }
  }
  return [chosenCards copy];
}

//returns a score for matchhing a card with other cards
- (NSInteger)getTurnScoreForCard:(Card *)card withCards:(NSArray *)otherCards
{
  NSInteger matchScore = [card match:otherCards];
  NSInteger turnScore = 0;
  if(!matchScore){
    for (Card * otherCard in otherCards) {
      otherCard.chosen = NO;
    }
    turnScore = -kMismatchPenalty;
  } else{
    for (Card * otherCard in otherCards) {
      otherCard.matched = YES;
      card.matched = YES;
    }
    turnScore = matchScore * kMatchBonus;
  }
  
  return turnScore;
}

- (BOOL)drawCards:(NSUInteger)amount{
  for(int i = 0; i < amount; i++){
    Card * card = [self.deck drawRandomCard];
    if(card){
      [self.cards addObject:card];
      self.numberOfDealtCards++;
    }else{
      return NO;
    }
  }
  return YES;
}

@end
