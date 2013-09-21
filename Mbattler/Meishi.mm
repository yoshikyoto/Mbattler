//
//  Meishi.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/03/12.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "Meishi.h"

// 名刺から生成されたキャラクター
@implementation Meishi
- (id)init{
    self = [super init];
    if(self){
        // 初期化処理
        lv = 0;
        ability = 0;
    }
    return self;
}

- (id)initWithInformation:(NSString *)_name CompanyName:(NSString*)_company Mail1:(NSString *)_mail1 Mail2:(NSString *)_mail2 Zip1:(int)_zip1 Zip2:(int)_zip2 Sex:(int)_sex{
    self = [super init];
    if(self){
        name = _name;
        company = _company;
        mail1 = _mail1;
        mail2 = _mail2;
        zip1 = _zip1;
        zip2 = _zip2;
        sex = _sex;
        
        // 名前の処理
        int name_length = [name length];
        NSLog(@"Name: %@, Length: %d", name, name_length);
        
        int name_int[2] = {0, 0};
        switch(name_length){
            case 0: // 名前の長さが0の場合個体値0
                break;
            case 1:
                name_int[0] = [name characterAtIndex:0];
                name_int[1] = [name characterAtIndex:0];
                break;
            default:
                for(int k = 0; k < name_length; k++){
                    if(k < name_length/2){
                        name_int[0] += [name characterAtIndex:k];
                    }else{
                        name_int[1] += [name characterAtIndex:k];
                    }
                }
                break;
        }
        NSLog(@"name_int[0]: %d, name_int[1]: %d", name_int[0], name_int[1]);
        
        // 会社名の処理
        int company_length = [company length];
        NSLog(@"company: %@, company_length: %d", company, company_length);
        
        int company_int[2] = {0, 0};
        switch(company_length){
            case 0:
                break;
            case 1:
                company_int[0] = [company characterAtIndex:0];
                company_int[1] = [company characterAtIndex:0];
            default:
                for(int k = 0; k < company_length; k++){
                    company_int[k%2] = [company characterAtIndex:k];
                }
                break;
        }
        NSLog(@"company_int[0]: %d, company_int[1]: %d", company_int[0], company_int[1]);
        
        // メールアドレスの処理
        int mail_int[2] = {0, 0};
        for(int k = 0; k < [mail1 length]; k++){
            mail_int[0] += [mail1 characterAtIndex:k];
        }
        for(int k = 0; k < [mail2 length]; k++){
            mail_int[1] += [mail2 characterAtIndex:k];
        }
        NSLog(@"mail: %@ %d %@ %d",mail1, mail_int[0], mail2, mail_int[1]);
        
        i[0] = (company_int[0] + mail_int[0])%32;
        i[1] = (company_int[1] + mail_int[1])%32;
        i[2] = (zip1 + name_int[0])%32;
        i[3] = (zip2 + name_int[1])%32;
        i[4] = name_int[0]%32;
        i[5] = name_int[1]%32;
        
        NSLog(@"indicidual %d %d %d %d %d %d", i[0], i[1], i[2], i[3], i[4], i[5]);
        
        [self setLv:5];
        [self setJob:rand()%4];
        [self calcParameter];
        [self reflesh];
        [self setExp:0];
    }
    return self;
}

// ゲッター
- (int) getLv{ return lv; }
// ステータスゲッター(戻り値NSSTring)
- (NSString *) getLvString{
    NSString *lvstring = [NSString stringWithFormat:@"%d", lv];
    return lvstring;
}
- (NSString *) getHString{
    [self calcParameter:0];
    NSString *hstring = [NSString stringWithFormat:@"%d", p[0]];
    return hstring;
}
- (NSString *) getAString{
    [self calcParameter:1];
    NSString *astring = [NSString stringWithFormat:@"%d", p[1]];
    return astring;
}
- (NSString *) getBString{
    [self calcParameter:2];
    NSString *bstring = [NSString stringWithFormat:@"%d", p[2]];
    return bstring;
}
- (NSString *) getCString{
    [self calcParameter:3];
    NSString *cstring = [NSString stringWithFormat:@"%d", p[3]];
    return cstring;
}
- (NSString *) getDString{
    [self calcParameter:4];
    NSString *dstring = [NSString stringWithFormat:@"%d", p[4]];
    return dstring;
}
- (NSString *) getSString{
    [self calcParameter:5];
    NSString *sstring = [NSString stringWithFormat:@"%d", p[5]];
    return sstring;
}
// 画像オブジェクト関係のゲッター
- (UIImageView *)getBattleImage{ return rightimg; }
- (UIImageView *)getCenterImage{ return centerimg; }
- (UIImage *)getIcon{ return icon; }

