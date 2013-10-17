//
//  MBViewController.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/06/02.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBViewController.h"
#import "MBScrollView.h"
#import "MBCharacterView.h"
#import "MBPartyView.h"
#import "MBItemView.h"
#import "DungeonViewController.h"
#import "MBOptionView.h"
#import "SummonViewController.h"
#import "Tesseract.h"
#import <Foundation/Foundation.h>
#import <opencv2/opencv.hpp>
#import "FilterBase.h"
#import "MonochromeFilter.h"
#import "OcrViewController.h"
#import "SVProgressHUD.h"
#import "FMDatabase.h"
#import "MBStartView.h"
#import "UIOutlineLabel.h"

@interface MBViewController ()

@end

@implementation MBViewController

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
    if(self) {
        player = p;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 画面の縦横比を取得
    CGRect screen_rect = [UIScreen mainScreen].applicationFrame;
    w = screen_rect.size.width;
    h = screen_rect.size.height;
    inside_h = h - 56 - 52;
    
    // 色の設定
    bgcolor = [UIColor whiteColor];
    menucolor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0];
    menutextcolor = [UIColor blackColor];
    subbgcolor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    
    
    
    // 背景の設定
    // UIImage *backgroundImage = [UIImage imageNamed:@"bg.png"];
    // [self view].backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    // AppDelegate 初期化(グローバル変数的な使い方)
    self.view.backgroundColor = [UIColor lightGrayColor];
    ad = [[UIApplication sharedApplication] delegate];
    
    mbdb = [[MBDatabase alloc] init];
    [player save];
    
    // ステータス部分の背景
    UIImageView *navImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav.png"]];
    navImage.frame = CGRectMake(-119, -30, 558, 100);
    [[self view] addSubview:navImage];
    
    // 上にステータスみたいなのつける(仮)
    UIScrollView *status = [[UIScrollView alloc] init];
    status.backgroundColor = [UIColor clearColor];
    status.frame = CGRectMake(0, 0, 320, 56);
    [[self view] addSubview:status];
    
    // 名前
    UILabel *name = [[UILabel alloc] init];
    [name setBackgroundColor:[UIColor colorWithRed:1.0 green:0.95 blue:0.8 alpha:0.5]];
    name.frame = CGRectMake(10, 18, 120, 20);
    name.text = [player getName];
    name.font = [UIFont fontWithName:@"mikachan_o" size:16];
    name.textColor = [UIColor colorWithRed:0.1 green:0.05 blue:0.01 alpha:1.0];
    [status addSubview:name];
    
    // スタミナ
    UILabel *stamina_label = [[UILabel alloc] init];
    // [stamina_label setBackgroundColor:subbgcolor];
    stamina_label.backgroundColor = [UIColor colorWithRed:1.0 green:0.95 blue:0.8 alpha:0.2];
    stamina_label.frame = CGRectMake(10, 40, 300, 14);
    stamina_label.font = [UIFont fontWithName:@"mikachan_o" size:10];
    stamina_label.textColor = [UIColor colorWithRed:0.1 green:0.05 blue:0.01 alpha:1.0];
    stamina_label.text = @" スタミナ";
    //stamina_label.font = [UIFont systemFontOfSize:10];
    [status addSubview:stamina_label];
    
    /*
    UIOutlineLabel *stamina_index_label = [[UIOutlineLabel alloc] init];
    [stamina_index_label setOutlineColor:[UIColor colorWithRed:1.0 green:0.95 blue:0.8 alpha:1.0]];
    [stamina_index_label setOutlineWidth:2];
    stamina_index_label.text = @"スタミナ";
    stamina_index_label.frame = CGRectMake(2, 0, 50, 14);
    //name_label.textAlignment = NSTextAlignmentCenter;
    stamina_index_label.font = [UIFont fontWithName:@"mikachan_o" size:10];
    stamina_index_label.textColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:1.0];
    stamina_index_label.backgroundColor = [UIColor clearColor];
    [stamina_label addSubview:stamina_index_label];
     */
    
    // スタミナバー
    UIImageView *stamina_base = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hp0.png"]];
    stamina_base.frame = CGRectMake(48, 2, 250, 10);
    [stamina_label addSubview:stamina_base];
    [stamina_base addSubview:[player getStaminaBar:0 :0]];
    
    // スタミナ数値
    UILabel *stamina_val = [player getStaminaLabel];
    stamina_val.frame = CGRectMake(40, 0, 60, 15);
    stamina_val.textAlignment = NSTextAlignmentRight;
    [stamina_label addSubview:stamina_val];
    
    
    MBScrollView *sv = [[MBScrollView alloc] init];
    [sv setTitle:@"トップ"];
    nowScrollView = sv;
    [[self view] addSubview:sv];
    
    // 下にメニューつける(仮)
    // メニューの影
    UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, h-54, 319, 2)];
    menuLabel.backgroundColor = [UIColor grayColor];
    [[self view] addSubview:menuLabel];
    
    // 上にステータスみたいなのつける(仮)
    UIScrollView *menu = [[UIScrollView alloc] init];
    [menu setBackgroundColor:menucolor];
    menu.frame = CGRectMake(0, h-52, 320, 52);
    [[self view] addSubview:menu];
    
    // 召喚ボタン
    UIButton *summon = [UIButton buttonWithType:UIButtonTypeCustom];
    summon.frame = CGRectMake(1, 0, 52, 52);
    [summon setBackgroundImage:[UIImage imageNamed:@"summon.png"] forState:UIControlStateNormal];
    [summon addTarget:self action:@selector(viewSummon:)forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:summon];
    
    // キャラクターボタン
    UIButton *character = [UIButton buttonWithType:UIButtonTypeCustom];
    character.frame = CGRectMake(54, 0, 52, 52);
    [character setBackgroundImage:[UIImage imageNamed:@"character.png"] forState:UIControlStateNormal];
    [character addTarget:self action:@selector(viewCharacter:)forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:character];
    
    // パーティボタン
    UIButton *party = [UIButton buttonWithType:UIButtonTypeCustom];
    party.frame = CGRectMake(107, 0, 52, 52);
    [party setBackgroundImage:[UIImage imageNamed:@"party.png"] forState:UIControlStateNormal];
    [party addTarget:self action:@selector(viewParty:)forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:party];
    
    // ダンジョン
    UIButton *dungeon = [UIButton buttonWithType:UIButtonTypeCustom];
    dungeon.frame = CGRectMake(160, 0, 52, 52);
    [dungeon setBackgroundImage:[UIImage imageNamed:@"dungeon.png"] forState:UIControlStateNormal];
    [dungeon addTarget:self action:@selector(viewDungeon:)forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:dungeon];
    
    // アイテムボタン
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    item.frame = CGRectMake(213, 0, 52, 52);
    [item setBackgroundImage:[UIImage imageNamed:@"item.png"] forState:UIControlStateNormal];
    [item addTarget:self action:@selector(viewItem:)forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:item];
    
    // 設定
    UIButton *option = [UIButton buttonWithType:UIButtonTypeCustom];
    option.frame = CGRectMake(266, 0, 52, 52);
    [option setBackgroundImage:[UIImage imageNamed:@"option.png"] forState:UIControlStateNormal];
    [option addTarget:self action:@selector(viewOption:)forControlEvents:UIControlEventTouchUpInside];
    [menu addSubview:option];
    
    // タイトル
    title = [[UILabel alloc] init];
    title.font = [UIFont systemFontOfSize:18];
    [title setBackgroundColor:menucolor];
    [title setTextColor:menutextcolor];
    title.frame = CGRectMake(10, 60, 300, 32);
    title.textAlignment = NSTextAlignmentCenter;
    
    // 最初のウィンドウ表示
    nowScrollView = [[MBStartView alloc] init];
    [[self view] addSubview:nowScrollView];
}

