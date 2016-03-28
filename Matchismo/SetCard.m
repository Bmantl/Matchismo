// Copyright (c) 2016 Lightricks. All rights reserved.
// Created by Boris Talesnik.

#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCard()
@property (nonatomic, readwrite) NSUInteger amountOfCardsForMatching;
@end

@implementation SetCard

- (NSString *)contents
{
  return nil;
}

- (instancetype)init
{
  self = [super init];
  
  if(self){
    self.amountOfCardsForMatching = 3;
  }
  
  return self;
}


- (int)match:(NSArray *)otherCards
{
  if([otherCards count] + 1 != self.amountOfCardsForMatching){
    return 0;
  }
  
  NSMutableSet *colors =
  [[NSMutableSet alloc] initWithObjects:[NSNumber numberWithUnsignedInteger:self.colorIndex], nil];
  NSMutableSet *ranks =
  [[NSMutableSet alloc] initWithObjects:[NSNumber numberWithUnsignedInteger:self.rank], nil];
  NSMutableSet *shapes = [[NSMutableSet alloc] initWithObjects:self.shape, nil];
  NSMutableSet *shades = [[NSMutableSet alloc] initWithObjects:self.shade, nil];
  
  for (Card * otherCard in otherCards) {
    if([otherCard isKindOfClass:[SetCard class]]){
      SetCard *otherSetCard = (SetCard *)otherCard;
      [colors addObject:[NSNumber numberWithUnsignedInteger:otherSetCard.colorIndex]];
      [ranks addObject:[NSNumber numberWithUnsignedInteger:otherSetCard.rank]];
      [shapes addObject:otherSetCard.shape];
      [shades addObject:otherSetCard.shade];
    }
  }
  
  if(([colors count] == 1 || [colors count] == self.amountOfCardsForMatching)
     && ([shapes count] == 1 || [shapes count] == self.amountOfCardsForMatching)
     && ([ranks count] == 1 || [ranks count] == self.amountOfCardsForMatching)
     && ([shades count] == 1 || [shades count] == self.amountOfCardsForMatching))
  {
    return 5;
  }
  
  return 0;
  
}

const NSUInteger MAX_RANK = 3;

+ (NSUInteger)maxRank
{
  return MAX_RANK;
}

+ (NSArray *)validShades
{
  return @[@"solid", @"striped", @"blank"];
}

@end

NS_ASSUME_NONNULL_END
