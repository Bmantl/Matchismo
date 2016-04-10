//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Boris Talesnik on 07/03/2016.
//
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "GameHistoryViewController.h"
#import "Grid.h"
#import "PlayingCard.h"
#import "PlayingCardView.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame * game;
@property (nonatomic) BOOL needsMatchDisplay;
@property (weak, nonatomic) IBOutlet UIView *cardGridView;
@property (nonatomic, strong) Grid *grid;
@property (nonatomic, strong) NSMutableArray *cardViews;
@property (nonatomic, strong) UIDynamicAnimator *pileAnimator;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) CGSize maxCardSize;

//properties for the snap and move animations
@property (nonatomic) CGPoint snapToAnchorDelta;
@property (nonatomic) CGPoint snapCenter;
@end

@implementation CardGameViewController

static const NSInteger kDefaultMatchType = 2;


#pragma mark - Setters Getters

- (NSUInteger) matchType
{
  return kDefaultMatchType;
}

- (NSMutableArray *)cardViews {
  if (!_cardViews) {
    _cardViews = [[NSMutableArray alloc] init];
  }
  return _cardViews;
}

- (Grid *)grid {
  if (!_grid){
    _grid = [[Grid alloc] init];
    _grid.cellAspectRatio = self.maxCardSize.width / self.maxCardSize.height;
    _grid.minimumNumberOfCells = self.game.numberOfDealtCards;
    _grid.maxCellHeight = self.maxCardSize.height;
    _grid.maxCellWidth = self.maxCardSize.width;
    _grid.size = self.cardGridView.bounds.size;
  }
  
  return _grid;
}

#define DEFAULT_NUMBER_OF_CARDS 12

- (CardMatchingGame *) game {
  if (!_game){
    _game = [[CardMatchingGame alloc] initWithCardCount:DEFAULT_NUMBER_OF_CARDS
                                              usingDeck:[self newDeck]];
    _game.matchType = self.matchType;
  }
  
  return _game;
}

#pragma mark - Init and display

#define CARD_HEIGHT 180.0
#define CARD_WIDTH 120.0

- (void)viewDidLoad {
  self.maxCardSize = CGSizeMake(CARD_WIDTH, CARD_HEIGHT);
  self.scoreLabel.layer.borderColor = [UIColor blackColor].CGColor;
  [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
  UIPinchGestureRecognizer *pinchPan = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(pinchGrid:)];
  [self.cardGridView addGestureRecognizer:pinchPan];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self updateUI];
}

-(void)viewDidLayoutSubviews {
  self.grid = nil;
  [self updateUI];
}

- (void)resetGame
{
  self.game = nil;
  self.pileAnimator = nil;
  for (UIView *cardView in self.cardViews) {
    [self removeCardView:cardView withDelayFactor:0];
  }
  self.cardViews = nil;
}

- (NSUInteger)numberOfCardsToDeal {
  return 1;
}

- (void)updateUI {
  if(self.pileAnimator) return;
  NSUInteger removedCards = 0;
  for (NSUInteger cardIndex = 0; cardIndex < self.game.numberOfDealtCards; cardIndex++){
    Card *card = [self.game cardAtIndex:cardIndex];
    //pick view index by tag
    NSUInteger cardViewIndex = [self.cardViews indexOfObjectPassingTest:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return (BOOL)(((UIView *)obj).tag == cardIndex);
    }];
    
    if (cardViewIndex == NSNotFound){
      //creation and binding of new card view
      if (!card.isMatched) {
        UIView *cardView = [self newCardViewForCard:card];
        //the card index is saved in the tag for easy easy access between cards an their views
        cardView.tag = cardIndex;
        [self bindCardView:cardView];
      }
    }else{
      UIView *cardView = [self.cardViews objectAtIndex:cardViewIndex];
      if (card.isMatched){
        [self.cardViews removeObject:cardView];
        [self removeCardView:cardView withDelayFactor:removedCards++];
      }else{
        [self updateView:cardView withCard:card animated:YES completion:nil];
      }
    }
  }
  
  [self updateCardViewlocations];
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

//Binds a \c cardView to recognizers, super views and arrays
- (void)bindCardView:(UIView *)cardView {
  [self.cardViews addObject:cardView];
  [self.cardGridView addSubview:cardView];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(tapCard:)];
  [cardView addGestureRecognizer:tap];
  UIPanGestureRecognizer *gridPan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(panPile:)];
  [cardView addGestureRecognizer:gridPan];
}