// キャラクター ------------------------------------------------------------
- (void)viewCharacter:(id)sender{
    // 今映ってるのを除去
    if(nowScrollView) [nowScrollView removeFromSuperview];
    MBCharacterView *view = [[MBCharacterView alloc] initWithPlayer:player];
    [[self view] addSubview:view];
    nowScrollView = view;
}

// パーティ
- (void)viewParty:(id)sender{
    if(nowScrollView) [nowScrollView removeFromSuperview];
    MBPartyView *view = [[MBPartyView alloc] initWithPlayer:player];
    [[self view] addSubview:view];
    nowScrollView = view;
}

// アイテム
- (void)viewItem:(id)sender{
    // 今映ってるのを除去
    if(nowScrollView) [nowScrollView removeFromSuperview];
    MBItemView *view = [[MBItemView alloc] initWithPlayer:player];
    [[self view] addSubview:view];
    nowScrollView = view;
}

// 設定
- (void)viewOption:(id)sender{
    // 今映ってるのを除去
    if(nowScrollView) [nowScrollView removeFromSuperview];
    MBOptionView *view = [[MBOptionView alloc] initWithPlayer:player];
    [[self view] addSubview:view];
    nowScrollView = view;
}


/**********************************************************************
 * ダンジョン関係
 **********************************************************************/
