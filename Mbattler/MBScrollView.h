//
//  MBScrollView.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface MBScrollView : UIScrollView{
    int width;
    int height;
    
    UIImageView *titleImage;
    UILabel *title;
    
    // 下のスクロールのやつ
    
    UIColor *title_bg;
    UIColor *sub_bg;
    
    Player *player;
}

- (id)initWithPlayer:(Player *)p;
- (void)setTitle:(NSString *)t;
- (void)setTitle;
- (void)setBackButton;

// ゲッター
- (UIColor *)getSubBg;
@end
