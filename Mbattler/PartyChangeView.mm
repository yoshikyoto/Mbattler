//
//  PartyChangeView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/07/14.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "PartyChangeView.h"

@implementation PartyChangeView

// initialization --------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 「HP」とか表示する部分の初期化まとめて
        // [self initStatusLabel];
        self.frame = CGRectMake(10, 80, 300, 250);
        // 影をつける
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);  //影の方向
        self.layer.shadowOpacity = 0.7f; // 影の透明度
        self.layer.shadowColor = [UIColor blackColor].CGColor;   // 影の色
        self.layer.shadowRadius = 2.0f;  // ぼかし
        self.backgroundColor = [UIColor colorWithRed:1.0 green:0.95 blue:0.8 alpha:0.9];
        
        // 各種初期化
        UILabel *out_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        out_label.font = [UIFont fontWithName:@"mikachan_o" size:16];
        out_label.text = @"Out";
        out_label.textColor = [UIColor whiteColor];
        out_label.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.5];
        out_label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:out_label];
        
        UILabel *out_back_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
        out_back_label.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.2];
        [self addSubview:out_back_label];
        
        p_name_label = [[UILabel alloc] initWithFrame:CGRectMake(60, 2, 80, 30)];
        p_name_label.font = [UIFont systemFontOfSize:16];
        pjob = [[UILabel alloc] initWithFrame:CGRectMake(150, 2, 70, 30)];
        pjob.font = [UIFont systemFontOfSize:16];
        plv = [[UILabel alloc] initWithFrame:CGRectMake(230, 2, 70, 30)];
        plv.font = [UIFont systemFontOfSize:16];
        
        ph = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, 70, 14)];
        ph.font = [UIFont systemFontOfSize:14];
        ph.text = @"HP";
        phv = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, 70, 14)];
        phv.font = [UIFont systemFontOfSize:14];
        phv.textAlignment = NSTextAlignmentRight;
        
        pa = [[UILabel alloc] initWithFrame:CGRectMake(80, 46, 70, 14)];
        pa.font = [UIFont systemFontOfSize:14];
        pa.text = @"攻撃";
        pav = [[UILabel alloc] initWithFrame:CGRectMake(80, 46, 70, 14)];
        pav.font = [UIFont systemFontOfSize:14];
        pav.textAlignment = NSTextAlignmentRight;
        
        pb = [[UILabel alloc] initWithFrame:CGRectMake(80, 62, 70, 14)];
        pb.font = [UIFont systemFontOfSize:14];
        pb.text = @"防御";
        pbv = [[UILabel alloc] initWithFrame:CGRectMake(80, 62, 70, 14)];
        pbv.font = [UIFont systemFontOfSize:14];
        pbv.textAlignment = NSTextAlignmentRight;
        
        pc = [[UILabel alloc] initWithFrame:CGRectMake(170, 30, 70, 14)];
        pc.font = [UIFont systemFontOfSize:14];
        pc.text = @"魔攻";
        pcv = [[UILabel alloc] initWithFrame:CGRectMake(170, 30, 70, 14)];
        pcv.font = [UIFont systemFontOfSize:14];
        pcv.textAlignment = NSTextAlignmentRight;
        
        pd = [[UILabel alloc] initWithFrame:CGRectMake(170, 46, 70, 14)];
        pd.font = [UIFont systemFontOfSize:14];
        pd.text = @"魔防";
        pdv = [[UILabel alloc] initWithFrame:CGRectMake(170, 46, 70, 14)];
        pdv.font = [UIFont systemFontOfSize:14];
        pdv.textAlignment = NSTextAlignmentRight;
        
        ps = [[UILabel alloc] initWithFrame:CGRectMake(170, 62, 70, 14)];
        ps.font = [UIFont systemFontOfSize:14];
        ps.text = @"素早さ";
        psv = [[UILabel alloc] initWithFrame:CGRectMake(170, 62, 70, 14)];
        psv.font = [UIFont systemFontOfSize:14];
        psv.textAlignment = NSTextAlignmentRight;
        
        pabl = [[UILabel alloc] initWithFrame:CGRectMake(70, 76, 200, 20)];
        pabl.font = [UIFont systemFontOfSize:14];
        
        UILabel *in_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 50, 30)];
        in_label.text = @"In";
        in_label.font = [UIFont fontWithName:@"mikachan_o" size:16];
        in_label.textColor = [UIColor whiteColor];
        in_label.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.5];
        in_label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:in_label];
        
        UILabel *in_back_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 300, 30)];
        in_back_label.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.2];
        [self addSubview:in_back_label];
        
        r_name_label = [[UILabel alloc] initWithFrame:CGRectMake(60, 102, 80, 30)];
        r_name_label.font = [UIFont systemFontOfSize:16];
        rjob = [[UILabel alloc] initWithFrame:CGRectMake(150, 102, 70, 30)];
        rjob.font = [UIFont systemFontOfSize:16];
        rlv = [[UILabel alloc] initWithFrame:CGRectMake(230, 102, 70, 30)];
        rlv.font = [UIFont systemFontOfSize:16];
        
        rh = [[UILabel alloc] initWithFrame:CGRectMake(80, 130, 70, 14)];
        rh.font = [UIFont systemFontOfSize:14];
        rh.text = @"HP";
        rhv = [[UILabel alloc] initWithFrame:CGRectMake(80, 130, 70, 14)];
        rhv.font = [UIFont systemFontOfSize:14];
        rhv.textAlignment = NSTextAlignmentRight;
        
        ra = [[UILabel alloc] initWithFrame:CGRectMake(80, 146, 70, 14)];
        ra.font = [UIFont systemFontOfSize:14];
        ra.text = @"攻撃";
        rav = [[UILabel alloc] initWithFrame:CGRectMake(80, 146, 70, 14)];
        rav.font = [UIFont systemFontOfSize:14];
        rav.textAlignment = NSTextAlignmentRight;
        
        rb = [[UILabel alloc] initWithFrame:CGRectMake(80, 162, 70, 14)];
        rb.font = [UIFont systemFontOfSize:14];
        rb.text = @"防御";
        rbv = [[UILabel alloc] initWithFrame:CGRectMake(80, 162, 70, 14)];
        rbv.font = [UIFont systemFontOfSize:14];
        rbv.textAlignment = NSTextAlignmentRight;
        
        rc = [[UILabel alloc] initWithFrame:CGRectMake(170, 130, 70, 14)];
        rc.font = [UIFont systemFontOfSize:14];
        rc.text = @"魔攻";
        rcv = [[UILabel alloc] initWithFrame:CGRectMake(170, 130, 70, 14)];
        rcv.font = [UIFont systemFontOfSize:14];
        rcv.textAlignment = NSTextAlignmentRight;
        
        rd = [[UILabel alloc] initWithFrame:CGRectMake(170, 146, 70, 14)];
        rd.font = [UIFont systemFontOfSize:14];
        rd.text = @"魔防";
        rdv = [[UILabel alloc] initWithFrame:CGRectMake(170, 146, 70, 14)];
        rdv.font = [UIFont systemFontOfSize:14];
        rdv.textAlignment = NSTextAlignmentRight;
        
        rs = [[UILabel alloc] initWithFrame:CGRectMake(170, 162, 70, 14)];
        rs.font = [UIFont systemFontOfSize:14];
        rs.text = @"素早さ";
        rsv = [[UILabel alloc] initWithFrame:CGRectMake(170, 162, 70, 14)];
        rsv.font = [UIFont systemFontOfSize:14];
        rsv.textAlignment = NSTextAlignmentRight;
        
        rabl = [[UILabel alloc] initWithFrame:CGRectMake(70, 176, 200, 20)];
        rabl.font = [UIFont systemFontOfSize:14];
        
        UILabel *message_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, 150, 40)];
        message_label.text = @"よろしいですか？";
        message_label.font = [UIFont fontWithName:@"mikachan_o" size:16];
        message_label.textAlignment = NSTextAlignmentCenter;
        message_label.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.5];
        message_label.textColor = [UIColor whiteColor];
        [self addSubview:message_label];
    }
    return self;
}


