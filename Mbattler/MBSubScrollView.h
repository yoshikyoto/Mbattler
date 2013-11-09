//
//  MBSubScrollView.h
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/11/09.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBSubScrollView : UIScrollView

@property(readwrite) UILabel *titleLabel;

- (void)setTitle:(NSString *)title;
- (void)setTitleLabel;

@end
