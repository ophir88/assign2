//
//  CardSetGame.h
//  Machizmo
//
//  Created by ophir abitbol on 8/23/15.
//  Copyright (c) 2015 ophir abitbol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractCardGame.h"
#import "GameStatus.h"


@interface CardSetGame : AbstractCardGame


@property (nonatomic, strong) NSMutableArray * cards;
@property (nonatomic, strong) GameStatus * gameStatus;
@property (strong, nonatomic) NSMutableArray *historyArray;

@end
