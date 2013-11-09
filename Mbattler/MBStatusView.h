//
//  MBStatusView.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBScrollView.h"
#import "Meishi.h"
#import "Player.h"

@interface MBStatusView : MBScrollView{
    UIButton *backbutton;
    Meishi *meishi;
    
    UILabel *lv_gauge;
    UILabel *exp_gauge;
    UILabel *h_gauge;
    UILabel *a_gauge;
    UILabel *b_gauge;
    UILabel *c_gauge;
    UILabel *d_gauge;
    UILabel *s_gauge;
}

@property(readwrite) UIButton *fire_button;

- (id)initWithMeishi:(Meishi *)meishi;
- (id)initWithMeishi:(Meishi *)m Player:(Player *)p;
- (void)removeBackButton;

@end


// (int)(([meishi getExp]/(float)[meishi getNextExp])*dark_bg_rect.size.width)