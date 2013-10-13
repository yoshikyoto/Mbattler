//
//  UIOutlineLabel.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/10/12.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "UIOutlineLabel.h"

@implementation UIOutlineLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect
{
    CGSize shadowOffset = self.shadowOffset;
    UIColor *txtColor = self.textColor;
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(contextRef, _OutlineWidth);
    CGContextSetLineJoin(contextRef, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(contextRef, kCGTextStroke);
    self.textColor = _OutlineColor;
    [super drawTextInRect:CGRectInset(rect, _OutlineWidth, _OutlineWidth)];
    
    CGContextSetTextDrawingMode(contextRef, kCGTextFill);
    self.textColor = txtColor;
    [super drawTextInRect:CGRectInset(rect, _OutlineWidth, _OutlineWidth)];
    
    self.shadowOffset = shadowOffset;
}

- (void)setCharacterName:(NSString *)name{
    [self setOutlineColor:[UIColor whiteColor]];
    [self setOutlineWidth:3];
    self.textAlignment = NSTextAlignmentCenter;
    self.font = [UIFont systemFontOfSize:10];
    self.text = name;
    self.backgroundColor = [UIColor clearColor];
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
