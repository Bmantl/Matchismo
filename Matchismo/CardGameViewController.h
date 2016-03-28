//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Boris Talesnik on 07/03/2016.
//
//

#import <UIKit/UIKit.h>

#import "CardContentMaker.h"
#import "CardMatchingGame.h"
#import "Deck.h"

@interface CardGameViewController : UIViewController
///abstract functions - for implemetntation by subclasses.
- (Deck *) newDeck;
- (NSAttributedString *)titleForCard:(Card *)card;
- (UIImage *)imageForCard:(Card *)card;
- (id<CardContentMaker>)newCardContentMaker;

@property (nonatomic, readonly) NSUInteger matchType;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic, strong) id<CardContentMaker> cardContentMaker;
@end
