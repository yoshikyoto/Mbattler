//
//  MBStatusView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBStatusView.h"
#import "Meishi.h"

@implementation MBStatusView

- (id) initWithMeishi:(Meishi *)m Player:(Player *)p{
    // 解雇ボタン
    _fire_button = [UIButton buttonWithType:UIButtonTypeCustom];
    _fire_button.frame = CGRectMake(253, 6, 50, 36);
    _fire_button.titleLabel.font = [UIFont fontWithName:@"mikachan_o" size:16];
    _fire_button.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:0.8];
    [_fire_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_fire_button setTitle:@"解雇" forState:UIControlStateNormal];
    
    self = [self initWithMeishi:m];
    if(self){
    }
    return self;
}

- (id)initWithMeishi:(Meishi *)m
{
    self = [super initWithPlayer:nil];
    if (self) {
        // Initialization code
        //self.backgroundColor = [UIColor yellowColor]; //とりあえず背景黄色に
        meishi = m;
        
        // 画面の縦横を取得
        CGRect screen_rect = [UIScreen mainScreen].applicationFrame;
        int w = screen_rect.size.width;
        int h = screen_rect.size.height;
        self.frame = CGRectMake(0, 0, w, h-56-52);
        
        // タイトルバー(名前)
        title.text = [meishi getName];
        title.frame = CGRectMake(-5, 4, 310, 40);
        [self addSubview:title];
        
        // 戻るボタン
        backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        backbutton.frame = CGRectMake(-6, 6, 70, 36);
        backbutton.titleLabel.font = [UIFont fontWithName:@"mikachan_o" size:16];
        backbutton.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:1.0 alpha:0.8];
        [backbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backbutton setTitle:@"〈戻る" forState:UIControlStateNormal];
        [backbutton addTarget:self action:@selector(close:)forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backbutton];
        
        /*
        UILabel *space1 = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 1, 30)];
        space1.backgroundColor = [UIColor whiteColor];
        [self addSubview:space1];
         */
        
        if(_fire_button){
            [self addSubview:_fire_button];
            /*
            UILabel *space2 = [[UILabel alloc] initWithFrame:CGRectMake(249, 10, 1, 30)];
            space2.backgroundColor = [UIColor whiteColor];
            [self addSubview:space2];
             */
        }
        
        int yposition = 46;
        
        // イメージ画像
        NSLog(@"イメージ画像");
        UIImageView *imageview = [meishi getCenterImage];
        imageview.frame = CGRectMake(40, yposition, 48, 72);
        [self addSubview:imageview];
        
        yposition += 8;
        // 役職
        UILabel *bg_label = [[UILabel alloc] initWithFrame:CGRectMake(120, yposition, 180, 20)];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        UILabel *joblabel = [[UILabel alloc] initWithFrame:CGRectMake(125, yposition, 155, 20)];
        [joblabel setText:[meishi getJobString]];
        [self addSubview:joblabel];
        yposition += 21;
        yposition += 1;
        
        // レベル
        
        bg_label = [[UILabel alloc] initWithFrame:CGRectMake(120, yposition, 180, 20)];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        CGRect dark_bg_rect = bg_label.frame;
        dark_bg_rect.size.width = (int)(([meishi getLv]/50.0)*dark_bg_rect.size.width);
        bg_label = [[UILabel alloc] initWithFrame:dark_bg_rect];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        NSLog(@"レベル");
        UILabel *lvlabel = [[UILabel alloc] initWithFrame:CGRectMake(125, yposition, 155, 20)];
        [lvlabel setText:[NSString stringWithFormat:@"Lv %d", [meishi getLv]]];
        [self addSubview:lvlabel];
        yposition += 21;
        yposition += 1;
        
        // 経験値

        //
        NSLog(@"経験値");
        bg_label = [[UILabel alloc] initWithFrame:CGRectMake(120, yposition, 180, 20)];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        dark_bg_rect = bg_label.frame;
        dark_bg_rect.size.width = (int)(([meishi getExp]/(float)[meishi getNextExp])*dark_bg_rect.size.width);
        bg_label = [[UILabel alloc] initWithFrame:dark_bg_rect];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        
        UILabel *exp_label = [[UILabel alloc] initWithFrame:CGRectMake(125, yposition, 155, 20)];
        exp_label.text = [NSString stringWithFormat:@"Exp　%d/%d", [meishi getExp], [meishi getNextExp]];
        [self addSubview:exp_label];
        yposition += 21;
        yposition += 1;
        
        
        // 各種能力値
        // NSLog(@"能力値");
        int x = 20;
        int status_w = 139;
        // HP bg
        bg_label = [[UILabel alloc] initWithFrame:CGRectMake(x, yposition, status_w, 20)];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        // 取得してラベルの長さ決める
        dark_bg_rect = bg_label.frame;
        dark_bg_rect.size.width = (int)(([meishi getH]/400.0)*dark_bg_rect.size.width);
        bg_label = [[UILabel alloc] initWithFrame:dark_bg_rect];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        // hp index
        UILabel *h_label = [[UILabel alloc] initWithFrame:CGRectMake(x+5, yposition, status_w -30, 20)];
        [h_label setText:@"HP"];
        [self addSubview:h_label];
        // HP value
        UILabel *hv_label = [[UILabel alloc] initWithFrame:CGRectMake(x+5, yposition, status_w -30, 20)];
        [hv_label setText:[meishi getHString]];
        hv_label.textAlignment = NSTextAlignmentRight;
        [self addSubview:hv_label];
        yposition += 21;
        
        // a bg
        bg_label = [[UILabel alloc] initWithFrame:CGRectMake(x, yposition, status_w, 20)];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        dark_bg_rect = bg_label.frame;
        dark_bg_rect.size.width = (int)(([meishi getA]/400.0)*dark_bg_rect.size.width);
        bg_label = [[UILabel alloc] initWithFrame:dark_bg_rect];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        // A index
        UILabel *a_label = [[UILabel alloc] initWithFrame:CGRectMake(x+5, yposition, status_w -30, 20)];
        [a_label setText:@"攻撃"];
        [self addSubview:a_label];
        // A value
        UILabel *alabel = [[UILabel alloc] initWithFrame:CGRectMake(x+5, yposition, status_w -30, 20)];
        [alabel setText:[meishi getAString]];
        alabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:alabel];
        yposition += 21;
        
        // B bg
        bg_label = [[UILabel alloc] initWithFrame:CGRectMake(x, yposition, status_w, 20)];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        dark_bg_rect = bg_label.frame;
        dark_bg_rect.size.width = (int)(([meishi getB]/400.0)*dark_bg_rect.size.width);
        bg_label = [[UILabel alloc] initWithFrame:dark_bg_rect];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        // B index
        UILabel *b_label = [[UILabel alloc] initWithFrame:CGRectMake(x+5, yposition, status_w -30, 20)];
        [b_label setText:@"防御"];
        [self addSubview:b_label];
        // B value
        UILabel *blabel = [[UILabel alloc] initWithFrame:CGRectMake(x+5, yposition, status_w -30, 20)];
        [blabel setText:[meishi getBString]];
        blabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:blabel];
        yposition += 21;
        
        x = 160;
        
        bg_label = [[UILabel alloc] initWithFrame:CGRectMake(x, h_label.frame.origin.y, status_w, 20)];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        dark_bg_rect = bg_label.frame;
        dark_bg_rect.size.width = (int)(([meishi getC]/400.0)*dark_bg_rect.size.width);
        bg_label = [[UILabel alloc] initWithFrame:dark_bg_rect];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        // C index
        UILabel *cilabel = [[UILabel alloc] initWithFrame:CGRectMake(x+5, h_label.frame.origin.y, status_w -30, 20)];
        [cilabel setText:@"魔攻"];
        [self addSubview:cilabel];
        // C value
        UILabel *clabel = [[UILabel alloc] initWithFrame:CGRectMake(x+5, h_label.frame.origin.y, status_w -30, 20)];
        [clabel setText:[meishi getCString]];
        clabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:clabel];
        
        
        bg_label = [[UILabel alloc] initWithFrame:CGRectMake(x, a_label.frame.origin.y, status_w, 20)];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        dark_bg_rect = bg_label.frame;
        dark_bg_rect.size.width = (int)(([meishi getD]/400.0)*dark_bg_rect.size.width);
        bg_label = [[UILabel alloc] initWithFrame:dark_bg_rect];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        // D index
        UILabel *dilabel = [[UILabel alloc] initWithFrame:CGRectMake(x+5, a_label.frame.origin.y, status_w -30, 20)];
        [dilabel setText:@"魔防"];
        [self addSubview:dilabel];
        // D value
        UILabel *dlabel = [[UILabel alloc] initWithFrame:CGRectMake(x+5, a_label.frame.origin.y, status_w -30, 20)];
        [dlabel setText:[meishi getDString]];
        dlabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:dlabel];
        
        bg_label = [[UILabel alloc] initWithFrame:CGRectMake(x, b_label.frame.origin.y, status_w, 20)];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        dark_bg_rect = bg_label.frame;
        dark_bg_rect.size.width = (int)(([meishi getS]/400.0)*dark_bg_rect.size.width);
        bg_label = [[UILabel alloc] initWithFrame:dark_bg_rect];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        // S index
        UILabel *silabel = [[UILabel alloc] initWithFrame:CGRectMake(x+5, b_label.frame.origin.y, status_w -30, 20)];
        [silabel setText:@"素早さ"];
        [self addSubview:silabel];
        // S value
        UILabel *slabel = [[UILabel alloc] initWithFrame:CGRectMake(x+5, b_label.frame.origin.y, status_w -30, 20)];
        [slabel setText:[meishi getSString]];
        slabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:slabel];
        
        // 特殊能力
        bg_label = [[UILabel alloc] initWithFrame:CGRectMake(20, yposition, 280, 20)];
        bg_label.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.5];
        [self addSubview:bg_label];
        UILabel *ablabel = [[UILabel alloc] initWithFrame:CGRectMake(25, yposition, 270, 20)];
        ablabel.text = [NSString stringWithFormat:@"特殊能力: %@", [meishi getAbilityString]];
        [self addSubview:ablabel];
        yposition += 20;
        
        bg_label = [[UILabel alloc] initWithFrame:CGRectMake(20, yposition, 280, 40)];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        UILabel *abl_desc_label = [[UILabel alloc] initWithFrame:CGRectMake(25, yposition, 270, 40)];
        abl_desc_label.text = [meishi getAbilityDescString];
        abl_desc_label.font = [UIFont systemFontOfSize:14];
        abl_desc_label.numberOfLines = 2;
        [self addSubview:abl_desc_label];
        yposition += 41;
        // 性格
        /*
        UILabel *natlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 245, 280, 20)];
        natlabel.text = @"ほげほげな性格";
        [self addSubview:natlabel];
         */
        
        // 経歴
        bg_label = [[UILabel alloc] initWithFrame:CGRectMake(20, yposition, 280, 100)];
        bg_label.backgroundColor = back_color;
        [self addSubview:bg_label];
        UILabel *hislabel = [[UILabel alloc] initWithFrame:CGRectMake(25, yposition, 270, 100)];
        hislabel.numberOfLines = 6;
        hislabel.font = [UIFont systemFontOfSize:13];
        hislabel.text = meishi.history;
        [self addSubview:hislabel];

    }
    return self;
}

// ウィンドウを閉じるやつ
- (void)close:(id)sender{
    [self removeFromSuperview];
}

// 戻るボタンを削除するやつ
- (void)removeBackButton{
    [backbutton removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
