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
- (void)choosCardAtIndex:(NSUInteger)index;
- (NSInteger)lastScoreAddition;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readwrite) NSUInteger matchType;
@property (nonatomic, strong, readonly) NSString * lastScoreReason;
@property (nonatomic, readonly) NSInteger lastScoreAddition;
@property (nonatomic, strong) NSMutableArray * lastMatchAttempt;

@end
