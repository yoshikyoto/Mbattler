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

- (id)initWithMeishi:(Meishi *)meishi
{
    self = [super initWithPlayer:nil];
    if (self) {
        // Initialization code
        //self.backgroundColor = [UIColor yellowColor]; //とりあえず背景黄色に
        
        // 画面の縦横を取得
        CGRect screen_rect = [UIScreen mainScreen].applicationFrame;
        int w = screen_rect.size.width;
        int h = screen_rect.size.height;
        self.frame = CGRectMake(0, 0, w, h-56-52);
        
        // タイトルバー(名前)
        title.text = [meishi getName];
        [self addSubview:title];
        
        // 戻るボタン
        backbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        backbutton.frame = CGRectMake(20, 5, 50, 32);
        [backbutton setTitle:@"戻る" forState:UIControlStateNormal];
        [backbutton addTarget:self action:@selector(close:)forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backbutton];
        
        // イメージ画像
        NSLog(@"イメージ画像");
        UIImageView *imageview = [meishi getCenterImage];
        imageview.frame = CGRectMake(40, 40, 48, 72);
        [self addSubview:imageview];
        
        // 役職
        NSLog(@"役職");
        UILabel *joblabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 45, 100, 20)];
        [joblabel setText:[meishi getJobString]];
        [self addSubview:joblabel];
        
        // レベル
        NSLog(@"レベル");
        UILabel *lvlabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 65, 100, 20)];
        [lvlabel setText:[NSString stringWithFormat:@"Lv %@", [meishi getLvString]]];
        [self addSubview:lvlabel];
        
        // 経験値
        NSLog(@"経験値");
        UILabel *explabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 85, 200, 20)];
        explabel.text = [NSString stringWithFormat:@"Exp　%d/%d", [meishi getExp], [meishi getNextExp]];
        [self addSubview:explabel];
        
        
        // 各種能力値
        NSLog(@"能力値");
        // HP index
        UILabel *hilabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 115, 64, 20)];
        [hilabel setText:@"HP"];
        [self addSubview:hilabel];
        // HP value
        UILabel *hlabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 115, 40, 20)];
        [hlabel setText:[meishi getHString]];
        hlabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:hlabel];
        
        // A index
        UILabel *ailabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 135, 64, 20)];
        [ailabel setText:@"攻撃"];
        [self addSubview:ailabel];
        // A value
        UILabel *alabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 135, 40, 20)];
        [alabel setText:[meishi getAString]];
        alabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:alabel];
        
        // B index
        UILabel *bilabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 155, 64, 20)];
        [bilabel setText:@"防御"];
        [self addSubview:bilabel];
        // B value
        UILabel *blabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 155, 40, 20)];
        [blabel setText:[meishi getBString]];
        blabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:blabel];
        
        // C index
        UILabel *cilabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 115, 64, 20)];
        [cilabel setText:@"魔攻"];
        [self addSubview:cilabel];
        // C value
        UILabel *clabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 115, 40, 20)];
        [clabel setText:[meishi getCString]];
        clabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:clabel];
        
        // D index
        UILabel *dilabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 135, 64, 20)];
        [dilabel setText:@"魔防"];
        [self addSubview:dilabel];
        // D value
        UILabel *dlabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 135, 40, 20)];
        [dlabel setText:[meishi getDString]];
        dlabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:dlabel];
        
        // S index
        UILabel *silabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 155, 64, 20)];
        [silabel setText:@"素早さ"];
        [self addSubview:silabel];
        // S value
        UILabel *slabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 155, 40, 20)];
        [slabel setText:[meishi getSString]];
        slabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:slabel];
        
        // 特殊能力
        UILabel *ablabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 280, 20)];
        ablabel.text = @"特殊能力　ほげほげ";
        [self addSubview:ablabel];
        
        
        UILabel *ablabel2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, 280, 40)];
        ablabel2.text = @"ここに特殊能力の説明が入ります";
        ablabel2.numberOfLines = 2;
        [self addSubview:ablabel2];
        
        // 性格
        UILabel *natlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 245, 280, 20)];
        natlabel.text = @"ほげほげな性格";
        [self addSubview:natlabel];
        
        // 経歴
        UILabel *hislabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 265, 280, 80)];
        hislabel.numberOfLines = 5;
        hislabel.font = [UIFont systemFontOfSize:12];
        hislabel.text = [meishi getHistory];
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