// ダンジョンビュー表示
- (void)viewDungeon:(id)sender{
    // 今映ってるのを除去
    if(nowScrollView) [nowScrollView removeFromSuperview];
    NSLog(@"MBViewController: viewDungeon");
    // まず、ダンジョンインスタンスを作成
    Dungeon *dungeon = [[Dungeon alloc] init];
    
    // ビューの準備
    MBScrollView *dungeonView = [[MBScrollView alloc] initWithPlayer:player];
    [dungeonView setTitle:@"ダンジョン選択"];
    
    // ダンジョン一覧を表示するスクロールエリア
    UIScrollView *dungeon_view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, 320, 300)];
    dungeon_view.backgroundColor = [UIColor clearColor];
    [dungeonView addSubview:dungeon_view];
    
    // ダンジョン名一覧を取得
    NSArray *dungeonNames = [dungeon getNames];
    dungeon_view.contentSize = CGSizeMake(300, 58 * [dungeonNames count] + 20);    // スクロール内部のサイズ

    for(int i = 0; i < [dungeonNames count]; i++){
        UIButton *dungeon_button = [UIButton buttonWithType:UIButtonTypeCustom];
        dungeon_button.frame = CGRectMake(10, 5 + 58*i, 300, 50);
        //[button setBackgroundImage:[UIImage imageNamed:@"husen1.png"] forState:UIControlStateNormal];
        dungeon_button.tag = i;
        //[dungeon_button setTitle:[dungeonNames objectAtIndex:i] forState:UIControlStateNormal];
        [dungeon_button addTarget:self action:@selector(dungeonTouched:)forControlEvents:UIControlEventTouchUpInside];
        dungeon_button.backgroundColor = [UIColor colorWithRed:1.0 green:0.95 blue:0.8 alpha:0.9];
        [[dungeon_button layer] setBorderWidth:2.0];//[UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.8];
        [[dungeon_button layer] setCornerRadius:6.0];
        [[dungeon_button layer] setBorderColor:[[UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.8] CGColor]];
        [dungeon_view addSubview:dungeon_button];
        
        UILabel *dungeon_name_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 50)];
        dungeon_name_label.numberOfLines = 2;
        dungeon_name_label.text = [dungeonNames objectAtIndex:i];
        dungeon_name_label.font = [UIFont fontWithName:@"mikachan_o" size:16];
        dungeon_name_label.textColor = [UIColor colorWithRed:0.1 green:0.05 blue:0.01 alpha:1.0];
        dungeon_name_label.textAlignment = NSTextAlignmentCenter;
        [dungeon_button addSubview:dungeon_name_label];
        
        [dungeon setDungeon:i];
        UILabel *dungeon_stamina_label = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 100, 25)];
        dungeon_stamina_label.text = [NSString stringWithFormat:@"消費スタミナ: %d", [dungeon getStamina]];
        dungeon_stamina_label.font = [UIFont fontWithName:@"mikachan_o" size:12];
        dungeon_stamina_label.textColor = [UIColor colorWithRed:0.1 green:0.05 blue:0.01 alpha:1.0];
        [dungeon_button addSubview:dungeon_stamina_label];
    }

    [[self view] addSubview:dungeonView];
    nowScrollView = dungeonView;
}

