//
//  DungeonViewController.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/04/06.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "DungeonViewController.h"
#import "AppDelegate.h"
#import "Meishi.h"
#import "Player.h"
#import "Enemy.h"
#import "Dungeon.h"
#import "MBCharacter.h"
#import "MBAnimationView.h"
#import "MBScrollView.h"

@interface DungeonViewController ()

@end

@implementation DungeonViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPlayer:(Player *)p{
    self = [super init];
    if(self){
        player = p;
        item_flag = 0;
    }
    return self;
}


// 外部メソッド
// ダンジョンの情報を登録する
- (void)setDungeon:(Dungeon *)d{
    NSLog(@"DungeonViewController: ダンジョンの情報をセット");
    dungeon = d;
}

- (void)setPlayer:(Player *)p{
    NSLog(@"DungeonViewController: Playerの情報をセット");
    player = p;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"%s", __func__);
    
    // 画面の縦横所取得
    CGRect screen_rect = [UIScreen mainScreen].applicationFrame;
    int h = screen_rect.size.height;
    
    // 背景イメージの設定
    UIImageView *bg = [dungeon getBackground];
    bg.frame = CGRectMake(0, 39, 320, 240);
    [[self view] addSubview:bg];
    
    // ダンジョン名の背景部分表示
    navImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dungeonNav.png"]];
    navImage.frame = CGRectMake(-119, -46, 558, 100);
    [[self view] addSubview:navImage];
    
    // ダンジョン名を取得して表示
    title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    title.text = [dungeon getName];
    title.font = [UIFont systemFontOfSize:18];
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor clearColor];
    [[self view] addSubview:title];

    // パーティを取得し、戦闘参加者配列に突っ込む
    party = [player getParty];
    combatant = [[NSMutableArray alloc] init];
    [self addCombatants:party];
    // 味方を一応初期化
    [player reflesh];
    // 味方を描写
    [self drawParty];
    
    
    // アイテム　薬草
    UIButton *item1_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [item1_button setImage:[UIImage imageNamed:@"yakusou.png"] forState:UIControlStateNormal];
    item1_button.frame = CGRectMake(240, 279, 40, 40);
    item1_button.backgroundColor = [UIColor lightGrayColor];
    item1_button.tag = 1;
    [[self view] addSubview:item1_button];
    
    // アイテム　果実
    UIButton *item2_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [item2_button setImage:[UIImage imageNamed:@"ringo.png"] forState:UIControlStateNormal];
    item2_button.frame = CGRectMake(280, 279, 40, 40);
    item2_button.backgroundColor = [UIColor lightGrayColor];
    item2_button.tag = 2;
    [[self view] addSubview:item2_button];
    
    // ポーズボタン
    UIButton *pause_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [pause_button setTitle:@"停" forState:UIControlStateNormal];
    pause_button.frame = CGRectMake(288, 0, 32, 32);
    [[self view] addSubview:pause_button];

    
    /*
    UIImageView *item0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yakusou.png"]];
    item0.frame = CGRectMake(0, 279, 24, 24);
    [[self view] addSubview:item0];
     */

    // メッセージウィンドウ
    messege_window = [[UITextView alloc] initWithFrame:CGRectMake(0, 319, 320, h-319)];
    messege_window.editable = NO;
    messege_window.font = [UIFont systemFontOfSize:16];
    messege_window.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    messege_window.text = @"タップで戦闘開始";
    [[self view] addSubview:messege_window];
    
    // 画面をタップした時に戦闘が始まるようにする
    tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(battle:)];
    [[self view] addGestureRecognizer:tgr];
}


