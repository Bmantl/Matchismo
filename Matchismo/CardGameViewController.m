//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Boris Talesnik on 07/03/2016.
//
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame * game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchAmountControl;
@property (weak, nonatomic) IBOutlet UILabel *gameState;
@property (weak, nonatomic) IBOutlet UILabel *matchResult;
@property (nonatomic, strong) NSMutableArray * playingCards;
@end

@implementation CardGameViewController

- (NSMutableArray *) playingCards
{
    if(!_playingCards) _playingCards = [[NSMutableArray alloc] init];
    return _playingCards;
}

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *) game
{
    if (!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    }
    
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    if(self.matchAmountControl.enabled){
        self.matchAmountControl.enabled = NO;
        self.game.matchType = [self getMatchAmount];
    }
    
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)touchResetButton:(UIButton *)sender
{
    [self resetGame];
    [self updateUI];
}

- (void)updateUI
{
    NSMutableString * gameOutput = [[NSMutableString alloc] init];
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card * card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
        if(card.chosen && !card.isMatched){
            [gameOutput appendString:card.contents];
        }
        cardButton.enabled = !card.isMatched;
    }
    [self showMatchingResult];
    self.gameState.text = gameOutput;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (void)showMatchingResult
{
    NSMutableString * result = [[NSMutableString alloc] init];
    if (self.game.lastScoreAddition != 0){
        for (Card * card in self.game.lastMatchAttempt) {
            [result appendString:card.contents];
        }
        [self.playingCards removeAllObjects];
        [result appendString:self.game.lastScoreAddition > 0 ? @"Match! " : @"Mismatch! "];
        [result appendFormat:@"%ld Points!", self.game.lastScoreAddition];
    }
    
    self.matchResult.text = result;
}

- (void)resetGame
{
    self.matchAmountControl.enabled = YES;
    self.game = nil;
}

- (NSUInteger)getMatchAmount
{
    return [self.matchAmountControl selectedSegmentIndex] + 2;
}

- (UIImage *)imageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

@end
