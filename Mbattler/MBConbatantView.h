//
//  MBConbatantView.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/10/05.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBConbatantView : UIScrollView{
    NSMutableArray *conbatant;    // 戦闘参加者配列
    int turn;
    UILabel *turn_label;    // ターン数表示
}

// ターン数をセットして表示する
- (void)setTurn:(int)t;
// ターン数を増やす
- (int)nextTurn;

@end
