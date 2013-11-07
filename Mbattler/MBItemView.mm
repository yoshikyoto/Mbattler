//
//  MBItemView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBItemView.h"
#import "MBButton.h"

@implementation MBItemView

- (id)initWithPlayer:(Player *)p
{
    self = [super initWithPlayer:p];
    if (self) {
        // Initialization code
        
        // タイトル
        title.text = @"アイテム";
        [self addSubview:title];
        
        // 所持アイテム描写
        [self drawMyitem];
        [self drawShop];
        
        now_item_desc_view = [[UIScrollView alloc] init];
        now_item_desc_view.tag = -1;
    }
    return self;
}

- (void)drawMyitem{
    // パーティ部分のビュー
    if(myitem_view) [myitem_view removeFromSuperview];
    
    myitem_view = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 52, 300, 90)];
    myitem_view.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.2];
    [self addSubview:myitem_view];
    
    UILabel *myitem_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 26)];
    myitem_label.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.5];
    [myitem_label setTextColor:[UIColor whiteColor]];
    myitem_label.textAlignment = NSTextAlignmentCenter;
    myitem_label.font = [UIFont fontWithName:@"mikachan_o" size:16];
    myitem_label.text = @"所持アイテム";
    [myitem_view addSubview:myitem_label];
    
    
    int item_position_x = 10;
    
    // アイテム　スタミナ回復剤
    item0_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [item0_button setBackgroundImage:[UIImage imageNamed:@"stamina.png"] forState:UIControlStateNormal];
    item0_button.frame = CGRectMake(item_position_x, 36, 44, 44);
    item0_button.tag = 0;
    [item0_button addTarget:self action:@selector(itemTapped:) forControlEvents:UIControlEventTouchUpInside];
    [myitem_view addSubview:item0_button];
    
    item0_label = [[UIOutlineLabel alloc] init];
    [item0_label setTitle:[NSString stringWithFormat:@"x%d",[player getNumOfItem:0]]];
    item0_label.frame = CGRectMake(item_position_x, 66, 44, 14);
    item0_label.textAlignment = NSTextAlignmentRight;
    item0_label.font = [UIFont systemFontOfSize:14];
    [myitem_view addSubview:item0_label];
    
    item_position_x += 54;
    
    
    // アイテム　薬草
    item1_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [item1_button setBackgroundImage:[UIImage imageNamed:@"yakusou.png"] forState:UIControlStateNormal];
    item1_button.frame = CGRectMake(item_position_x, 36, 44, 44);
    item1_button.tag = 1;
    [item1_button addTarget:self action:@selector(itemTapped:) forControlEvents:UIControlEventTouchUpInside];
    [myitem_view addSubview:item1_button];
    
    item1_label = [[UIOutlineLabel alloc] init];
    [item1_label setTitle:[NSString stringWithFormat:@"x%d",[player getNumOfItem:1]]];
    item1_label.frame = CGRectMake(item_position_x, 66, 44, 14);
    item1_label.textAlignment = NSTextAlignmentRight;
    item1_label.font = [UIFont systemFontOfSize:14];
    [myitem_view addSubview:item1_label];
    
    item_position_x += 54;
    
    
    
    // アイテム　果実
    item2_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [item2_button setBackgroundImage:[UIImage imageNamed:@"ringo.png"] forState:UIControlStateNormal];
    item2_button.frame = CGRectMake(item_position_x, 36, 44, 44);
    item2_button.tag = 2;
    [item2_button addTarget:self action:@selector(itemTapped:) forControlEvents:UIControlEventTouchUpInside];
    [myitem_view addSubview:item2_button];
    
    item2_label = [[UIOutlineLabel alloc] init];
    [item2_label setTitle:[NSString stringWithFormat:@"x%d",[player getNumOfItem:2]]];
    item2_label.frame = CGRectMake(item_position_x, 66, 44, 14);
    item2_label.textAlignment = NSTextAlignmentRight;
    item2_label.font = [UIFont systemFontOfSize:14];
    [myitem_view addSubview:item2_label];
    
    item_position_x += 54;
}

- (void)drawShop{
    /*
    UIScrollView *shop_view = [[UIScrollView alloc] init];
    shop_view.frame = CGRectMake(10, 105, 300, 300);
    shop_view.backgroundColor = sub_bg;
    [self addSubview:shop_view];
     */
}

