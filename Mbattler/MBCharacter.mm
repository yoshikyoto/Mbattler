//
//  MBCharacter.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/06/02.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBCharacter.h"
#import "MBAnimationView.h"

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
    }
    return self;
}

// ゲッター
- (NSString *) getName{
    return name;
}
- (int) getH{ return p[0]; }
- (int) getA{ return p[1]; }
- (int) getB{ return p[2]; }
- (int) getC{ return p[3]; }
- (int) getD{ return p[4]; }
- (int) getS{ return p[5]; }
- (int) getNowH{ return nowh; }

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
    if(nowh <= damage){
        damage = nowh;
        nowh = 0;
    }else{
        nowh = nowh - damage;
    }
    return damage;
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


@end
