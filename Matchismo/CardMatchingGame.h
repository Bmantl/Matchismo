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
- (BOOL)drawCards:(NSUInteger)amount;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readwrite) NSUInteger matchType;
@property (nonatomic, readonly) NSUInteger numberOfDealtCards;
@end
