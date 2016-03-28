// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "GameHistoryViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface GameHistoryViewController()
@property (weak, nonatomic) IBOutlet UITextView *historyText;

@end

@implementation GameHistoryViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self updateUI];
}

- (void)updateUI
{
  NSMutableAttributedString *historyText = [[NSMutableAttributedString alloc]init];
  for(int i = 0; i < [self.gameHistory count]; i++){
    GameTurn *turn = self.gameHistory[i];
    [historyText appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d:\t", i + 1]]];
    [historyText appendAttributedString:[self matchResultForTurn:turn]];
    [historyText appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
  }
  self.historyText.attributedText = historyText;
}

- (NSAttributedString *)matchResultForTurn:(GameTurn *)turn
{
  NSMutableAttributedString * result = [[NSMutableAttributedString alloc] init];
  for (Card * card in turn.matchedCards) {
    [result appendAttributedString:[self.cardContentMaker contentsForCard:card]];
    [result appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
  }
  [result appendAttributedString:
   [[NSAttributedString alloc] initWithString:turn.score > 0 ? @"Match! " : @"Mismatch! "]];
  [result appendAttributedString:
   [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld Points!", turn.score]]];
  
  return result;
}

@end

NS_ASSUME_NONNULL_END
