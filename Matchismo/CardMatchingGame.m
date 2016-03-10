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
@property (nonatomic, strong, readwrite) NSString * lastScoreReason;
@end

@implementation CardMatchingGame

- (NSMutableArray*) cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray*) lastMatchAttempt
{
    if(!_lastMatchAttempt) _lastMatchAttempt = [[NSMutableArray alloc] init];
    return _lastMatchAttempt;
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


- (void)choosCardAtIndex:(NSUInteger)index
{
    Card * card = [self cardAtIndex:index];
    if(card) {
        if(card.isChosen) {
            card.chosen = NO;
        } else {
            NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if(otherCard.isChosen && !otherCard.isMatched){
                    [chosenCards addObject:otherCard];
                }
            }
            [self.lastMatchAttempt removeAllObjects];
            self.lastMatch = MAX(self.lastMatch, [card match:chosenCards]);
            if([chosenCards count] == self.matchType - 1){
                [self.lastMatchAttempt addObjectsFromArray:chosenCards];
                [self.lastMatchAttempt addObject:card];
                if(!self.lastMatch){
                    self.lastScoreAddition = -MISMATCH_PENALTY;
                    self.score -= MISMATCH_PENALTY;
                    for (Card * otherCard in chosenCards) {
                        otherCard.chosen = NO;
                    }
                } else{
                    for (Card * otherCard in chosenCards) {
                        otherCard.matched = YES;
                    }
                    card.matched  = YES;
                    self.score += self.lastMatch * MATCH_BONUS;
                    self.lastScoreAddition = self.lastMatch * MATCH_BONUS;
                }
                self.lastMatch = 0;
            } else {
                self.lastScoreAddition = 0;
                
            }
        }
    }
    
    
    self.score -= CHOOSE_PENALTY;
    card.chosen = YES;
}


//- (void)choosCardAtIndex1:(NSUInteger)index
//{
//    Card * card = [self cardAtIndex:index];
//    if(card) {
//        if(card.isChosen) {
//            card.chosen = NO;
//            [self.chosenUnmatchedCards removeObject:card];
//        } else if (!card.isMatched) {
//            //start checking matches
//            if(self.matchAmount == [self.chosenUnmatchedCards count] + 1){
//                int matchScore = 0;
//                if(self.matchAmount == 2)
//                {
//                    matchScore = [card match:self.chosenUnmatchedCards];
//                } else {
//                    
//                    NSMutableArray *cardArray =   [[NSMutableArray alloc] initWithArray:self.chosenUnmatchedCards];
//                    [cardArray addObject:card];
//                    while ([cardArray count] - 3) {
//                        Card * otherCard = [cardArray firstObject];
//                        [cardArray removeObjectAtIndex:0];
//                        matchScore = MAX(matchScore, [otherCard match:cardArray]);
//                    }
//                    for (int i = 0; i < 3; i++)
//                    {
//                        Card * otherCard = cardArray[i];
//                        [cardArray removeObjectAtIndex:i];
//                        matchScore = MAX(matchScore, [otherCard match:cardArray]);
//                        [cardArray insertObject:otherCard atIndex:i];
//                    }
//                }
//                [self.chosenUnmatchedCards addObject:card];
//                if(!matchScore){
//                    self.score -= MISMATCH_PENALTY;
//                    for (Card * otherCard in self.chosenUnmatchedCards) {
//                        otherCard.chosen = NO;
//                    }
//                    [self.chosenUnmatchedCards removeAllObjects];
//                    
//                    [self.chosenUnmatchedCards addObject:card];
//
//                } else{
//                    for (Card * otherCard in self.chosenUnmatchedCards) {
//                        otherCard.matched = YES;
//                    }
//                    [self.chosenUnmatchedCards removeAllObjects];
//                    if (self.matchAmount == 2){
//                        //for the case of 2-match game
//                        self.score += matchScore * MATCH_BONUS;
//                        ;
//                    } else {
//                        //for the case of N-match game
//                        self.score += matchScore * (MATCH_BONUS + self.matchAmount);
//                    }
//                }
//                //clear chosen unmatched cards
//                
//            } else {
//                [self.chosenUnmatchedCards addObject:card];
//            }
//        }
//        card.chosen = YES;
//        self.score -= CHOOSE_PENALTY;
//    }
//}








@end
