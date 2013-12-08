//
//  MBButton.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/10/18.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBButton.h"

@implementation MBButton

- (id)initWithFrame:(CGRect)frame colorType:(int)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [UIButton buttonWithType:UIButtonTypeCustom];
        self.frame = frame;
        // [self setTitle:@"GO!" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:@"mikachan_o" size:16];
        self.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.5];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setColorType:type];
    }
    return self;
}

-(void)setText:(NSString *)text{
    [self setTitle:text forState:UIControlStateNormal];
}

-(void)setColorType:(int)type{
    self.titleLabel.font = [UIFont fontWithName:@"mikachan_o" size:16];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    switch (type) {
        case 1:
            self.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:1.0 alpha:0.8];
            break;
            
        case 2:
            self.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.5 alpha:0.8];
            break;
            
        default:
            self.backgroundColor = [UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.5];
            break;
    }
}

- (void)setShopName:(NSString *)desc{
    // UIButton *dungeon_button = [UIButton buttonWithType:UIButtonTypeCustom];
    // self.frame = CGRectMake(10, 5 + 58*i, 300, 50);
    // dungeon_button.tag = i;
    // [dungeon_button addTarget:self action:@selector(dungeonTouched:)forControlEvents:UIControlEventTouchUpInside];
    self.backgroundColor = [UIColor colorWithRed:1.0 green:0.95 blue:0.8 alpha:0.9];
    [[self layer] setBorderWidth:2.0];
    [[self layer] setCornerRadius:6.0];
    [[self layer] setBorderColor:[[UIColor colorWithRed:0.6 green:0.3 blue:0.05 alpha:0.8] CGColor]];
    // [self setTitle:desc forState:UIControlStateNormal];
    // [self.titleLabel setFont:[UIFont fontWithName:@"azukifontL" size:14]];
    // self.titleLabel.textColor = [UIColor blackColor];
    // [dungeonView.dungeonListView addSubview:dungeon_button];
    
    UILabel *desc_label = [[UILabel alloc] initWithFrame:CGRectMake(52, 0, 280, 50)];
    //_descLabel.numberOfLines = 2;
    desc_label.text = desc;
    desc_label.font = [UIFont fontWithName:@"uzura_font" size:14];
    desc_label.textColor = [UIColor colorWithRed:0.1 green:0.05 blue:0.01 alpha:1.0];
    desc_label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:desc_label];
    
    UIImageView *item_view = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 48, 48)];
    if([desc rangeOfString:@"スタミナ回復剤"].location != NSNotFound){
        [item_view setImage:[UIImage imageNamed:@"stamina.png"]];
    }else if([desc rangeOfString:@"薬草"].location != NSNotFound){
        [item_view setImage:[UIImage imageNamed:@"yakusou.png"]];
    }else if([desc rangeOfString:@"復活の果実"].location != NSNotFound){
        [item_view setImage:[UIImage imageNamed:@"ringo.png"]];
    }else if([desc rangeOfString:@"名刺所持上限"].location != NSNotFound){
        [item_view setImage:[UIImage imageNamed:@"stamina.png"]];
    }
    [self addSubview:item_view];
    
    UIOutlineLabel *item_num_label = [[UIOutlineLabel alloc] init];
    item_num_label.frame = CGRectMake(0, 34, 44, 14);
    item_num_label.textAlignment = NSTextAlignmentRight;
    item_num_label.font = [UIFont systemFontOfSize:14];
    [self addSubview:item_num_label];
    
    NSRange num_range = [desc rangeOfString:@"[+0-9]+" options:NSRegularExpressionSearch];
    if(num_range.location != NSNotFound){
        [item_num_label setTitle:[desc substringWithRange:num_range]];
    }
    
    /* 正規表現サンプル
     NSRange tel_range = [str rangeOfString:@"\\d+-\\d+-\\d+" options:NSRegularExpressionSearch];
     if (tel_range.location != NSNotFound) {
     // 見つかった場合
     NSString *tel_string = [str substringWithRange:tel_range];
     }
     */
    
    /*
     [dungeon setDungeon:i];
     UILabel *dungeon_stamina_label = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 100, 25)];
     dungeon_stamina_label.text = [NSString stringWithFormat:@"消費スタミナ: %d", [dungeon getStamina]];
     dungeon_stamina_label.font = [UIFont fontWithName:@"azukifontL" size:12];
     dungeon_stamina_label.textColor = [UIColor colorWithRed:0.1 green:0.05 blue:0.01 alpha:1.0];
     [dungeon_button addSubview:dungeon_stamina_label];
     */
}

- (void)setItemValue:(int)value{
    
}

- (void)setItemImage:(NSString *)name num:(int)num{
    UIImageView *item_view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    item_view.frame = CGRectMake(1, 1, 48, 48);
    [self addSubview:item_view];
    
    UIOutlineLabel *item_num_label = [[UIOutlineLabel alloc] init];
    [item_num_label setTitle:[NSString stringWithFormat:@"x%d",num]];
    item_num_label.frame = CGRectMake(0, 34, 44, 14);
    item_num_label.textAlignment = NSTextAlignmentRight;
    item_num_label.font = [UIFont systemFontOfSize:14];
    [self addSubview:item_num_label];
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