- (void)itemTapped:(UIButton *)sender{
    NSLog(@"%s", __func__);
    [now_item_desc_view removeFromSuperview];
    if(now_item_desc_view.tag == sender.tag){
        now_item_desc_view.tag = -1;
        return;
    }

    // アイテム説明表示部分
    now_item_desc_view = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 150, 300, 180)];
    now_item_desc_view.tag = sender.tag;
    now_item_desc_view.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.2];
    [self addSubview:now_item_desc_view];
    
    UIImageView *item_image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 44, 44)];
    
    UILabel *item_name_label = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 44)];
    item_name_label.font = [UIFont fontWithName:@"mikachan_o" size:20];
    
    UILabel *item_desc_label = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 260, 70)];
    item_desc_label.font = [UIFont systemFontOfSize:14]; // [UIFont fontWithName:@"mikachan_o" size:16];
    item_desc_label.numberOfLines = 5;
    
    /*
    close_button.frame = CGRectMake(100, 145, 100, 30);
    close_button.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.5];
    [close_button setTitle:@"× とじる" forState:UIControlStateNormal];
    close_button.titleLabel.font = [UIFont fontWithName:@"mikachan_o" size:16];
    [close_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [close_button addTarget:self action:@selector(itemTapped:) forControlEvents:UIControlEventTouchUpInside];
     */
    MBButton *close_button = [MBButton buttonWithType:UIButtonTypeCustom];
    close_button.frame = CGRectMake(75, 140, 150, 40);
    [close_button setColorType:0];
    close_button.tag = sender.tag;
    [close_button setText:@"× とじる"];
    [close_button addTarget:self action:@selector(itemTapped:) forControlEvents:UIControlEventTouchUpInside];
    [now_item_desc_view addSubview:close_button];
    
    switch (sender.tag) {
        case 0:{
            [item_image setImage:[UIImage imageNamed:@"stamina.png"]];
            item_name_label.text = @"スタミナ回復剤";
            item_desc_label.text = @"スタミナを全回復します。";
            // 使うボタン
            MBButton *use_button = [MBButton buttonWithType:UIButtonTypeRoundedRect];
            [use_button setColorType:1];
            [use_button setText:@"つかう"];
            [use_button addTarget:self action:@selector(staminaItemTapped:) forControlEvents:UIControlEventTouchUpInside];
            use_button.frame = CGRectMake(0, 140, 150, 40);
            [now_item_desc_view addSubview:use_button];
            // 閉じるボタン
            [close_button setColorType:2];
            close_button.frame = CGRectMake(151, 140, 149, 40);
            break;
        }
        case 1:
            [item_image setImage:[UIImage imageNamed:@"yakusou.png"]];
            item_name_label.text = @"薬草";
            item_desc_label.text = @"戦闘中にアイテムをタップした後に、味方をタップして使用できます。\n味方一人のHPを全回復します。";
            break;
        case 2:
            [item_image setImage:[UIImage imageNamed:@"ringo.png"]];
            item_name_label.text = @"復活の果実";
            item_desc_label.text = @"戦闘中にアイテムをタップした後に、味方をタップして使用できます。\n味方一人を瀕死の状態から、HP最大値の半分まで回復します。";
            break;
    }
    [now_item_desc_view addSubview:item_image];
    [now_item_desc_view addSubview:item_name_label];
    [now_item_desc_view addSubview:item_desc_label];
}

// スタミナ回復薬の使用がタップされたとき
- (void)staminaItemTapped:(id)sender{
    NSLog(@"%s", __func__);
    // 使うかどうかのアラートを表示させる
    UIAlertView *alert = [[UIAlertView alloc] init];
    if([player getStamina] >= 50){
        alert.title = @"スタミナは全快です";
        [alert addButtonWithTitle:@"とじる"];
    }else{
        alert.title = @"スタミナ回復剤を使います";
        alert.message = @"よろしいですか";
        alert.delegate = self;
        [alert addButtonWithTitle:@"はい"];
        [alert addButtonWithTitle:@"いいえ"];
    }
    [alert show];
}

-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 0){
        [player useStaminaItem];
        [self drawMyitem];
        [now_item_desc_view removeFromSuperview];
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
