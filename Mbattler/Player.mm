//
//  Player.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/04/12.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "Player.h"
#import "Meishi.h"

@implementation Player

- (id)init{
    self = [super init];
    if(self){
        NSLog(@"Player init");
        meishis = [[NSMutableArray alloc] init];
        // 持てる名刺の最大数は、仮の初期値 20 にしておく。
        maxmeishi = 20;
        num_of_meishi = 0;
        [self makeTestdata];
        [self reflesh];
        stamina = 50;
        // hpバー初期化だけしておく
        stamina_bar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hp1.png"]];
        // stamina_date に適当に時間を設定
        stamina_date = [NSDate date];
        stamina_timer = [NSTimer scheduledTimerWithTimeInterval:1
                                         target:self
                                       selector:@selector(calcStamina:)
                                       userInfo:nil
                                        repeats:true];
        // アイテムを1個ずつ持ってる状態を初期状態とする。
        item[0] = 1;
        item[1] = 1;
        item[2] = 1;
        
    }
    return self;
}

// i 番目の名刺を返す
- (Meishi *)getMeishi:(int)i{ return [meishis objectAtIndex:i]; }
// パーティの人数を返す
- (int)getPartynum{ return partynum; }

// パーティ配列を返す
- (NSMutableArray *)getParty{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(int i = 0; i < partynum; i++){
        [result addObject:[meishis objectAtIndex:i]];
    }
    return result;
}

// プレイヤーの名前取得
- (NSString *)getName{ return name; }

// デバッグ用のデータを作成
- (void)makeTestdata{
    Meishi *m;
    for(int i = 0; i < 30; i++){
        NSLog(@"%s %d", __func__, i);
        m = [[Meishi alloc] init];
        [m setName:[NSString stringWithFormat:@"坂本%d", i]];
        [m setLv:5];
        //[m setImageNum:i%8];
        [m setSex:rand()%2];
        [m setJob: i%4];
        int ind[6] = {rand()%32, rand()%32, rand()%32, rand()%32, rand()%32, rand()%32};
        [m setIndividual:ind];
        [m calcParameter];
        [m setExp:0];
        [m setAbility:rand()%22];
        [self addMeishi:m];
    }
    NSLog(@"num_of_meishi %d", num_of_meishi);
    // パーティの数は5としておく
    partynum = 5;
    // プレイヤーネームヨシキ
    name = @"ヨシキ";
}

- (void)addMeishi:(Meishi *)m{
    [meishis addObject:m];
    num_of_meishi++;
    // 名刺が一杯の場合を考慮しなければならない
}

// HPバー取得
- (UIImageView *)getStaminaBar:(int)x :(int)y{
    stamina_bar.frame = CGRectMake(x, y, stamina/50.0*250.0, 10);
    return stamina_bar;
}

// スタミナ取得
- (int)getStamina{ return stamina; };
- (UILabel *)getStaminaLabel{
    stamina_label = [[UILabel alloc] init];
    stamina_label.backgroundColor = [UIColor clearColor];
    stamina_label.font = [UIFont systemFontOfSize:12];
    stamina_label.textAlignment = NSTextAlignmentRight;
    stamina_label.text = [NSString stringWithFormat:@"%d/%d", stamina, 50];
    return stamina_label;
}

- (NSMutableArray *)getMeishis{
    return meishis;
}

- (int)getNumOfMeishi{
    return num_of_meishi;
}

// 個々の名刺のリフレッシュオブジェクトを呼ぶ
- (void)reflesh{
    for(int i = 0; i < num_of_meishi; i++){
        [[meishis objectAtIndex:i] reflesh];
    }
}

- (Boolean)isDead{
    for(int i = 0; i < [self getPartynum]; i++){
        if(![[self getMeishi:i] isDead]) return false;
    }
    return true;
}

// 名刺がいっぱいかどうか確認
- (Boolean)isMeishiFull{
    return num_of_meishi >= maxmeishi;
}

// パーティの数変更
- (void)setPartyNum:(int)n{
    partynum = n;
}

// パーティからはずす
- (int)removeFromParty:(int)n{
    if(partynum <= 1){
        // パーティが一人しかいないとき
        return 1;
    }else if(n > partynum){
        // 外そうとしているのがパーティに入っていないとき
        return 2;
    }else{
        // キャラをパーティの一番後ろに持ってきて
        [meishis exchangeObjectAtIndex:n withObjectAtIndex:partynum-1];
        // パーティの数をマイナス
        partynum--;
        return 0;
    }
}

// パーティに加える。
- (int)addParty:(int)n{
    if(partynum >= 5){
        // パーティが上限に達しているとき
        return 1;
    }else if(n < partynum){
        // すでにパーティに加わっているとき
        return 2;
    }else{
        // キャラをパーティのすぐ後ろに挿入する作業
        Meishi *m = [meishis objectAtIndex:n];
        [meishis removeObjectAtIndex:n];
        [meishis insertObject:m atIndex:partynum];
        // パーティの数をプラス
        partynum++;
        return 0;
    }
}

- (Boolean)minusStaimna:(int)s{
    if(s > stamina) return false;
    if(stamina == 50) stamina_date = [NSDate date];
    stamina -= s;
    [self reCalcStamina];
    return true;
}

- (void)calcStamina:(id)sender{
    int duration = [[NSDate date] timeIntervalSinceDate:stamina_date];
    if(duration >= 180){
        int recover_point = (int)(duration/180.0);
        stamina_date = [stamina_date initWithTimeInterval:recover_point*180 sinceDate:stamina_date];
        [self recoverStamina:recover_point];
    }
    //NSLog(@"スタミナ計算 %d", duration );
    [self reCalcStamina];
}

- (void)reCalcStamina{
    // これを呼び出すことでゲージを再計算
    [self getStaminaBar:stamina_bar.frame.origin.x :stamina_bar.frame.origin.y];
    // ラベルのテキストを書き直す処理も必要
    stamina_label.text = [NSString stringWithFormat:@"%d/%d", stamina, 50];
}

// スタミナ回復関数
- (Boolean)recoverStamina:(int)r{
    if(stamina == 50) return false;
    if(r == 0){
        stamina = 50;
    }else{
        stamina += r;
        if(stamina > 50) stamina = 50;
    }
    // ゲージを再計算させる
    [self reCalcStamina];
    return true;
}

- (int)getNumOfItem:(int)n{
    return item[n];
}

- (int)useItem:(int)n{
    item[n]--;
    return item[n];
}

- (int)buyItem:(int)n :(int)m{
    item[n] += m;
    return item[n];
}

@end