// 職業名ゲッター
- (NSString *)getJobString{
    switch(job){
        case 0:
            return @"戦士";
        case 1:
            return @"格闘家";
        case 2:
            return @"魔法使い";
        case 3:
            return @"僧侶";
    }
    return @"戦士";
}

// 現在の経験値
- (int)getExp{ return exp; }
// 次の経験値
- (int)getNextExp{ return lv*20; }
// 経歴ゲッター
- (NSString *)getHistory{ return history; }
// レベルセッター
- (void) setLv:(int)_lv{ lv = _lv; }

// 画像セッター
- (void) setImageNum:(int)num{
    imagenum = num;
    // 右向き画像
    UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"c%dr.PNG", imagenum]];
    rightimg = [[UIImageView alloc] initWithImage:img];
    // 正面画像
    img = [UIImage imageNamed:[NSString stringWithFormat:@"c%dc.PNG", imagenum]];
    centerimg = [[UIImageView alloc] initWithImage:img];
    // アイコン
    icon = [UIImage imageNamed:[NSString stringWithFormat:@"c%dicon.PNG", imagenum]];
}
// 現在の体力
- (void) setNowH:(int)_h{ nowh = _h; }
// 性別
- (void)setSex:(int)s{ sex = s; }

// 職業
- (void) setJob:(int)_job{
    job = _job;
    int i_num;
    switch(job){
        case 0:
            // 戦士
            j[0] = 1.0;
            j[1] = 1.2;
            j[2] = 1.1;
            j[3] = 0.7;
            j[4] = 0.7;
            j[5] = 1.0;
            if(sex == 0){
                i_num = 0;
            }else{
                i_num = 4;
            }
            // エフェクト
            effect = [[MBAnimationView alloc] init];
            [effect setAnimationImage:@"sl.png" :120 :120 :9];
            effect.animationDuration = 0.3;
            effect.animationRepeatCount = 1;
            break;
        case 1:
            // 格闘家
            j[0] = 0.9;
            j[1] = 1.3;
            j[2] = 0.9;
            j[3] = 0.7;
            j[4] = 0.7;
            j[5] = 1.1;
            if(sex == 0){
                i_num = 3;
            }else{
                i_num = 7;
            }
            // エフェクト
            effect = [[MBAnimationView alloc] init];
            [effect setAnimationImage:@"pu.png" :120 :120 :9];
            effect.animationDuration = 0.5;
            effect.animationRepeatCount = 1;
            break;
        case 2:
            // 魔法使い
            j[0] = 0.8;
            j[1] = 0.8;
            j[2] = 0.6;
            j[3] = 1.3;
            j[4] = 1.0;
            j[5] = 0.9;
            if(sex == 0){
                i_num = 2;
            }else{
                i_num = 5;
            }
            effect = [[MBAnimationView alloc] init];
            [effect setAnimationImage:@"mag.png" :120 :120 :14];
            effect.animationDuration = 0.8;
            effect.animationRepeatCount = 1;
            break;
        case 3:
            // 僧侶
            j[0] = 0.8;
            j[1] = 0.6;
            j[2] = 0.8;
            j[3] = 1.0;
            j[4] = 1.1;
            j[5] = 0.8;
            if(sex == 0){
                i_num = 1;
            }else{
                i_num = 6;
            }
            effect = [[MBAnimationView alloc] init];
            [effect setAnimationImage:@"mag.png" :120 :120 :14];
            effect.animationDuration = 0.8;
            effect.animationRepeatCount = 1;
            break;
    }
    [self setImageNum:i_num];
}

