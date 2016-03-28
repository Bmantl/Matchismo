// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import <UIKit/UIKit.h>

#import "CardContentMaker.h"
#import "GameTurn.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameHistoryViewController : UIViewController
@property (nonatomic, strong) NSArray *gameHistory;
@property (nonatomic, weak) id<CardContentMaker> cardContentMaker;
@end

NS_ASSUME_NONNULL_END
