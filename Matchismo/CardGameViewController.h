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

///creates and returns a new view for a card
//- (UIView *) newCardView;
- (UIView *)newCardViewForCard:(Card *)card;
//updates a view according to a card
- (void)updateView:(UIView *)view
          withCard:(Card *)card
          animated:(BOOL)animated
        completion:(void (^)(BOOL))completion;
- (NSUInteger)numberOfCardsToDeal;

@property (nonatomic, readonly) NSUInteger matchType;
@property (nonatomic) CGSize maxCardSize;
@end