//Updates the current card views to be at the correct location
//if not correct - moves them to the right place
- (void)updateCardViewlocations {
  self.grid.minimumNumberOfCells = [self.cardViews count];
  NSUInteger movedViews = 0;
  for (NSUInteger cardViewIndex = 0; cardViewIndex < [self.cardViews count]; cardViewIndex++) {
    CGRect frame = [self.grid frameOfCellAtRow:cardViewIndex / self.grid.columnCount
                                      inColumn:cardViewIndex % self.grid.columnCount];
    UIView *cardView = [self.cardViews objectAtIndex:cardViewIndex];
    
    if (!CGRectEqualToRect(frame, cardView.frame)) {
      [UIView animateWithDuration:0.5
                            delay:0.03 * movedViews++
                          options:UIViewAnimationOptionCurveEaseInOut
                       animations:^{
                         cardView.frame = frame;
                       }
                       completion:nil];
    }
  }
}

//Removes a card \c view.
// \c numberInLine is the factor of how much to delay the removal
- (void)removeCardView:(UIView *)view withDelayFactor:(NSUInteger)numberInLine {
  [UIView animateWithDuration:0.5
                        delay:0.1 * numberInLine
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{
                     CGRect frame = CGRectMake(-200.0, -200.0, view.frame.size.width, view.frame.size.height);
                     view.frame = frame;
                   }
                   completion:^(BOOL finished) {
                     [view removeFromSuperview];
                   }];
  
}

#pragma mark - Actions / Gestures

- (void)pinchGrid:(UIPinchGestureRecognizer *)gesture {
  
  if (self.pileAnimator) {
    if (gesture.scale > 1) {
      self.pileAnimator = nil;
    }
  }
  else if (gesture.scale < 1) {
    self.snapCenter = [gesture locationInView:self.cardGridView];
    self.pileAnimator = [[UIDynamicAnimator alloc] init];
    for (UIView *cardView in self.cardViews){
      UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:cardView snapToPoint:self.snapCenter];
      [self.pileAnimator addBehavior:snap];
    }
  }
  
  gesture.scale = 1;
  [self updateUI];
}

- (IBAction)resetButtonTap:(id)sender {
  [self resetGame];
  [self updateUI];
}

- (void)panPile:(UIPanGestureRecognizer *)gesture {
  if (!self.pileAnimator) {
    return;
  }
  CGPoint panPoint = [gesture locationInView:self.cardGridView];
  
  if (gesture.state == UIGestureRecognizerStateBegan) {
    self.snapToAnchorDelta = CGPointMake(panPoint.x - self.snapCenter.x, panPoint.y - self.snapCenter.y);
  }else if (gesture.state == UIGestureRecognizerStateChanged){
    for (UIDynamicBehavior *behavior in self.pileAnimator.behaviors) {
      if([behavior isKindOfClass:[UISnapBehavior class]]){
        UISnapBehavior * snap = (UISnapBehavior *)behavior;
        self.snapCenter = CGPointMake(panPoint.x + self.snapToAnchorDelta.x, panPoint.y + self.snapToAnchorDelta.y);
        snap.snapPoint = self.snapCenter;
      }
    }
  }
}

- (void)tapCard:(UITapGestureRecognizer *)gesture {
  if (self.pileAnimator) {
    self.pileAnimator = nil;
    [self updateUI];
    return;
  }
  
  UIView *cardView = (UIView *)gesture.view;
  [self.game chooseCardAtIndex:cardView.tag];
  [self updateView:cardView
          withCard:[self.game cardAtIndex:cardView.tag]
          animated:YES
        completion:^(BOOL finished) {
          [self updateUI];
        }];
}

- (IBAction)addCardsTapped:(id)sender {
  if (![self.game drawCards:[self numberOfCardsToDeal]]) {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Achtung!"
                                                                   message:@"No More Cards in Deck!!!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:nil];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
  }
  [self updateUI];
}

#pragma mark - Abstract Methods

- (Deck *)newDeck {
  return nil;
}

- (UIView *)newCardViewForCard:(Card *)card {
  return nil;
}

- (void)updateView:(UIView *)view
          withCard:(Card *)card
          animated:(BOOL)animated
        completion:(void (^)(BOOL))completion { 
  
}

@end