// ダンジョンに入る時の確認ウィンドウ
- (void)dungeonTouched:(UIButton *)sender{
    if(confirm_view) [confirm_view removeFromSuperview];
    confirm_view = [[UIScrollView alloc] initWithFrame:CGRectMake(30, 80, 260, 160)];
    confirm_view.layer.masksToBounds = NO;
    confirm_view.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);  //影の方向
    confirm_view.layer.shadowOpacity = 0.7f; // 影の透明度
    confirm_view.layer.shadowColor = [UIColor blackColor].CGColor;   // 影の色
    confirm_view.layer.shadowRadius = 2.0f;  // ぼかし
    confirm_view.backgroundColor = [UIColor colorWithRed:1.0 green:0.95 blue:0.8 alpha:0.9];
    [nowScrollView addSubview:confirm_view];
    
    Dungeon *dungeon = [[Dungeon alloc] init];
    [dungeon setDungeon:sender.tag];
    // ダンジョン名
    UILabel *name_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 40)];
    name_label.text = [dungeon getName];
    name_label.font = [UIFont fontWithName:@"mikachan_o" size:16];
    name_label.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.5];
    name_label.textAlignment = NSTextAlignmentCenter;
    [confirm_view addSubview:name_label];
    // 消費スタミナ
    UILabel *stamina_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 260, 20)];
    stamina_label.text = [NSString stringWithFormat:@"消費スタミナ: %d", [dungeon getStamina]];
    stamina_label.font = [UIFont fontWithName:@"mikachan_o" size:14];
    stamina_label.textAlignment = NSTextAlignmentCenter;
    [confirm_view addSubview:stamina_label];
    //
    UILabel *alert_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 260, 20)];
    alert_label.font = [UIFont fontWithName:@"mikachan_o" size:14];
    alert_label.textAlignment = NSTextAlignmentCenter;
    [confirm_view addSubview:alert_label];
    // 確認メッセージとボタン
    // キャンセルボタンの初期化
    UIButton *cancel_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancel_button.titleLabel.font = [UIFont fontWithName:@"mikachan_o" size:16];
    cancel_button.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:0.8];
    [cancel_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancel_button addTarget:self action:@selector(cancelOpenDungeon:)forControlEvents:UIControlEventTouchUpInside];
    [confirm_view addSubview:cancel_button];
    if([player haveStamina:[dungeon getStamina]]){
        alert_label.text = @"入りますか？";
        // GO
        UIButton *confirm_button = [UIButton buttonWithType:UIButtonTypeCustom];
        confirm_button.frame = CGRectMake(0, 120, 130, 40);
        [confirm_button setTitle:@"GO!" forState:UIControlStateNormal];
        confirm_button.titleLabel.font = [UIFont fontWithName:@"mikachan_o" size:16];
        confirm_button.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:1.0 alpha:0.8];
        [confirm_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirm_button addTarget:self action:@selector(openDungeon:)forControlEvents:UIControlEventTouchUpInside];
        confirm_button.tag = sender.tag;
        [confirm_view addSubview:confirm_button];
        // やめる
        cancel_button.frame = CGRectMake(131, 120, 130, 40);
        [cancel_button setTitle:@"やめる" forState:UIControlStateNormal];
    }else{
        alert_label.text = @"スタミナが足りません";
        alert_label.textColor = [UIColor redColor];
        cancel_button.frame = CGRectMake(70, 110, 120, 40);
        [cancel_button setTitle:@"× とじる" forState:UIControlStateNormal];
    }
}

- (void)openDungeon:(UIButton *)sender{
    NSLog(@"%s", __func__);
    [[sender superview] removeFromSuperview];
    // 選択したダンジョンのデータを取得
    Dungeon *dungeon = [[Dungeon alloc] init];
    [dungeon setDungeon:sender.tag];
    
    if(![player minusStaimna:[dungeon getStamina]]){
        // 体力足りない場合
        NSLog(@"体力足りない"); // ドリンクを買いに行きますか？
        return;
    }
    DungeonViewController *dvc = [[DungeonViewController alloc] init];
    [dvc setPlayer:player];
    [dvc setDungeon:dungeon];
    [self presentViewController:dvc animated:NO completion:nil];
}

- (void)cancelOpenDungeon:(UIButton *)sender{
    NSLog(@"%s", __func__);
    [[sender superview] removeFromSuperview];
}

/**********************************************************************
 * 名刺召喚関係
 **********************************************************************/

