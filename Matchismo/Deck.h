//
//  Deck.h
//  Matchismo
//
//  Created by Boris Talesnik on 07/03/2016.
//
//

#import <Foundation/Foundation.h>

#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)newCard atTop:(BOOL)atTop;
- (void)addCard:(Card *)newCard;
- (Card *)drawRandomCard;

@end
