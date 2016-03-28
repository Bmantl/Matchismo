//
//  Card.h
//  Matchismo
//
//  Created by Boris Talesnik on 07/03/2016.
//
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

///Return the contents of the card object
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
