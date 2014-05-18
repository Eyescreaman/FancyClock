//
//  MyFancyClockView.h
//  TrainingTest
//
//  Created by angelflame on 14/5/9.
//  Copyright (c) 2014年 angelflame. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFancyClockView : UIView

@property (strong, nonatomic)  UIImageView  *mCenterView;
@property (strong, nonatomic)  UIView       *mHourhandView;
@property (strong, nonatomic)  UIView       *mMinutehandView;
@property (strong, nonatomic)  UIView       *mSecondhandView;

-(void)initWithImageNameArray:(NSMutableArray*)mImage;
-(void)startClockAnimation;
@end
