//
//  MBCharacter.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/06/02.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBCharacter.h"
#import "MBAnimationView.h"
#import "DamageValueLabel.h"

@implementation MBCharacter
- (id)init{
    self = [super init];
    if(self){
        // 初期化処理
        // デフォのエフェクト
        effect = [[MBAnimationView alloc] init];
        [effect setAnimationImage:@"pu.png" :120 :120 :9];
        effect.animationDuration = 0.5;
        effect.animationRepeatCount = 1;
        // パラメータ補正値の初期化
        p_mult[0] = 1.0;
        p_mult[1] = 1.0;
        p_mult[2] = 1.0;
        p_mult[3] = 1.0;
        p_mult[4] = 1.0;
        p_mult[5] = 1.0;
        // 上昇、下降
    }
    return self;
}

// ゲッター
- (NSString *) getName{
    return name;
}
- (int) getH{ return p[0] * p_mult[0]; }
- (int) getA{ return p[1] * p_mult[1]; }
- (int) getB{ return p[2] * p_mult[2]; }
- (int) getC{ return p[3] * p_mult[3]; }
- (int) getD{ return p[4] * p_mult[4]; }
- (int) getS{ return p[5] * p_mult[5]; }
- (int) getNowH{ return nowh; }
- (int) getHMult{ return p_mult[0]; }
- (int) getAMult{ return p_mult[1]; }
- (int) getBMult{ return p_mult[2]; }
- (int) getCMult{ return p_mult[3]; }
- (int) getDMult{ return p_mult[4]; }
- (int) getSMult{ return p_mult[5]; }

- (MBAnimationView *)getEffect{
    return effect;
}

// セッター
- (void)setName:(NSString *)n{
    name = n;
}


- (Boolean)isDead{
    if(nowh == 0)
        return true;
    else{
        return false;
    }
}

- (UIImageView *)getHpBar:(int)x :(int)y{
    hpbar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hp1.png"]];
    hpbar.frame = CGRectMake(x, y, 32, 5);
    return hpbar;
}

// ダメージ受ける関数
- (int)damage:(int)damage{
    // HPが0にならないようにマイナス
    UIImageView *view = [self getBattleImage];
    CGRect rect = view.frame;
    int x = rect.origin.x; // + rect.size.width // 2.0;
    int y = rect.origin.y + rect.size.height / 2.0;
    DamageValueLabel *dl = [[DamageValueLabel alloc] init];
    dl.text = [NSString stringWithFormat:@"%3.0d", damage];
    dl.center = CGPointMake(x, y);
    //dl.textAlignment = NSTextAlignmentCenter;
    dl.textColor = [UIColor whiteColor];
    [[view superview] addSubview:dl];
    [dl startAnimation];

    if(nowh <= damage){
        nowh = 0;
    }else{
        nowh = nowh - damage;
    }
    return damage;
}

// 画像除去する関数
- (void)removeBattleImage{
    [[self getBattleImage] removeFromSuperview];
    if(downView) [downView removeFromSuperview];
    if(upView) [upView removeFromSuperview];
}

// ステータス補正
- (void)multParameter:(int)position :(float)mult{
    p_mult[position] += mult;
    NSLog(@"%s 倍率 %f", __func__, p_mult[position]);
    BOOL up_flag = false;
    BOOL down_flag = false;
    for(int k = 0; k < 6; k++){
        if(p_mult[k] >= 1.05) up_flag = true;
        if(p_mult[k] <= 0.95) down_flag = true;
    }
    
    if(up_flag){
        // 上昇してる能力がある場合
        NSLog(@"%s 上昇している能力があります", __func__);
        if(!upView){
            // もしupアイコンが初期化されていなかったら初期化
            // アイコン初期化とアニメーションのスタート
            upView = [[MBAnimationView alloc] init];
            [upView setAnimationImage:@"up.png" :120 :120 :10];
            upView.animationRepeatCount = 0;
            upView.animationDuration = 1.0;
        }
        // アイコン表示座標の取得 キャラの左に表示するようにする。
        CGRect rect = [self getBattleImage].frame;
        rect.origin.x -= 10; //rect.size.width / 4.0;
        rect.origin.y += rect.size.height - 30;
        rect.size.width = 30;
        rect.size.height = 30;
        upView.frame = rect;
        // アニメーションスタート
        [upView startAnimating];
        [[[self getBattleImage] superview] addSubview:upView];
    }else{
        // 上昇してる能力が無い or なくなった場合
        if(upView){
            [upView removeFromSuperview];
        }
    }
    
    if(down_flag) {
        // 下がっている能力がある場合
        NSLog(@"%s 下降している能力があります", __func__);
        if(!downView){
            // もしdownアイコンが初期化されていなかったら初期化
            // アイコン初期化とアニメーションのスタート
            downView = [[MBAnimationView alloc] init];
            [downView setAnimationImage:@"down.png" :120 :120 :10];
            downView.animationRepeatCount = 0;
            downView.animationDuration = 1.0;
        }
        // アイコン表示座標の取得 こっちはちょっと右に表示するようにする。
        CGRect rect = [self getBattleImage].frame;
        rect.origin.x += rect.size.width -20;
        rect.origin.y += rect.size.height - 30;
        rect.size.width = 30;
        rect.size.height = 30;
        downView.frame = rect;
        [downView startAnimating];
        [[[self getBattleImage] superview] addSubview:downView];
    }else{
        // 下降してる能力が無い or なくなった場合
        if(downView){
            [downView removeFromSuperview];
        }
    }  
}

- (void)drawHpBar{
    if(hpbar){ // HPバーがインスタンスとして生成されてる場合だけ
        int x = hpbar.frame.origin.x;
        int y = hpbar.frame.origin.y;
        int w = 32 * ((float)nowh / p[0]);
        NSLog(@"nowh/h = %d/%d", nowh, p[0]);
        NSLog(@"HpBar width %d", w);
        // 0じゃないときに長さ0にならないように
        if((w == 0)&&(nowh != 0)) w = 1;
        hpbar.frame = CGRectMake(x, y, w, 5);
    }
}

- (int)damageRand:(int)damage{
    // 乱数を生成してダメージ計算(100% - 90%)
    int r = arc4random()%10;
    r = 100 - r;
    damage = damage * (r/100.0);
    // ダメージは0にはならない
    if(damage <= 0) damage = 1;
    return damage;
}


@end
