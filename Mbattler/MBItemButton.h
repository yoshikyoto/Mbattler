//
//  MBItemButton.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/11/09.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIOutlineLabel.h"

@interface MBItemButton : UIButton

@property(readwrite) UIOutlineLabel *label;
@property(readwrite) UILabel *descLabel;

- (void)setItem:(int)itemID;

@end