- (void)setPartyMember:(Meishi *)meishi{
    NSLog(@"%s", __func__);
    if(meishi){
        NSLog(@"%s キャラが選択された", __func__);
        // 画像
        [p_image removeFromSuperview];
        p_image = [meishi getCenterImage];
        p_image.frame = CGRectMake(20, 30, 32, 48);
        [self addSubview:p_image];
        
        // 名前
        p_name_label.text = [meishi getName];
        [self addSubview:p_name_label];
        // 職業
        pjob.text = [meishi getJobString];
        [self addSubview:pjob];
        // レベル
        plv.text = [NSString stringWithFormat:@"Lv %d", [meishi getLv]];
        [self addSubview:plv];
        // ステータス
        [self addSubview:ph];
        [self addSubview:pa];
        [self addSubview:pb];
        [self addSubview:pc];
        [self addSubview:pd];
        [self addSubview:ps];
        phv.text = [NSString stringWithFormat:@"%d", [meishi getH]];
        [self addSubview:phv];
        pav.text = [NSString stringWithFormat:@"%d", [meishi getA]];
        [self addSubview:pav];
        pbv.text = [NSString stringWithFormat:@"%d", [meishi getB]];
        [self addSubview:pbv];
        pcv.text = [NSString stringWithFormat:@"%d", [meishi getC]];
        [self addSubview:pcv];
        pdv.text = [NSString stringWithFormat:@"%d", [meishi getD]];
        [self addSubview:pdv];
        psv.text = [NSString stringWithFormat:@"%d", [meishi getS]];
        [self addSubview:psv];
        
        pabl.text = [NSString stringWithFormat:@"特殊能力: %@", [meishi getAbilityString]];
        [self addSubview:pabl];
    }else{
        // 入れる
        NSLog(@"%s はずすが選択された", __func__);
        p_name_label.text = @"なし";
        [self addSubview:p_name_label];
        [p_image removeFromSuperview];
        [pjob removeFromSuperview];
        [plv removeFromSuperview];
        [ph removeFromSuperview];
        [pa removeFromSuperview];
        [pb removeFromSuperview];
        [pc removeFromSuperview];
        [pd removeFromSuperview];
        [ps removeFromSuperview];
        [phv removeFromSuperview];
        [pav removeFromSuperview];
        [pbv removeFromSuperview];
        [pcv removeFromSuperview];
        [pdv removeFromSuperview];
        [psv removeFromSuperview];
        [pabl removeFromSuperview];
    }
}

