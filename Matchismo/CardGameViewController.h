//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Boris Talesnik on 07/03/2016.
//
//

#import <UIKit/UIKit.h>

#import "CardMatchingGame.h"
#import "Deck.h"

@interface CardGameViewController : UIViewController
///abstract functions - for implemetntation by subclasses.
///returns a new deck
- (Deck *) newDeck;

///Creates and returns a new view for a card
- (UIView *)newCardViewForCard:(Card *)card;
///Updates a view according to a given \c card
- (void)updateView:(UIView *)view
          withCard:(Card *)card
          animated:(BOOL)animated
        completion:(void (^)(BOOL))completion;
- (NSUInteger)numberOfCardsToDeal;

@property (nonatomic, readonly) NSUInteger matchType;

@end
