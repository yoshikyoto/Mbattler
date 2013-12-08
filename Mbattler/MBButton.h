//
//  MBButton.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/10/18.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBItemButton.h"

@interface MBButton : UIButton

- (id)initWithFrame:(CGRect)frame colorType:(int)type;
-(void)setText:(NSString *)text;
-(void)setColorType:(int)type;


- (void)setShopName:(NSString *)desc;
- (void)setItemImage:(NSString *)name num:(int)num;

@end
