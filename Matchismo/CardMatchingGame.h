//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Boris Talesnik on 08/03/2016.
//
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *) deck;

- (Card *)cardAtIndex:(NSUInteger)index;
- (void)chooseCardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readwrite) NSUInteger matchType;

//ued to store the score of the last match
@property (nonatomic, readonly) NSInteger lastScoreAddition;
//stores the cards used for the last matchAttempt
@property (nonatomic, strong) NSMutableArray * lastMatchAttemptCards;

@end
