//
//  NT_LatefeeTongjChVC.h
//  Hpi-FDS
//
//  Created by bin tang on 12-8-2.
//  Copyright (c) 2012年 Landscape. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "ChooseView.h"
#import "PubInfo.h"
#import "DataGridComponent.h"
#import "DateViewController.h"
#import "TBXMLParser.h"
#import "ChooseViewDelegate.h"
#import "MultiTitleDataGridComponent.h"

@interface NT_LatefeeTongjChVC : UIViewController<UIPopoverControllerDelegate,ChooseViewDelegate>
{
UIPopoverController *popover;
UIButton *factoryCateButton;
UILabel *factoryCateLable;
UIButton *startButton;
UILabel *startTime;
UIButton *endButton;
UILabel *endTime;
  UIActivityIndicatorView *activty;
    UIButton *reload;

    ChooseView *chooseView;
    
    DateViewController *monthVC; 
    
    id parentVC;
     TBXMLParser *xmlParser;
    NSDate *month;
    
}
@property (retain, nonatomic)NSDate *month;
@property (retain, nonatomic) TBXMLParser *xmlParser;

@property (retain, nonatomic) id parentVC;  

@property (retain, nonatomic) DateViewController *monthVC;

@property (retain, nonatomic)ChooseView *chooseView;

@property (retain, nonatomic)UIPopoverController *popover;

  @property (retain, nonatomic)  IBOutlet UIButton *reload;
@property (retain, nonatomic) IBOutlet UIButton *factoryCateButton;

@property (retain, nonatomic) IBOutlet UILabel *factoryCateLable;
@property (retain, nonatomic) IBOutlet UIButton *startButton;

@property (retain, nonatomic) IBOutlet UILabel *startTime;

@property (retain, nonatomic) IBOutlet UIButton *endButton;

@property (retain, nonatomic) IBOutlet UILabel *endTime;


@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activty;





@end