// 特殊能力セッター
- (void)setAbility:(int)abl{
    abilityID = abl;
    switch (abilityID){
        case 0:
            ability = @"ギガインパクト";
            ability_desc = @"強い物理攻撃を行う。";
            break;
        case 1:
            ability = @"破壊光線";
            ability_desc = @"強い魔法攻撃を行う。";
            break;
        case 2:
            ability = @"自己再生";
            ability_desc = @"発動すると自分のHPを半分回復させる。";
            break;
        case 3:
            ability = @"威嚇";
            ability_desc = @"パーティにいるだけで、相手の攻撃力を下げる。";
            break;
        case 4:
            ability = @"加速";
            ability_desc = @"発動したターンに2回攻撃を行う。";
            break;
        case 5:
            ability = @"アナライズ";
            ability_desc = @"素早さの高い敵に攻撃する時、攻撃力と魔法攻撃力が上がる。";
            break;
        case 6:
            ability = @"激流";
            ability_desc = @"HPが少なくなると、攻撃力と魔法攻撃力が上がる。";
            break;
        case 7:
            ability = @"自信過剰";
            ability_desc = @"相手モンスターを倒すと、一時的に攻撃力が上がる。";
            break;
        case 8:
            ability = @"ソニックブーム";
            ability_desc = @"防御を無視した魔法攻撃を行う。";
            break;
        case 9:
            ability = @"鮫肌";
            ability_desc = @"物理攻撃を受けた場合、相手にもダメージを与える。";
            break;
        case 10:
            ability = @"鳴き声";
            ability_desc = @"使うと、相手の攻撃力を下げる。";
            break;
        case 11:
            ability = @"";
            ability_desc = @"";
            break;
        case 12:
            ability = @"";
            ability_desc = @"";
            break;
        case 13:
            ability = @"";
            ability_desc = @"";
            break;
        case 14:
            ability = @"";
            ability_desc = @"";
            break;
        case 15:
            ability = @"";
            ability_desc = @"";
            break;
        case 16:
            ability = @"";
            ability_desc = @"";
            break;
        case 17:
            ability = @"";
            ability_desc = @"";
            break;
        case 18:
            ability = @"";
            ability_desc = @"";
            break;
        case 19:
            ability = @"";
            ability_desc = @"";
            break;
        case 20:
            ability = @"";
            ability_desc = @"";
            break;
        case 21:
            ability = @"";
            ability_desc = @"";
            break;
    }
}
// 個体値決定 ----------------------------------------------------------------------
- (void) setIndividual:(int *)_i{
    for(int k = 0; k < 6; k++){
        i[k] = _i[k];
    }
    // 個体値が決まると同時に経歴を決める
    // calc parameter に移してもいいかもしれない
    [self setHistory];
}
// 経歴 ----------------------------------------------------------------------
- (void)setHistory{
    // c+dの値で、高校名、大学名を決定
    NSString *c;
    int sum = i[3] + i[4];
    if(sum <= 12){
        //  0  1  2  3  4  5  6  7  8  9 10 11 12
        c = @"残念";
    }else if(sum <= 24){
        // 13 14 15 16 17 18 19 20 21 22 23 24
        c = @"ヤンキー";
    }else if(sum <= 37){
        // 25 26 27 28 29 30 31 32 33 34 35 36 37
        c = @"ゆとり";
    }else if(sum <= 50){
        // 38 39 40 41 42 43 44 45 46 47 48 49 50
        c = @"普通の";
    }else{
        // 51 52 53 54 55 56 57 58 59 60 61 62
        c = @"高学歴";
    }
    // a+bの値でキャリアを決定
    sum = i[1] + i[2];
    int y = 1;
    if(sum == 0){
        y = 1;
    }else if(sum == 1){
        y = 2;
    }else if(sum == 2){
        y = 3;
    }else{
        y = sum / 3.0;
    }
    
    // 転職日時（仮）
    NSString *d = @"yyyy年mm月dd日";
    
    // y(year)によってキャリア決定
    NSString *z;
    if(y <= 5){
        z = @"かけだし";
    }else if(y <= 15){
        z = @"平均的なキャリア";
    }else{
        z = @"ベテラン";
    }
    
    // h+sによって最終学歴を決定
    sum = i[0] + i[5];
    if(sum <= 11){
        // 中卒    0  1  2  3  4  5  6  7  8  9 10 11
        history = [NSString stringWithFormat:@"%@中学にて学生生活を過ごす。学生時代の特徴は%@。卒業後、%@になりたかったが、%@%@となる。就職%d年目の%@。", c, [self getFeature], [self getDream], [self getJReason], [self getJobString], y, z];
    }else if(sum <= 24){
        // 高卒   12 13 14 15 16 17 18 19 20 21 22 23 24
        history = [NSString stringWithFormat:@"%@高校にて学生生活を過ごす。学生時代の特徴は%@。卒業後、%@過ごすが、%@、%@、%@に転職する。転職%d年目の%@。", c, [self getFeature], [self getHLife], [self getHReason], d, [self getJobString], y, z];
    }else if(sum <= 37){
        // 学士卒 25 26 27 28 29 30 31 32 33 34 35 36 37
        history = [NSString stringWithFormat:@"%@大学にて学生生活を過ごす。学生の間は主に%@過ごし、%d年で卒業。その後株式会社「%@」に就職するが、%@、%@、%@に転職する。転職%d年目の%@。", c, [self getBLife], 4+(rand()%5), [self getCompany], [self getMBReason], d, [self getJobString], y, z];
    }else if(sum <= 50){
        // 修士卒 38 39 40 41 42 43 44 45 46 47 48 49 50
        history = [NSString stringWithFormat:@"%@大学院にて%@研究を行い、修士号を獲得。その後株式会社「%@」に就職するが、%@、%@、%@に転職する。転職%d年目の%@。", c, [self getPaper], [self getCompany], [self getMBReason], d, [self getJobString], y, z];
    }else{
        // 博士卒 51 52 53 54 55 56 57 58 59 60 61 62
        history = [NSString stringWithFormat:@"%@大学にて%@論文を発表し、博士号を獲得。以後研究を続けるが、%@、%@、%@に転職する。転職%d年目の%@。", c, [self getPaper], [self getDReason], d, [self getJobString], y, z];
    }
}
// 論文内容
- (NSString *)getPaper{
    switch(rand()%19){
        case 0:
            return @"IT関係の";
        case 1:
            return @"ヒトデに関する";
        case 2:
            return @"お笑い番組の視聴率に関する";
        case 3:
            return @"paper世界征服のための";
        case 4:
            return @"宇宙征服のための";
        case 5:
            return @"日本征服のための";
        case 6:
            return @"しいたけのおいしさに関する";
        case 7:
            return @"ブロッコリーのおいしさに関する";
        case 8:
            return @"いたってまじめな";
        case 9:
            return @"すべてひらがなでかいた";
        case 10:
            return @"小学生並の";
        case 11:
            return @"中学生並の";
        case 12:
            return @"高校生並の";
        case 13:
            return @"うなぎの生態の";
        case 14:
            return @"歴史的な";
        case 15:
            return @"後にノーベル賞を受賞するきっかけとなった";
        case 16:
            return @"猿の生態に関する";
        case 17:
            return @"暇つぶしがてら";
        case 18:
            return @"大量の";
    }
    return nil;
}
// バトラーになった理由 for 博士
- (NSString *)getDReason{
    switch(rand()%10){
        case 0:
            return @"暇ができたので";
        case 1:
            return @"閉じた世界に嫌気が差し";
        case 2:
            return @"ふと思い立って";
        case 3:
            return @"あまりの給料の少なさに絶望し";
        case 4:
            return @"仕事に飽きたので";
        case 5:
            return @"戦いの世界に憧れて";
        case 6:
            return @"研究ばかりだと運動できないので";
        case 7:
            return @"親のすすめで";
        case 8:
            return @"クビを言い渡されたため";
        case 9:
            return @"上司と口論の末";
    }
    return nil;
}
// バトラーになった理由 for 修士 and 学士
- (NSString *)getMBReason{
    switch(rand()%10){
        case 0:
            return @"暇ができたので";
        case 1:
            return @"閉じた世界に嫌気が差し";
        case 2:
            return @"ふと思い立って";
        case 3:
            return @"あまりの給料の少なさに絶望し";
        case 4:
            return @"仕事に飽きたので";
        case 5:
            return @"戦いの世界に憧れて";
        case 6:
            return @"運動不足解消のため";
        case 7:
            return @"親のすすめで";
        case 8:
            return @"クビを言い渡されたため";
        case 9:
            return @"上司と口論の末";
    }
    return nil;
}
// 理由 for 高卒
- (NSString *)getHReason{
    switch(rand()%8){
        case 0:
            return @"暇ができたので";
        case 1:
            return @"閉じた世界に嫌気が差し";
        case 2:
            return @"ふと思い立って";
        case 3:
            return @"あまりの給料の少なさに絶望し";
        case 4:
            return @"飽きたので";
        case 5:
            return @"戦いの世界に憧れて";
        case 6:
            return @"運動不足解消のため";
        case 7:
            return @"親のすすめで";
    }
    return nil;
}
// 理由 for 中卒
- (NSString *)getJReason{
    switch(rand()%6){
        case 0:
            return @"やっぱりやめて";
        case 1:
            return @"夢破れて";
        case 2:
            return @"親のすすめで";
        case 3:
            return @"進路をあみだくじで決めて";
        case 4:
            return @"なんとなく";
        case 5:
            return @"給料の高さにつられて";
    }
    return nil;
}
// 学生時代の過ごし方 for 学士
- (NSString *)getBLife{
    switch(rand()%10){
        case 0:
            return @"勉強をして";
        case 1:
            return @"ゲーセンに通って";
        case 2:
            return @"出会い系を利用して";
        case 3:
            return @"麻雀ばかりして";
        case 4:
            return @"サークル活動をして";
        case 5:
            return @"バイトをかけもちして";
        case 6:
            return @"大学に泊まり込んで";
        case 7:
            return @"ひとりぼっちで";
        case 8:
            return @"友人と共に";
        case 9:
            return @"寝て";
    }
    return nil;
}
// 学生時代の過ごし方 for 高卒
- (NSString *)getHLife{
    switch(rand()%10){
        case 0:
            return @"特徴を活かした会社を経営して";
        case 1:
            return @"アルバイトをして";
        case 2:
            return @"仏門に下って";
        case 3:
            return @"新興宗教を立ち上げて";
        case 4:
            return @"ぼーっとして";
        case 5:
            return @"ひたすら引きこもって";
        case 6:
            return @"世界を旅して";
        case 7:
            return @"日本中を歩いて";
        case 8:
            return @"親のスネをかじって";
        case 9:
            return @"投資家として";
    }
    return nil;
}
// 会社
- (NSString *)getCompany{
    switch(rand()%10){
        case 0:
            return @"超絶ハード";
        case 1:
            return @"ハイパーブラック";
        case 2:
            return @"ハイパーホワイト";
        case 3:
            return @"暇つぶし";
        case 4:
            return @"世紀末";
        case 5:
            return @"昼寝";
        case 6:
            return @"居眠り";
        case 7:
            return @"休憩ゼロ";
        case 8:
            return @"休日なし";
        case 9:
            return @"超宗教";
    }
    return nil;
}
// なりたかったもの (for 中卒)
- (NSString *)getDream{
    switch(rand()%10){
        case 0:
            return @"サラリーマン";
        case 1:
            return @"経営者";
        case 2:
            return @"投資家";
        case 3:
            return @"青年実業家";
        case 4:
            return @"プロアルバイター";
        case 5:
            return @"公務員";
        case 6:
            return @"大工";
        case 7:
            return @"ケーキ屋の店員";
        case 8:
            return @"電車の運転手";
        case 9:
            return @"看護師";
    }
    return nil;
}
// 学生時代の特徴 (for 高卒 and 中卒)
- (NSString *)getFeature{
    switch(rand()%10){
        case 0:
            return @"中二病な性格";
        case 1:
            return @"ヤンキースタイル";
        case 2:
            return @"パソコンオタク";
        case 3:
            return @"時代錯誤な学ラン";
        case 4:
            return @"異性にモテたこと";
        case 5:
            return @"異性にモテなかったこと";
        case 6:
            return @"ひきこもり";
        case 7:
            return @"アクティブな性格";
        case 8:
            return @"おしゃべり";
        case 9:
            return @"授業を寝てばかりだったこと";
    }
    return nil;
}