- (void)viewSummon:(id)sender{
    // 今映ってるのを除去
    if(nowScrollView) [nowScrollView removeFromSuperview];
    NSLog(@"MBViewController: viewSummon");
    // ビューの準備
    MBScrollView *summonView = [[MBScrollView alloc] initWithPlayer:player];
    [[self view] addSubview:summonView];
    [summonView setTitle:@"名刺召喚"];
    nowScrollView = summonView;
    
    // カメラ起動ボタン
    UIButton *camera_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [camera_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    camera_button.titleLabel.font = [UIFont fontWithName:@"mikachan_o" size:20];
    camera_button.frame = CGRectMake(30, 80, 260, 40);
    
    // 注意書きラメル
    UILabel *alert_label = [[UILabel alloc] initWithFrame:CGRectMake(15, 140, 300, 100)];
    alert_label.numberOfLines = 5;
    [summonView addSubview:alert_label];
    // ここでカメラが起動できるか確認
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        /* キャラクターがいっぱいかどうか確認が必要
         * 「すでにあるキャラと入れ替える必要がありますがよろしいですか？
         * 　はい　いいえ
         * 　キャラ上限増加（有料）」
         * みたいな */
        if([player isMeishiFull]){
            // 名刺が一杯の場合
            camera_button.backgroundColor = [UIColor colorWithRed:1.0 green:0.6 blue:0.6 alpha:1.0];
            [camera_button setTitle:@"名刺がいっぱいです" forState:UIControlStateNormal];
            alert_label.text = @"新たに名刺からバトラーを召喚したい場合は、Statusから、バトラーを解雇してください。";
        }else{
            camera_button.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:1.0 alpha:1.0];
            [camera_button setTitle:@"カメラ起動" forState:UIControlStateNormal];
            [camera_button addTarget:self action:@selector(launchCamera:)forControlEvents:UIControlEventTouchUpInside];
            alert_label.text = @"文字認識を行いますので、名刺をカメラと平行に持って、明るい場所で撮影してください。\n画像認識には少々時間がかかります。";
        }
    }else{
        camera_button.backgroundColor = [UIColor colorWithRed:1.0 green:0.6 blue:0.6 alpha:1.0];
        [camera_button setTitle:@"カメラ非対応なデバイスです" forState:UIControlStateNormal];
        alert_label.text = @"お使いのデバイスはカメラががついていません。\n申し訳ありませんが名刺の召喚は行えません。";
    }
    [summonView addSubview:camera_button];
    
    // デバッグ用
    /*
    UIButton *rand_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    rand_button.frame = CGRectMake(30, 140, 260, 40);
    [rand_button setTitle:@"ランダム名刺召喚" forState:UIControlStateNormal];
    [rand_button addTarget:self action:@selector(randMeishi:)forControlEvents:UIControlEventTouchUpInside];
    [summonView addSubview:rand_button];
    
    // OCRテスト（デバッグ用）ボタン
    UIButton *test_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    test_button.frame = CGRectMake(30, 200, 260, 40);
    [test_button setTitle:@"OCRテスト" forState:UIControlStateNormal];
    [test_button addTarget:self action:@selector(ocrTest:)forControlEvents:UIControlEventTouchUpInside];
    [summonView addSubview:test_button];
    
    UILabel *test_label = [[UILabel alloc] initWithFrame:CGRectMake(30, 240, 260, 50)];
    test_label.numberOfLines = 2;
    test_label.text = @"少し処理に時間がかかります。連打しないでください。";
    [summonView addSubview:test_label];
     */
}

// OCRテスト（デバッグ用）
- (void)ocrTest:(id)sender{
    UIImage *img = [UIImage imageNamed:@"IMG_2810.JPG"];
    
    // ぐるぐる表示
    [SVProgressHUD show];
    
    OcrViewController *ocr_vc = [[OcrViewController alloc] initWithPlayer:player OCRImage:img];
    
    // ぐるぐる終わり
    [SVProgressHUD dismiss];
    [self presentViewController:ocr_vc animated:NO completion:nil];
}

// ランダムキャラ生成（デバッグ用）
- (void)randMeishi:(id)sender{
    NSLog(@"randMeishi");
    Meishi *m = [[Meishi alloc] init];
    [m setName:@"ランダム君"];
    [m setLv:5];
    [m setSex:rand()%2];
    [m setJob: rand()%4];
    int ind[6] = {rand()%32, rand()%32, rand()%32, rand()%32, rand()%32, rand()%32};
    [m setIndividual:ind];
    [m calcParameter];
    [m setExp:0];
    [player addMeishi:m];
    
    [self summonMeishi:m];
}

// カメラの起動
- (void)launchCamera:(id)sender{
    NSLog(@"laubch camera");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera]; // カメラモード(SAダウン Cアップ)
    [self presentViewController:picker animated:YES completion:nil];
}

// カメラで撮影したあと
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // picker から画像を取得する。
    UIImage *camera_img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // picker を閉じる
    NSLog(@"close Picker");
    //[picker dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];

    // ぐるぐる表示
    // [SVProgressHUD show];
    
    // OCRにかける
    NSLog(@"launch OCR");
    OcrViewController *ocr_vc = [[OcrViewController alloc] initWithPlayer:player OCRImage:camera_img];
    [self presentViewController:ocr_vc animated:NO completion:nil];
    // [SVProgressHUD dismiss];
}

// 名刺召喚のエフェクト等表示
- (void)summonMeishi:(Meishi *)meishi{
    NSLog(@"summonMeishi show Effect");
    SummonViewController *view = [[SummonViewController alloc] init];
    [view setMeishi:meishi];
    [self presentViewController:view animated:NO completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
