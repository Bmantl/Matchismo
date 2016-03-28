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
#import "GameTurn.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *) deck;

- (Card *)cardAtIndex:(NSUInteger)index;
- (void)chooseCardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readwrite) NSUInteger matchType;
@property (nonatomic, readonly) NSArray *history;

@end
