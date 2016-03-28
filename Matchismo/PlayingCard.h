//
//  PlayingCard.h
//  Matchismo
//
//  Created by Boris Talesnik on 07/03/2016.
//
//

#import <Foundation/Foundation.h>

#import "Card.h"

@interface PlayingCard : Card

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString * suit;

@end
