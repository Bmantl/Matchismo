//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Boris Talesnik on 08/03/2016.
//
//

#import "CardMatchingGame.h"
#import "Card.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

//last move members
@property (nonatomic) NSUInteger lastMatch;
@property (nonatomic, readwrite) NSInteger lastScoreAddition;
@end

@implementation CardMatchingGame

- (NSMutableArray*) cards
{
  if(!_cards) _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (NSMutableArray*) lastMatchAttemptCards
{
  if(!_lastMatchAttemptCards) _lastMatchAttemptCards = [[NSMutableArray alloc] init];
  return _lastMatchAttemptCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck

{
  self = [super init];
  
  if(self){
    for(int i = 0; i < count; i++){
      Card * card = [deck drawRandomCard];
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

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int CHOOSE_PENALTY = 1;


- (void)chooseCardAtIndex:(NSUInteger)index
{
  Card * card = [self cardAtIndex:index];
  if(card) {
    if(card.isChosen) {
      card.chosen = NO;
    } else {
      NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
      //find all of the currently chosen cards
      for (Card *otherCard in self.cards) {
        if(otherCard.isChosen && !otherCard.isMatched){
          [chosenCards addObject:otherCard];
        }
      }
      
      self.lastMatch = MAX(self.lastMatch, [card match:chosenCards]);
      if([chosenCards count] == self.matchType - 1){
        //clear last match attempt and add the current attempt cards
        if ([self.lastMatchAttemptCards count]){
          [self.lastMatchAttemptCards removeAllObjects];
        }
        [self.lastMatchAttemptCards addObjectsFromArray:chosenCards];
        [self.lastMatchAttemptCards addObject:card];
        
        if(!self.lastMatch){
          self.lastScoreAddition = -MISMATCH_PENALTY;
          self.score -= MISMATCH_PENALTY;
          for (Card * otherCard in lastMatchAttemptCards) {
            otherCard.chosen = NO;
          }
        } else{
          for (Card * otherCard in lastMatchAttemptCards) {
            otherCard.matched = YES;
          }
          self.score += self.lastMatch * MATCH_BONUS;
          self.lastScoreAddition = self.lastMatch * MATCH_BONUS;
        }
        
        self.lastMatch = 0;
      } else {
        self.lastScoreAddition = 0;
      }
      self.score -= CHOOSE_PENALTY;
      card.chosen = YES;
    }
  }
}

@end
