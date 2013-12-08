//
//  MBItemView.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/08/10.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBItemView.h"
#import "MBButton.h"
#import "MBMassageLabel.h"

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
        
        now_item_desc_view = [[MBMassageLabel alloc] init];
        now_item_desc_view.tag = -1;
    }
    return self;
}

- (void)drawMyitem{
    NSLog(@"%s", __func__);
    // 所持アイテム部分のビュー
    if(myitem_view) [myitem_view removeFromSuperview];
    
    myitem_view = [[MBSubScrollView alloc] initWithFrame:CGRectMake(320, 50, 300, 90)];
    [myitem_view setTitle:@"所持アイテム"];    [self addSubview:myitem_view];
    int item_position_x = 10;
    
    // アイテム　スタミナ回復剤
    item0_button = [MBItemButton buttonWithType:UIButtonTypeCustom];
    [item0_button setItem:0];
    item0_button.frame = CGRectMake(item_position_x, 36, 44, 44);
    [item0_button addTarget:self action:@selector(itemTapped:) forControlEvents:UIControlEventTouchUpInside];
    [myitem_view addSubview:item0_button];
    
    item_position_x += 54;
    
    
    // アイテム　薬草
    item1_button = [MBItemButton buttonWithType:UIButtonTypeCustom];
    [item1_button setItem:1];
    item1_button.frame = CGRectMake(item_position_x, 36, 44, 44);
    [item1_button addTarget:self action:@selector(itemTapped:) forControlEvents:UIControlEventTouchUpInside];
    [myitem_view addSubview:item1_button];
    
    item_position_x += 54;
    
    
    // アイテム　果実
    /*
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
     */
    
    item2_button = [MBItemButton buttonWithType:UIButtonTypeCustom];
    [item2_button setItem:2];
    item2_button.frame = CGRectMake(item_position_x, 36, 44, 44);
    [item2_button addTarget:self action:@selector(itemTapped:) forControlEvents:UIControlEventTouchUpInside];
    [myitem_view addSubview:item2_button];
    
    
    item_position_x += 54;
}

- (void)drawShop{
    NSLog(@"%s", __func__);
    shop_view = [[MBSubScrollView alloc] initWithFrame:CGRectMake(10, 500, 300, self.frame.size.height - 150)];
    [shop_view setTitle:@"ショップ"];
    [self addSubview:shop_view];
    
    NSSet *item_set = [NSSet setWithObjects:
                       @"MbattlerStamina1x",
                       @"MbattlerStamina6x",
                       @"MbattlerStamina15x",
                       @"MbattlerYakusou10x",
                       @"MbattlerRingo1x",
                       @"MbattlerRingo6x",
                       @"MbattlerRingo15x",
                       @"MbattlerMeishi10x",
                       @"MbattlerMeishi20x",
                       nil];
    SKProductsRequest *products_request = [[SKProductsRequest alloc] initWithProductIdentifiers:item_set];
    products_request.delegate = self;
    [products_request start];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    products = response.products;
    NSLog(@"%s アイテム数: %d", __func__, [products count]);
    if([response.invalidProductIdentifiers count] > 0){
        NSLog(@"%s アイテムがうまく取得できませんでした", __func__);
    }else{
        // これが上の余白になる。
        int position_y = 30;
        
        /*
        NSArray *item_name_array = [[NSMutableArray alloc] initWithObjects:
                                    @"スタミナ回復剤1個",
                                    @"スタミナ回復剤5+1個セット",
                                    @"スタミナ回復剤10+5個セット",
                                    @"薬草10個セット",
                                    @"復活の果実1個",
                                    @"復活の果実5+1個セット",
                                    @"復活の果実10+5個セット",
                                    @"名刺所持上限+10",
                                    @"名刺所持上限+20",
                                    nil];
        */
        
        for(int i = 0; i < [products count]; i++){
            SKProduct *product = [products objectAtIndex:i];
            NSString *item_name = product.localizedTitle; //[item_name_array objectAtIndex:i];
            MBButton *shop_button = [MBButton buttonWithType:UIButtonTypeCustom];
            shop_button.frame = CGRectMake(5, position_y, 290, 50);
            [shop_button setShopName:item_name];
            //[shop_button setItemImage:@"stamina.png" num:1];
            shop_button.tag = i;
            [shop_button addTarget:self action:@selector(shopButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [shop_view addSubview:shop_button];
            position_y += 60;
        }
        
        position_y += 20;
        shop_view.contentSize = CGSizeMake(300, position_y);
    }
    

}

- (void)shopButtonTapped:(UIButton *)sender{
    NSLog(@"%s, 購入処理 %d番のアイテム", __func__, sender.tag);
    buying_item_int = sender.tag;
    SKProduct *product = [products objectAtIndex:sender.tag];
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    NSLog(@"%@", product.localizedTitle);
}


- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        if(transaction.transactionState == SKPaymentTransactionStatePurchasing){
            NSLog(@"%s 購入処理中", __func__);
        }else if(transaction.transactionState == SKPaymentTransactionStatePurchased){
            NSLog(@"%s 購入処理完了", __func__);
            [self buyItem];
            [queue finishTransaction:transaction];
        }else if(transaction.transactionState == SKPaymentTransactionStateFailed){
            NSLog(@"%s 購入処理失敗", __func__);
            [queue finishTransaction:transaction];
        }else{
            NSLog(@"%s リストア処理完了", __func__);
            [queue finishTransaction:transaction];
        }
    }
}

- (void)buyItem{
    NSLog(@"%s アイテム購入完了処理", __func__);
    
}

- (MBMassageLabel *)makeShopLabel:(NSString *)itemName :(NSString *)itemDesc :(CGRect)frame{
    MBMassageLabel *shop_item_label = [[MBMassageLabel alloc] initWithFrame:frame];
    return shop_item_label;
}

- (void)itemTapped:(UIButton *)sender{
    NSLog(@"%s", __func__);
    [now_item_desc_view removeFromSuperview];
    if(now_item_desc_view.tag == sender.tag){
        now_item_desc_view.tag = -1;
        return;
    }

    // アイテム説明表示部分
    now_item_desc_view = [[MBMassageLabel alloc] initWithFrame:CGRectMake(10, 150, 300, 180)];
    now_item_desc_view.tag = sender.tag;
    now_item_desc_view.backgroundColor = [UIColor colorWithRed:1.0 green:0.9 blue:0.8 alpha:1.0];
    [self addSubview:now_item_desc_view];
    
    UIImageView *item_image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 44, 44)];
    
    UILabel *item_name_label = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 44)];
    item_name_label.font = [UIFont fontWithName:@"mikachan_o" size:20];
    
    UILabel *item_desc_label = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 260, 70)];
    item_desc_label.font = [UIFont systemFontOfSize:14]; // [UIFont fontWithName:@"mikachan_o" size:16];
    item_desc_label.numberOfLines = 5;
    
    
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

- (void)startAnimation{
    //アニメーションの対象となるコンテキスト
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    //アニメーションを実行する時間
    [UIView setAnimationDuration:0.2];
    //アニメーションイベントを受け取るview
    [UIView setAnimationDelegate:self];
    //アニメーション終了後に実行される
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    
    title.frame = CGRectMake(-5, 4, 310, 40);
    myitem_view.frame = CGRectMake(10, 50, 300, 90);
    shop_view.frame = CGRectMake(10, 145, 300, self.frame.size.height - 150);
    
    // アニメーション開始
    [UIView commitAnimations];
}

- (void)endAnimation{
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
