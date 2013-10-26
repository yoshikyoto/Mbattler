//
//  ViewController.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/03/09.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "ViewController.h"
#import "Meishi.h"
#import "Player.h"
#import "MBViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.95 blue:0.8 alpha:0.9];
    
    // プレイヤーオブジェクトの初期化
    // セーブデータがあるかどうかで分岐させる
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if([ud stringForKey:@"PLAYER_NAME"]){
        NSLog(@"%s セーブデータをロードします", __func__);
        player = [[Player alloc] initWithTestdata];
        
        UILabel *title = [[UILabel alloc] init];
        title.frame = CGRectMake(60, 30, 200, 50);
        title.font = [UIFont systemFontOfSize:24];
        title.text = @"名刺バトラー";
        title.textAlignment = NSTextAlignmentCenter;
        [[self view] addSubview:title];
        
        UILabel *touchstart = [[UILabel alloc] init];
        touchstart.frame = CGRectMake(60, 160, 200, 50);
        touchstart.text = @"TOUCH START";
        touchstart.textAlignment = NSTextAlignmentCenter;
        [[self view] addSubview:touchstart];
        
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(start:)];
        [[self view] addGestureRecognizer:tgr];
        
    }else{
        NSLog(@"%s 初回起動", __func__);
        //player = [[Player alloc] initWithName:@"ヨシキ"];
        
        UILabel *alert = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 50)];
        alert.numberOfLines = 2;
        alert.text = @"まずはあなたの名前を\n入力してください";
        alert.font = [UIFont fontWithName:@"mikachan_o" size:16];
        alert.textAlignment = NSTextAlignmentCenter;
        [[self view] addSubview:alert];
        
        // 名前入力フィールド
        name_textfield = [[UITextField alloc] initWithFrame:CGRectMake(60, 100, 200, 30)];
        name_textfield.borderStyle = UITextBorderStyleRoundedRect;
        name_textfield.placeholder = @"なまえ";
        name_textfield.clearButtonMode = UITextFieldViewModeUnlessEditing;
        name_textfield.returnKeyType = UIReturnKeyDefault;
        name_textfield.delegate = self;
        [[self view] addSubview:name_textfield];
        
        // 決定ボタン
        UIButton *confirm_button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [confirm_button setTitle:@"OK!" forState:UIControlStateNormal];
        confirm_button.frame = CGRectMake(80, 150, 160, 40);
        confirm_button.titleLabel.font = [UIFont fontWithName:@"mikachan_o" size:16];
        confirm_button.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:1.0 alpha:0.8];
        [confirm_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        [confirm_button addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchDown];
        [[self view] addSubview:confirm_button];
    }
}

- (void)confirm:(id)sender{
    NSLog(@"%s", __func__);
    if(name_textfield.text.length > 0){
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.delegate = self;
        alert.title = @"これでよろしいですか？";
        alert.message = @"一度決めた名前は変えられません";
        [alert addButtonWithTitle:@"はい"];
        [alert addButtonWithTitle:@"いいえ"];
        [alert show];
    }else{
        // 複数行で書くタイプ（１ボタンタイプ）
        UIAlertView *alert = [[UIAlertView alloc] init];
        alert.title = @"名前を入力してください";
        alert.message = @"名前が入力されていません";
        [alert addButtonWithTitle:@"もどる"];
        [alert show];
    }
}

-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0){
        player = [[Player alloc] initWithName:name_textfield.text];
        MBViewController *mbvc = [[MBViewController alloc] initWithPlayer:player];
        [self presentViewController:mbvc animated:NO completion:nil];
    }
}

- (void)start:(UITapGestureRecognizer *)sender{
    MBViewController *mbvc = [[MBViewController alloc] initWithPlayer:player];
    [self presentViewController:mbvc animated:NO completion:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


