//
//  FactoryFreightVolumeVC.m
//  Hpi-FDS
//  电厂运力运量统计
//  Created by 馬文培 on 12-7-31.
//  Copyright (c) 2012年 Landscape. All rights reserved.
//

#import "FactoryFreightVolumeVC.h"
@interface FactoryFreightVolumeVC ()

@end

@implementation FactoryFreightVolumeVC

@synthesize tradeButton;
@synthesize tradeLabel;
@synthesize typeButton;
@synthesize typeLabel;
@synthesize activity;
@synthesize reloadButton;
@synthesize queryButton;
@synthesize resetButton;
@synthesize popover,chooseView,multipleSelectView,parentVC;
@synthesize buttonView=_buttonView;
//@synthesize labelView;
@synthesize listArray;
@synthesize listView;
@synthesize startDateCV=_startDateCV;
@synthesize endDateCV=_endDateCV;
@synthesize startDay=_startDay;
@synthesize endDay=_endDay;
@synthesize tbxmlParser;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tradeLabel.hidden=YES;
    self.typeLabel.hidden=YES;
    self.typeLabel.text=All_;
    self.tradeLabel.text=All_;
    [activity removeFromSuperview];
    self.tbxmlParser =[[TBXMLParser alloc] init];
    
    self.endDay = [[[NSDate alloc] init] autorelease];
    
    //本年度的一个月
    NSDateComponents *comp = [[[NSDateComponents alloc]init] autorelease];
    [comp setMonth:1];
    NSDateFormatter *yearFormatter =[[NSDateFormatter alloc] init];
    [yearFormatter setDateFormat:@"yyyy"];
    [comp setYear:[[yearFormatter stringFromDate:[NSDate date]] integerValue]];
    NSCalendar *myCal = [[[NSCalendar alloc ]    initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    [yearFormatter release];
    self.startDay=[myCal dateFromComponents:comp] ;
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    [_endButton setTitle:[dateFormatter stringFromDate:_endDay] forState:UIControlStateNormal];
    [_startButton setTitle:[dateFormatter stringFromDate:_startDay] forState:UIControlStateNormal];
    //[dateFormatter release];
    
    listView.layer.masksToBounds=YES;
    listView.layer.cornerRadius=2.0;
    listView.layer.borderWidth=2.0;
    listView.layer.borderColor=[[UIColor colorWithRed:50.0/255 green:50.0/255 blue:50.0/255 alpha:1]CGColor];
    listView.backgroundColor=[UIColor colorWithRed:39.0/255 green:39.0/255 blue:39.0/255 alpha:1];
        
    _buttonView.layer.masksToBounds=YES;
    _buttonView.layer.cornerRadius=2.0;
    _buttonView.layer.borderWidth=2.0;
    _buttonView.layer.borderColor=[UIColor blackColor].CGColor;
    _buttonView.backgroundColor=[UIColor colorWithRed:35.0/255 green:35.0/255 blue:35.0/255 alpha:1];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.startDay=nil;
    self.endDay=nil;
    self.startDateCV=nil;
    self.endDateCV=nil;
    [self setTradeButton:nil];
    [self setTradeLabel:nil];
    [self setTypeButton:nil];
    [self setTypeLabel:nil];
    [self setQueryButton:nil];
    [self setResetButton:nil];
    [self setReloadButton:nil];
    [self setActivity:nil];
    self.tbxmlParser=nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
- (void)dealloc {
    [tradeButton release];
    [tradeLabel release];
    [queryButton release];
    [resetButton release];
    [popover release];
    [reloadButton release];
    [activity release];
    self.tbxmlParser=nil;
    [_startButton release];
    [_startDateCV release];
    [_startDay release];
    [_endButton release];
    [_endDateCV release];
    [_endDay release];
    [super dealloc];
}
-(IBAction)startDate:(id)sender
{
    NSLog(@"startDate");
    if (self.popover.popoverVisible) {
        [self.popover dismissPopoverAnimated:YES];
    }
    
    if(!_startDateCV)//初始化待显示控制器
        _startDateCV=[[DateViewController alloc]init];
    //设置待显示控制器的范围
    [_startDateCV.view setFrame:CGRectMake(0,0, 195, 216)];
    //设置待显示控制器视图的尺寸
    _startDateCV.contentSizeForViewInPopover = CGSizeMake(195, 216);
    //初始化弹出窗口
    UIPopoverController* pop = [[UIPopoverController alloc] initWithContentViewController:_startDateCV];
    _startDateCV.popover = pop;
    _startDateCV.selectedDate=self.startDay;
    self.popover = pop;
    self.popover.delegate = self;
    //设置弹出窗口尺寸
    self.popover.popoverContentSize = CGSizeMake(195, 216);
    //显示，其中坐标为箭头的坐标以及尺寸
    [self.popover presentPopoverFromRect:CGRectMake(_startButton.frame.origin.x+85, _startButton.frame.origin.y+25, 5, 5) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [pop release];
}
-(IBAction)endDate:(id)sender
{
    if (self.popover.popoverVisible) {
        [self.popover dismissPopoverAnimated:YES];
    }
    
    //初始化待显示控制器
    if(!_endDateCV){
        _endDateCV=[[DateViewController alloc]init];
    }
    else {
        _endDateCV.selectedDate=self.endDay;
    }
    //设置待显示控制器的范围
    [_endDateCV.view setFrame:CGRectMake(0,0, 195, 216)];
    //设置待显示控制器视图的尺寸
    _endDateCV.contentSizeForViewInPopover = CGSizeMake(195, 216);
    //初始化弹出窗口
    UIPopoverController* pop = [[UIPopoverController alloc] initWithContentViewController:_endDateCV];
    _endDateCV.popover = pop;
    _endDateCV.selectedDate=self.endDay;
    self.popover = pop;
    self.popover.delegate = self;
    //设置弹出窗口尺寸
    self.popover.popoverContentSize = CGSizeMake(195, 216);
    //显示，其中坐标为箭头的坐标以及尺寸
    [self.popover presentPopoverFromRect:CGRectMake(_endButton.frame.origin.x+85, _endButton.frame.origin.y+25, 5, 5) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [pop release];
}
//贸易性质
- (IBAction)tradeAction:(id)sender {
    if (self.popover.popoverVisible) {
        [self.popover dismissPopoverAnimated:YES];
    }
    //初始化待显示控制器
    chooseView=[[ChooseView alloc]init];
    //设置待显示控制器的范围
    [chooseView.view setFrame:CGRectMake(0,0, 125, 400)];
    //设置待显示控制器视图的尺寸
    chooseView.contentSizeForViewInPopover = CGSizeMake(125, 400);
    //初始化弹出窗口
    UIPopoverController* pop = [[UIPopoverController alloc] initWithContentViewController:chooseView];
    chooseView.popover = pop;
    chooseView.iDArray=[NSArray arrayWithObjects:All_,@"内贸",@"进口",nil];
    chooseView.parentMapView=self;
    chooseView.type=kTRADE;
    self.popover = pop;
    self.popover.delegate = self;
    //设置弹出窗口尺寸
    self.popover.popoverContentSize = CGSizeMake(125, 150);
    //显示，其中坐标为箭头的坐标以及尺寸
    [self.popover presentPopoverFromRect:CGRectMake(tradeButton.frame.origin.x+85, tradeButton.frame.origin.y+25, 5, 5) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [chooseView.tableView reloadData];
    [chooseView release];
    [pop release];
}
//电厂类型
- (IBAction)typeAction:(id)sender {
    if (self.popover.popoverVisible) {
        [self.popover dismissPopoverAnimated:YES];
    }
    //初始化待显示控制器
    chooseView=[[ChooseView alloc]init];
    //设置待显示控制器的范围
    [chooseView.view setFrame:CGRectMake(0,0, 125, 400)];
    //设置待显示控制器视图的尺寸
    chooseView.contentSizeForViewInPopover = CGSizeMake(125, 400);
    //初始化弹出窗口
    UIPopoverController* pop = [[UIPopoverController alloc] initWithContentViewController:chooseView];
    chooseView.popover = pop;
    chooseView.iDArray=[NSArray arrayWithObjects:All_,@"直供",@"海进江",@"山东",@"海南",nil];
    chooseView.parentMapView=self;
    chooseView.type=kTYPE;
    self.popover = pop;
    self.popover.delegate = self;
    //设置弹出窗口尺寸
    self.popover.popoverContentSize = CGSizeMake(125, 250);
    //显示，其中坐标为箭头的坐标以及尺寸
    [self.popover presentPopoverFromRect:CGRectMake(typeButton.frame.origin.x+85, typeButton.frame.origin.y+25, 5, 5) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [chooseView.tableView reloadData];
    [chooseView release];
    [pop release];
}

- (IBAction)reloadAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络同步需要等待一段时间" delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"开始同步",nil];
	[alert show];
    [alert release];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.view addSubview:activity];
        [reloadButton setTitle:@"同步中..." forState:UIControlStateNormal];
        [activity startAnimating];
        
        
        [tbxmlParser setISoapNum:1];
        [tbxmlParser requestSOAP:@"YunLi"];
        

        [self runActivity];
    }
	
}

- (IBAction)queryAction:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMM"];
    [NTFactoryFreightVolumeDao InsertByTrade:tradeLabel.text Type:typeLabel.text StartDate:[dateFormatter stringFromDate:self.startDay] EndDate:[dateFormatter stringFromDate:self.endDay]];

    [dateFormatter release];

    [self loadViewData];

    [activity stopAnimating];
    [activity removeFromSuperview];
}
- (IBAction)touchDownAction:(id)sender
{
    [self.view addSubview:activity];
    [activity startAnimating];
}
- (IBAction)resetAction:(id)sender {
    self.tradeLabel.text=All_;
    self.tradeLabel.hidden=YES;
    self.typeLabel.text=All_;
    self.typeLabel.hidden=YES;

    [tradeButton setTitle:@"贸易性质" forState:UIControlStateNormal];
    [typeButton setTitle:@"电厂类型" forState:UIControlStateNormal];
    
    self.endDay = [[[NSDate alloc] init] autorelease];
    
    //本年度的一个月
    NSDateComponents *comp = [[[NSDateComponents alloc]init] autorelease];
    [comp setMonth:1];
    NSDateFormatter *yearFormatter =[[NSDateFormatter alloc] init];
    [yearFormatter setDateFormat:@"yyyy"];
    [comp setYear:[[yearFormatter stringFromDate:[NSDate date]] integerValue]];
    NSCalendar *myCal = [[[NSCalendar alloc ]    initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    [yearFormatter release];
    self.startDay=[myCal dateFromComponents:comp] ;
    
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    [_endButton setTitle:[dateFormatter stringFromDate:_endDay] forState:UIControlStateNormal];
    [_startButton setTitle:[dateFormatter stringFromDate:_startDay] forState:UIControlStateNormal];

    
}
#pragma mark - popoverController
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController{
    NSLog(@"popoverControllerShouldDismissPopover");
    NSLog(@"popoverControllerShouldDismissPopover");
    if (_startDateCV){
        self.startDay=_startDateCV.selectedDate;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSLog(@"startDay=%@",[dateFormatter stringFromDate:self.startDay]);
        [dateFormatter release];
    }
    if (_endDateCV){
        self.endDay=_endDateCV.selectedDate;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSLog(@"endDay=%@",[dateFormatter stringFromDate:self.endDay]);
        [dateFormatter release];
    }
    
    
    return  YES;
}

/* Called on the delegate when the user has taken action to dismiss the popover. This is not called when -dismissPopoverAnimated: is called directly.
 */
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    [_startButton setTitle:[dateFormatter stringFromDate:_startDay] forState:UIControlStateNormal];
    [_endButton setTitle:[dateFormatter stringFromDate:_endDay] forState:UIControlStateNormal];
    [dateFormatter release];
    
}

#pragma mark activity
-(void)runActivity
{
    if ([tbxmlParser iSoapNum]==0) {
        [activity stopAnimating];
        [activity removeFromSuperview];
        [reloadButton setTitle:@"网络同步" forState:UIControlStateNormal];
        return;
    }
    else if (tbxmlParser.iSoapDone==3)
    {
        if (activity) {
            [activity stopAnimating];
            [activity removeFromSuperview];
            [reloadButton setTitle:@"网络同步" forState:UIControlStateNormal];
        }
       
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"服务器连接失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];
        
        [alert  release];
        return;
        
    }

    else {
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runActivity) userInfo:NULL repeats:NO];
    }
}
-(void)loadViewData
{
    int i;
    MultiTitleDataSource *ds = [[MultiTitleDataSource alloc] init];
   
    NSMutableArray *factoryArray = [NTFactoryFreightVolumeDao getFactoryFromTmpNTFactoryFreightVolume];
    NSMutableArray *tradetimeArray = [NTFactoryFreightVolumeDao getTradeTimeFromTmpNTFactoryFreightVolume];
    ds.titles = factoryArray;
    
    ds.columnWidth = [[[NSMutableArray alloc] init] autorelease];
    [ds.columnWidth addObject:@"120"];
    for (i=1; i<[ds.titles count]; i++) {
        [ds.columnWidth addObject:@"120"];
    }
    ds.data = [NTFactoryFreightVolumeDao getAllDataByTradeTime:tradetimeArray Factory:factoryArray];
    ds.splitTitle = [NSArray arrayWithObjects:@"运量",@"航次",nil];

    MultiTitleDataGridComponent *grid = [[MultiTitleDataGridComponent alloc] initWithFrame:CGRectMake(0, 50, 1024, 450) data:ds];
    //[ds.columnWidth release];
	[ds release];
	[self.listView addSubview:grid];
	[grid release];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    titleLabel.center=CGPointMake(480, 20);
    titleLabel.text=@"电厂运量运力查询";
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.textAlignment=UITextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    titleLabel.backgroundColor=[UIColor colorWithRed:39.0/255 green:39.0/255 blue:39.0/255 alpha:1];
    [self.listView addSubview:titleLabel];
    [titleLabel release];
}
#pragma mark SetSelectValue  Method
-(void)setLableValue:(NSString *)currentSelectValue
{
    if (chooseView) {
        if (chooseView.type==kTRADE) {
            NSLog(@"choosedele");
            
            self.tradeLabel.text =currentSelectValue;
            if (![self.tradeLabel.text isEqualToString:All_]) {
                self.tradeLabel.hidden=NO;
                [self.tradeButton setTitle:@"" forState:UIControlStateNormal];
            }
            else {
                self.tradeLabel.hidden=YES;
                [self.tradeButton setTitle:@"贸易性质" forState:UIControlStateNormal];
            }
        }
        if (chooseView.type==kTYPE) {
            
            self.typeLabel.text =currentSelectValue;
            if (![self.typeLabel.text isEqualToString:All_]) {
                self.typeLabel.hidden=NO;
                [self.typeButton setTitle:@"" forState:UIControlStateNormal];
            }
            else {
                self.typeLabel.hidden=YES;
                [self.typeButton setTitle:@"电厂类型" forState:UIControlStateNormal];
            }
        }
    }
}
@end