- (void)setReserveMember:(Meishi *)meishi{
    NSLog(@"%s", __func__);
    if(meishi){
        NSLog(@"%s キャラが選択された", __func__);
        // 画像
        [r_image removeFromSuperview];
        r_image = [meishi getCenterImage];
        r_image.frame = CGRectMake(20, 130, 32, 48);
        [self addSubview:r_image];
        
        // 名前
        r_name_label.text = [meishi getName];
        [self addSubview:r_name_label];
        // 職業
        rjob.text = [meishi getJobString];
        [self addSubview:rjob];
        // レベル
        rlv.text = [NSString stringWithFormat:@"Lv %d", [meishi getLv]];
        [self addSubview:rlv];
        // ステータス
        [self addSubview:rh];
        [self addSubview:ra];
        [self addSubview:rb];
        [self addSubview:rc];
        [self addSubview:rd];
        [self addSubview:rs];
        rhv.text = [NSString stringWithFormat:@"%d", [meishi getH]];
        [self addSubview:rhv];
        rav.text = [NSString stringWithFormat:@"%d", [meishi getA]];
        [self addSubview:rav];
        rbv.text = [NSString stringWithFormat:@"%d", [meishi getB]];
        [self addSubview:rbv];
        rcv.text = [NSString stringWithFormat:@"%d", [meishi getC]];
        [self addSubview:rcv];
        rdv.text = [NSString stringWithFormat:@"%d", [meishi getD]];
        [self addSubview:rdv];
        rsv.text = [NSString stringWithFormat:@"%d", [meishi getS]];
        [self addSubview:rsv];
        
        rabl.text = [NSString stringWithFormat:@"特殊能力: %@", [meishi getAbilityString]];
        [self addSubview:rabl];
    }else{
        // 入れる
        NSLog(@"%s はずすが選択された", __func__);
        r_name_label.text = @"なし";
        [self addSubview:r_name_label];
        [r_image removeFromSuperview];
        [rjob removeFromSuperview];
        [rlv removeFromSuperview];
        [rh removeFromSuperview];
        [ra removeFromSuperview];
        [rb removeFromSuperview];
        [rc removeFromSuperview];
        [rd removeFromSuperview];
        [rs removeFromSuperview];
        [rhv removeFromSuperview];
        [rav removeFromSuperview];
        [rbv removeFromSuperview];
        [rcv removeFromSuperview];
        [rdv removeFromSuperview];
        [rsv removeFromSuperview];
        [rabl removeFromSuperview];
    }
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