// 初期経験値の値をセット
- (void)setExp:(int)e{
    exp = e;
}

// 攻撃する関数
- (int)attack:(Enemy *)target{
    // 種族によって、Aで攻撃するかCで攻撃するか分岐
    int damage = 0;
    switch (job) {
            // 戦士 or 格闘家
        case 0:
        case 1:
            damage = [self getA] - [target getB];
            break;
            // それ以外
        default:
            damage = [self getC] - [target getD];
            break;
    }
    
    // 最低でも1ダメージは与えることができる
    if(damage <= 0) damage = 1;
    
    // エフェクト描写
    // ターゲットの画像の座標を取得、幅も取得して中心を求める
    int x = [target getBattleImage].frame.origin.x;
    int y = [target getBattleImage].frame.origin.y;
    int w = [target getBattleImage].frame.size.width;
    int h = [target getBattleImage].frame.size.height;
    x = x + (w/2.0);
    y = y + (h/2.0);
    // 座標に対してエフェクト描写
    effect.frame = CGRectMake(x-30, y-30, 60, 60);
    [[[target getBattleImage] superview] addSubview:effect];
    [effect startAnimating];
    
    // 乱数を生成してダメージ計算(100% - 90%)
    int r = arc4random()%10;
    r = 100 - r;
    damage = damage * (r/100.0);
    // ダメージは0にはならない
    if(damage <= 0) damage = 1;
    
    // 対象のHPをマイナスする
    return [target damage:damage];
}

