//
//  MBAbilityCutin.m
//  Mbattler
//
//  Created by Yoshiyuki Sakamoto on 2013/10/03.
//  Copyright (c) 2013年 Mbattler. All rights reserved.
//

#import "MBAbilityCutin.h"

@implementation MBAbilityCutin

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithMeishi:(Meishi *)meishi{
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 80, 320, 80);
        self.backgroundColor = [UIColor blackColor];
        
        UIImageView *view = [[UIImageView alloc] initWithImage:[meishi getIcon]];
        view.frame = CGRectMake(20, 0, 80, 80);
        [self addSubview:view];
        
        UILabel *name = [[UILabel alloc] init];
        name.text = [meishi getAbilityString];
        name.frame = CGRectMake(120, 20, 200, 40);
        name.textColor = [UIColor whiteColor];
        [self addSubview:name];
    }
    return self;
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