- (void)battle:(UITapGestureRecognizer *)sender{
    NSLog(@"戦闘開始");
    // スクリーンタップイベンターを除去
    [[self view] removeGestureRecognizer:tgr];
    
    ptarget = 0; //攻撃対象となる敵ポインタ
    etarget = 0; // 相手の攻撃対象となる敵ポインタ
    
    // 敵の長さだけループ（ここで敵の死亡判定するようにしたい）
    eimgs = [[NSMutableArray alloc] init];
    for(int i = 0; i < [dungeon getLength]; i++) {
        NSLog(@"敵の長さ %d", [dungeon getLength]);
        // enemy に次の敵を取得 -> combatant にぶちこむ
        enemy = [[dungeon next] mutableCopy];
        [self addCombatants:enemy];
        // 敵を描写
        [self appear];
        [self addMessege:@"敵が出現!"];
        
        // ゲームループに入る
        turn = 0;
        while(!([player isDead] || [dungeon isDead])){ // どちらかが全滅するまで
            // NSLog(@"ゲームループ");
            // ウェイトを入れる
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
            

            // 攻撃キャラを決める
            MBCharacter *attacker = [combatant objectAtIndex:(turn % [combatant count])];
            [self addMessege:[NSString stringWithFormat:@"%@ の攻撃！", [attacker getName]]];
            MBCharacter *defender;
            

            if([attacker isPlayer]){
                // プレイヤーの攻撃→ターゲットは敵
                // ターゲットを固定してから
                int ptarget_const = ptarget;
                // 攻撃対象を決定
                defender = [enemy objectAtIndex:ptarget_const%[enemy count]]; // こうすることでバグ回避
                // defender に攻撃
                int damage = [(Meishi *)attacker attack:(Enemy *)defender];
                // エフェクトのための間をおく
                [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
                [self addMessege:[NSString stringWithFormat:@"%@ に %d のダメージ！",[defender getName], damage]];
                // デバッグ用
                NSLog(@"%s %@ -> %@ %d",__func__ , [attacker getName], [defender getName], damage);
                if([defender isDead]){
                    // 倒した場合
                    // ここで間を置く
                    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.3]];
                    // メッセージを表示
                    [self addMessege:[NSString stringWithFormat:@"%@ は倒れた！", [defender getName]]];
                    // combatantから除去
                    [self removeCombatant:defender];
                    // リストからも除去してしまおう
                    //[enemy removeObject:defender];
                    [[defender getBattleImage] removeFromSuperview];
                    if(ptarget == ptarget_const){
                        NSLog(@"ptarget 戻す %d %d", ptarget, ptarget_const);
                        ptarget = 0;
                    }
                    NSLog(@"敵除去");
                }
            }else{
                // 敵の攻撃対象
                defender = [party objectAtIndex:etarget];
                // とりあえず物理に攻撃
                int damage = [defender damagedA:attacker];
                [self addMessege:[NSString stringWithFormat:@"%@ に %d のダメージ！",[defender getName], damage]];
                // デバッグ用
                NSLog(@"防御キャラ: %@", [defender getName]);
                NSLog(@"ダメージ: %d", damage);
                if([defender isDead]){  // 倒した場合
                    [self addMessege:[NSString stringWithFormat:@"%@ は倒れた！", [defender getName]]];
                    // conbatantから除去
                    [self removeCombatant:defender];
                    etarget++;
                }
            }
            turn++;
            if(turn >= [combatant count]) turn = 0;
        }// ゲームループの終わり
        // ウェイト
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        ptarget = 0;
    }
    
    // 結果画面のセット
    if([dungeon isDead]){
        // 勝利した場合
        exp = [dungeon getExp];
    }else if([player isDead]){
        // 全滅した場合
        // 経験値0 →　撤退
        exp = 0;
    }
    
    // タッチイベントリスナー
    tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewResult:)];
    [[self view] addGestureRecognizer:tgr];
}

// メッセージボックスにstrを表示させる関数
- (void)setMessege:(NSString *)str{
    messege.text = str;
}

// メッセージボックスに追記する関数
- (void)addMessege:(NSString *)str{
    messege_window.text = [NSString stringWithFormat:@"%@\n%@", messege_window.text, str];
    // 追記した分下にスクロール
    messege_window.scrollEnabled = NO;  // turn off scrolling or you'll get dizzy ... I promise
    NSRange range = messege_window.selectedRange;
    range.location += [str length];
    messege_window.selectedRange = range;
    messege_window.scrollEnabled = YES;  // turn scrolling back on.
}

// combatant にリストを突っ込む ---------------------------------------------------------------
- (void)addCombatants:(NSMutableArray *)array{
    for(int i = 0; i < [array count]; i++){
        NSLog(@"combatant に突っ込む");
        [self addCombatant:[array objectAtIndex:i]];
    }
}

// combatant に一人突っ込む
- (void)addCombatant:(MBCharacter *)chr{
    // とりあえず、誰も入ってなかったらそのまま突っ込む(これ必要かな？)
    if([combatant count] == 0){
        [combatant addObject:chr];
    }else{
        for(int i = 0; i < [combatant count]; i++){
            if([[combatant objectAtIndex:i] getS] < [chr getS]){
                [combatant insertObject:chr atIndex:i];
                return;
            }
        }
        [combatant addObject:chr];
    }
}

// combatamt からキャラを除外する
- (void)removeCombatant:(MBCharacter *)chr{
    int position = [combatant indexOfObject:chr];
    if((position != -1)&&(position <= turn%[combatant count])){
        turn --;
        NSLog(@"indexOfObject %d",position);
    }
    [combatant removeObject:chr];
}

// キャラ画像描写 ------------------------------------------------------------------------------------------
- (void)drawParty{
    NSLog(@"パーティ描写");
    for(int i = 0; i < [player getPartynum]; i++){
        Meishi *m = [player getMeishi:i];
        UIImageView *view = [m getBattleImage];
        UIImageView *hp0view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hp0.png"]];
        UIImageView *hp1view;
        int x = 0;
        int y = 0;
        switch(i){
            case 0:
                x = 30;
                y = 100;
                break;
            case 1:
                x = 30;
                y = 160;
                break;
            case 2:
                x = 30;
                y = 220;
                break;
            case 3:
                x = 80;
                y = 130;
                break;
            case 4:
                x = 80;
                y = 190;
                break;
        }
        
        view.frame = CGRectMake(x, y, 32, 48);
        hp0view.frame = CGRectMake(x, y+48, 32, 5);
        hp1view = [m getHpBar:x :y+48];
        [[self view] addSubview:view];
        [[self view] addSubview:hp0view];
        [[self view] addSubview:hp1view];
    }
}

