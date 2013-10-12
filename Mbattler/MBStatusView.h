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
}

@property(readwrite) UIButton *fire_button;

- (id)initWithMeishi:(Meishi *)meishi;
- (id)initWithMeishi:(Meishi *)m Player:(Player *)p;
- (void)removeBackButton;

@end
