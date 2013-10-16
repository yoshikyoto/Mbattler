//
//  Player.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/04/12.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "Player.h"
#import "Meishi.h"
#import "MBDatabase.h"

@implementation Player

- (id)init{
    self = [super init];
    if(self){
        // 初期化
        NSLog(@"%s Player init", __func__);
        meishis = [[NSMutableArray alloc] init];
        // 持てる名刺の最大数は、仮の初期値 20 にしておく。
        maxmeishi = 20;
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
        
        // パーティの数は1としておく
        partynum = 1;
        
        ud = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (id)initWithInitializeData{
    self = [self init];
    if(self){
        
    }
    return self;
}

- (id)initWithTestdata{
    self = [self init];
    if(self){
        NSLog(@"%s", __func__);
        for(int i = 0; i < 22; i++){
            NSLog(@"%s %d", __func__, i);
            Meishi *m = [[Meishi alloc] init];
            [m setName:[NSString stringWithFormat:@"坂本%d", i]];
            [m setLv:15];
            //[m setImageNum:i%8];
            [m setSex:rand()%2];
            [m setJob: i%4];
            int ind[6] = {rand()%32, rand()%32, rand()%32, rand()%32, rand()%32, rand()%32};
            [m setIndividual:ind];
            [m calcParameter];
            [m setExp:0];
            [m setAbility:i%22];
            [self addMeishi:m];
        }
        [self reflesh];
        name = @"TestData";
    }
    return self;
}

- (id)initWithName:(NSString *)n{
    self = [self init];
    if(self){
        // プレイヤーネームヨシキ
        name = n;
        stamina_date = [NSDate date];
        
        // 初期名刺
        Meishi *developer_meishi = [[Meishi alloc] initWithInformation:@"坂本祥之" CompanyName:@"京都大学大学院情報学研究科" Mail1:@"sakamoto" Mail2:@"db.soc.i.kyoto-u.ac.jp" Zip1:606 Zip2:8267 Sex:0];
        [developer_meishi setAbility:0]; // ギガインパクト
        [developer_meishi setHistory:[NSString stringWithFormat:@"京都の某大学にて大学生活を過ごす。学生の間は主にポケモンをして過ごし、4年で卒業。その後、大学院に行くが、研究に嫌気がさし、2013年4月1日、%@に転職する。転職1年目のかけだし。", [developer_meishi getJobString]]];
        [self addMeishi:developer_meishi];
        
        Meishi *meishi = [[Meishi alloc] initWithInformation:name CompanyName:@"名刺バトラー" Mail1:@"meishi" Mail2:@"battler" Zip1:000 Zip2:0000 Sex:0];
        [meishi setAbility:1]; // 破壊光線
        [self addMeishi:meishi];
    }
    return self;
}

// ゲームデーターロード用
- (id)initWithLoad{
    self = [self init];
    if(self){
        name = [ud stringForKey:@"PLAYER_NAME"];
        maxmeishi = [ud integerForKey:@"MAX_MEISHI"];
        partynum = [ud integerForKey:@"PARTY_NUM"];
        stamina = [ud integerForKey:@"STAMINA"];
        stamina_date = [ud objectForKey:@"STAMINA_DATE"];
        item[0] = [ud integerForKey:@"ITEM_0"];
        item[1] = [ud integerForKey:@"ITEM_1"];
        item[2] = [ud integerForKey:@"ITEM_2"];
        
        MBDatabase *mbdb = [[MBDatabase alloc] init];
        meishis = [mbdb loadAllMeishi];
    }
    return self;
}

// ゲームデータセーブ用----------------------------------------------------------------
- (void)save{
    // 全部の名刺をデータベースに保存
    MBDatabase *mbdb = [[MBDatabase alloc] init];
    for(int i = 0; i < [meishis count]; i++){
        [mbdb saveMeishi:i :[meishis objectAtIndex:i]];
    }
    // そのほかの情報はNSUserDefaultsに保存
    // 名刺の最大数
    [ud setInteger:maxmeishi forKey:@"MAX_MEISHI"];
    // 名刺所持数
    NSLog(@"%s 名刺所持数保存 %d", __func__, [self getNumOfMeishi]);
    [ud setInteger:[self getNumOfMeishi] forKey:@"MEISHI_NUM"];
    // パーティの所属数
    [ud setInteger:partynum forKey:@"PARTY_NUM"];
    // stamina_date
    [ud setObject:stamina_date forKey:@"STAMINA_DATE"];
    [self saveStamina]; // スタミナ
    
    // アイテムの所持数セーブ
    [self saveItem];
    
    // 最後に自分の名前を保存
    [ud setObject:name forKey:@"PLAYER_NAME"];
    [ud synchronize];
}

- (void)saveItem{
    // アイテムの所持数
    [ud setInteger:item[0] forKey:@"ITEM_0"];
    [ud setInteger:item[1] forKey:@"ITEM_1"];
    [ud setInteger:item[2] forKey:@"ITEM_2"];
    [ud synchronize];
}

// スタミナ
- (void)saveStamina{
    // スタミナ
    [ud setInteger:stamina forKey:@"STAMINA"];
    [ud setObject:stamina_date forKey:@"STAMINA_DATE"];
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

- (void)addMeishi:(Meishi *)m{
    [meishis addObject:m];
    // 名刺が一杯の場合を考慮しなければならない
}


- (void)removeMeishiAtIndex:(int)index{
    [meishis removeObjectAtIndex:index];
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
    return [meishis count];
}

// 個々の名刺のリフレッシュオブジェクトを呼ぶ
- (void)reflesh{
    for(int i = 0; i < [meishis count]; i++){
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
    return [meishis count] >= maxmeishi;
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

- (Boolean)haveStamina:(int)s{
    if(s > stamina){
        return false;
    }else{
        return true;
    }
}

- (Boolean)minusStaimna:(int)s{
    if(s > stamina) return false;
    if(stamina == 50){
        stamina_date = [NSDate date];
    }
    stamina -= s;
    [self reCalcStamina];
    [self saveStamina];
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
    [self saveStamina];
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