// 敵画像描写
- (void)appear{
    for(int i = 0; i < [dungeon getNumOfEnemy]; i++){
        [self appear:i];
    }
}
- (void)appear:(int)i{
    NSLog(@"敵描写");
    Enemy *e = [enemy objectAtIndex:i];
    UIImageView *view = [e getLeftImage];
    view.tag = i;
    view.userInteractionEnabled = true;
    // タップされた時のレコ具ナイザー
    UITapGestureRecognizer *etgr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(eTarget:)];
    // etgr.tag = i;
    [view addGestureRecognizer:etgr]; // 狙い変更のための
    int x = 0;
    int y = 0;
    switch(i){
        case 0:
            x = 230;
            y = 100;
            break;
        case 1:
            x = 230;
            y = 160;
            break;
        case 2:
            x = 230;
            y = 220;
            break;
        case 3:
            x = 180;
            y = 130;
            break;
        case 4:
            x = 180;
            y = 190;
            break;
    }
    // もろもろのために座標を記録
    enemypositions[i][0] = x;
    enemypositions[i][1] = y;
    
    view.frame = CGRectMake(x, y, 32, 48);
    [[self view] addSubview:view];
    //[eimgs addObject:view];
}

// 敵の狙い変更
- (void)eTarget:(id)sender{
    NSLog(@"敵タップ");
    UITapGestureRecognizer *etgr = (UITapGestureRecognizer *)sender;
    UIImageView *view = (UIImageView *)etgr.view;
    NSLog(@"%d", etarget);
    NSLog(@"%d", (int)view.tag);
    ptarget = view.tag;
}
- (void)close{
    NSLog(@"ダンジョン");
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)close:(id)sender{
    NSLog(@"ダンジョン");
    [self dismissViewControllerAnimated:NO completion:nil];
}


/***********************************************************************************
 * 結果画面関係
 ***********************************************************************************/
// 結果ウィンドウを開くためのイベントリスナー
- (void)viewResult:(UITapGestureRecognizer *)sender{
    // タップイベントリスナーの除去
    [[self view] removeGestureRecognizer:tgr];
    
    // 結果画面の初期化
    MBScrollView *resultView = [[MBScrollView alloc] initWithPlayer:player];
    CGRect screen_rect = [UIScreen mainScreen].applicationFrame;
    resultView.frame = CGRectMake(0, 40, screen_rect.size.width, screen_rect.size.height-40);
    UIImage *backgroundImage = [UIImage imageNamed:@"bg.png"];
    resultView.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];

    [resultView setTitle:@"リザルト"];
    
    // 画面閉じるボタン設置
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backbutton.frame = CGRectMake(20, 5, 50, 32);
    [backbutton setTitle:@"戻る" forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(close:)forControlEvents:UIControlEventTouchUpInside];
    [resultView addSubview:backbutton];
    
    // 勝ったかどうかで分岐
    if(exp == 0){
        // 負けた場合
        UILabel *resultlabel = [[UILabel alloc] init];
        resultlabel.frame = CGRectMake(10, 160, 300, 32);
        resultlabel.text = @"撤退した…";
        resultlabel.backgroundColor = [UIColor clearColor];
        resultlabel.textAlignment = NSTextAlignmentCenter;
        [resultView addSubview:resultlabel];
    }else{
        // 勝った場合
        // 一人あたりの経験値を計算
        int exp_per_m = ceil((double)exp / [player getPartynum]);
        NSLog(@"Exp: %d", exp_per_m);
        
        UILabel *resultlabel = [[UILabel alloc] init];
        resultlabel.frame = CGRectMake(10, 60, 300, 24);
        resultlabel.text = [NSString stringWithFormat:@"%d 経験値を手に入れた！", exp_per_m];
        resultlabel.textAlignment = NSTextAlignmentCenter;
        resultlabel.backgroundColor = [UIColor clearColor];
        [resultView addSubview:resultlabel];
        
        for(int i = 0; i < [player getPartynum]; i++){
            Meishi *meishi = [player getMeishi:i];
            int uplv = [meishi exp:exp_per_m];
            
            // アイコン
            UIImageView *view = [meishi getCenterImage];
            view.frame = CGRectMake(40, 100+(50*i), 32, 48);
            [resultView addSubview:view];
            // 名前
            UILabel *name = [[UILabel alloc] init];
            name.text = [meishi getName];
            name.frame = CGRectMake(80, 100+(50*i), 80, 24);
            name.backgroundColor = [UIColor clearColor];
            [resultView addSubview:name];
            // レベルアップしたかどうか
            if(uplv > 0){
                UILabel *attention = [[UILabel alloc] init];
                attention.text = @"レベルアップ！";
                attention.frame = CGRectMake(80, 124+(50*i), 200, 24);
                attention.backgroundColor = [UIColor clearColor];
                [resultView addSubview:attention];
            }
        }
    }
    [[self view] addSubview:resultView];
    
    // タイトルとかを全面に持ってくる
    [[self view] bringSubviewToFront:navImage];
    [[self view] bringSubviewToFront:title];
}

@end