// 体力回復
- (int)recover:(int)r{
    // 体力が0だったら回復しない
    if(nowh == 0) return -1;
    // 体力マックスでも回復しない
    if(nowh == p[0]) return 0;

    if(r == 0){
        r = p[0] - nowh;
        nowh = p[0];
    }else{
        if(r <= p[0] - nowh){
            nowh += r;
        }else{
            r = p[0] - nowh;
            p[0] = nowh;
        }
    }
    [self drawHpBar];
    return r;
}

// 戦闘復帰
- (BOOL)revive{
    if(nowh <= 0){
        // 半分回復
        nowh = p[0] / 2.0;
        [self drawHpBar];
        return true;
    }else{
        return false;
    }
}
// その他外部メソッド
// HPとか、ダンジョンでのダメージとかリセット
- (void) reflesh{
    nowh = p[0];
}

- (int)exp:(int)e{
    uplv = 0;
    for(int k = 0; k < 6; k++){
        past_p[k] = p[k];
    }
    int next = 20 * lv;
    // 経験値を取得
    exp += e;
    // レベルアップの判定
    while(next < exp){
        lv++;
        uplv++;
        exp -= next;
    }
    // パラメータの計算とか
    [self calcParameter];
    [self reflesh];
    NSLog(@"Meishi.exp %d", exp);
    return uplv;
}

// 内部メソッド
- (void) calcParameter{
    for(int k = 0; k < 6; k++){
        [self calcParameter:k];
    }
    nowh = p[0];
}
- (int) calcParameter:(int)k{
    p[k] = 30 + (250*j[k] + i[k])*(lv/50.0);
    return p[k];
}

- (Boolean)isPlayer{
    return true;
}

@end