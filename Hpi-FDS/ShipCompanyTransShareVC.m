//
//  ShipCompanyTransShareVC.m
//  Hpi-FDS
//  船运公司份额统计
//  Created by 马 文培 on 12-7-20.
//  Copyright (c) 2012年 Landscape. All rights reserved.
//

#import "ShipCompanyTransShareVC.h"

@interface ShipCompanyTransShareVC ()

@end

@implementation ShipCompanyTransShareVC
@synthesize popover=_popover;
@synthesize startDateCV=_startDateCV;
@synthesize endDateCV=_endDateCV;
@synthesize startDay=_startDay;
@synthesize endDay=_endDay;
@synthesize portButton=_portButton;
@synthesize portLabel=_portLabel;
@synthesize queryButton=_queryButton;
@synthesize startButton=_startButton;
@synthesize endButton=_endButton;
@synthesize reloadButton=_reloadButton;
@synthesize activity=_activity;
@synthesize xmlParser=_xmlParser;
@synthesize graphView=_graphView;
@synthesize multipleSelectView=_multipleSelectView;
@synthesize parentVC;

static BOOL PortPop=NO;
static  NSMutableArray *PortArray;

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
    
    self.portLabel.hidden=YES;
    [_activity removeFromSuperview];
    self.xmlParser=[[XMLParser alloc]init];
    
    self.portLabel.text=@"全部";
    
    self.endDay = [[NSDate alloc] init];
    self.startDay = [[NSDate alloc] initWithTimeIntervalSinceNow: - 24*60*60*366];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    [_endButton setTitle:[dateFormatter stringFromDate:_endDay] forState:UIControlStateNormal];
    [_startButton setTitle:[dateFormatter stringFromDate:_startDay] forState:UIControlStateNormal];
    [dateFormatter release];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setActivity:nil];
    _xmlParser=nil;
    [_xmlParser release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc {
  
    [_popover release];
    [_reloadButton release];
    [_activity release];
    [_xmlParser release];
    [super dealloc];
    //[factoryArray release];
    if (PortPop==YES) {
        [PortArray release];
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
#pragma mark -
#pragma mark buttion action
- (IBAction)portAction:(id)sender {
   
    if (self.popover.popoverVisible) {
        [self.popover dismissPopoverAnimated:YES];
    }
    
    //初始化多选控制器
    _multipleSelectView=[[MultipleSelectView alloc]init]; 
    //设置待显示控制器的范围
    [_multipleSelectView.view setFrame:CGRectMake(0,0, 125, 400)];
    //设置待显示控制器视图的尺寸
    _multipleSelectView.contentSizeForViewInPopover = CGSizeMake(125, 400);
    //初始化弹出窗口
    UIPopoverController* pop = [[UIPopoverController alloc] initWithContentViewController:_multipleSelectView];
    _multipleSelectView.popover = pop;
    
    
    if ( PortPop==NO) { 
        PortArray=[[NSMutableArray alloc]init];
        TgPort *allPort =  [[TgPort alloc] init];
        allPort.portCode=All_;
        allPort.portName=All_;

        [PortArray addObject:allPort];
        [allPort release];
        NSMutableArray *array=[TgPortDao getTgPort];
        for(int i=0;i<[array count];i++){
            TgPort *tgPort=[array objectAtIndex:i];
            [PortArray addObject:tgPort];
            
        }
        PortPop=YES;
        
    }
    _multipleSelectView.iDArray=PortArray;
    
    _multipleSelectView.parentMapView=self;
    _multipleSelectView.type=kChFACTORY;
    self.popover = pop;
    self.popover.delegate = self;
    //设置弹出窗口尺寸
    self.popover.popoverContentSize = CGSizeMake(125, 400);
    //显示，其中坐标为箭头的坐标以及尺寸
    [self.popover presentPopoverFromRect:CGRectMake(150, 30, 5, 5) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [_multipleSelectView.tableView reloadData];
    [_multipleSelectView release];
    [pop release];
        
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
    [_startDateCV.view setFrame:CGRectMake(0,0, 320, 216)];
    //设置待显示控制器视图的尺寸
    _startDateCV.contentSizeForViewInPopover = CGSizeMake(320, 216);
    //初始化弹出窗口
    UIPopoverController* pop = [[UIPopoverController alloc] initWithContentViewController:_startDateCV];
    _startDateCV.popover = pop;
    _startDateCV.selectedDate=self.startDay;
    self.popover = pop;
    self.popover.delegate = self;
    //设置弹出窗口尺寸
    self.popover.popoverContentSize = CGSizeMake(320, 216);
    //显示，其中坐标为箭头的坐标以及尺寸
    [self.popover presentPopoverFromRect:CGRectMake(350, 90, 5, 5) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];   
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
    [_endDateCV.view setFrame:CGRectMake(0,0, 320, 216)];
    //设置待显示控制器视图的尺寸
    _endDateCV.contentSizeForViewInPopover = CGSizeMake(320, 216);
    //初始化弹出窗口
    UIPopoverController* pop = [[UIPopoverController alloc] initWithContentViewController:_endDateCV];
    _endDateCV.popover = pop;
    _endDateCV.selectedDate=self.endDay;
    self.popover = pop;
    self.popover.delegate = self;
    //设置弹出窗口尺寸
    self.popover.popoverContentSize = CGSizeMake(320, 216);
    //显示，其中坐标为箭头的坐标以及尺寸
    [self.popover presentPopoverFromRect:CGRectMake(610, 90, 5, 5) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [pop release];
}
- (IBAction)reloadAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络同步需要等待一段时间" delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"开始同步",nil];
	[alert show];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.view addSubview:_activity];
        [_reloadButton setTitle:@"同步中..." forState:UIControlStateNormal];
        [_activity startAnimating];
         [_xmlParser setISoapNum:1];
        [NTShipCompanyTranShareDao deleteAll];
        [_xmlParser getNtShipCompanyTranShare];

        [self runActivity];
    }
	
}
#pragma mark - popoverController
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController{
    NSLog(@"popoverControllerShouldDismissPopover");
    return  YES;
}

/* Called on the delegate when the user has taken action to dismiss the popover. This is not called when -dismissPopoverAnimated: is called directly.
 */
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    NSLog(@"popoverControllerDidDismissPopover");
}

#pragma mark activity
-(void)runActivity
{
    if ([_xmlParser iSoapNum]==0) {
        [_activity stopAnimating];
        [_activity removeFromSuperview];
        [_reloadButton setTitle:@"网络同步" forState:UIControlStateNormal];
        return;
    }
    else {
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runActivity) userInfo:NULL repeats:NO];
    }
}
-(IBAction)queryData:(id)sender
{
    [self loadHpiGraphView];
}

-(void)generateGraphDate{
    
}
-(void)loadHpiGraphView{
//    NSDate *maxDate=_startDay;
//    NSDate *minDate=_endDay;
//    HpiGraphData *graphData=[[HpiGraphData alloc] init];
//    graphData.pointArray = [[NSMutableArray alloc]init];
//    graphData.xtitles = [[NSMutableArray alloc]init];
//    graphData.ytitles = [[NSMutableArray alloc]init];
//    NSDate *date=minDate;
//    int minY = 0;
//    int maxY = 100;
//    
//    if([stringType isEqualToString: @"GKDJL"])
//    {
//        minY = 0;
//        maxY = 180;
//        NSLog(@"max=[%d] min=[%d]",maxY,minY);
//        graphData.yNum=maxY-minY;
//        for(int i=0;i<6;i++)
//        {
//            NSLog(@"minY+(maxY-minY)*(i+1)/6) [%d]",minY+(maxY-minY)*i/5);
//            if (i==0) {
//                [graphData.ytitles addObject:[NSString stringWithFormat:@"%d",minY]];
//            }
//            else {
//                [graphData.ytitles addObject:[NSString stringWithFormat:@"%d",minY+(maxY-minY)*i/5]];
//            }
//        }
//    }
//      
//
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    unsigned int unitFlags = NSDayCalendarUnit;
//    NSDateComponents *comps = [gregorian components:unitFlags fromDate:minDate  toDate:maxDate  options:0];
//    graphData.xNum = [comps day]+1;
//    
//    int a,b,c;
//    a=graphData.xNum/9;
//    b=graphData.xNum%9;
//    NSLog(@"graphData.xNum/9 [%d] graphData.xNum 求余 9  [%d]",a,b);
//    if (a==0) {
//        c=1;
//        graphData.xNum=b;
//    }
//    else if (a>0 && b>0){
//        c=a+1;
//        graphData.xNum=(a+1)*9;
//    }
//    else {
//        c=a;
//        graphData.xNum=a*9;
//    }
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy/MM/dd"];   
//    
//    for(int i=1;i<=graphData.xNum;i++)
//    {   
//        if (i==1) {
//            [graphData.xtitles addObject:[dateFormatter stringFromDate:date]];
//        }
//        if(i%c==0)
//        {
//            [graphData.xtitles addObject:[dateFormatter stringFromDate:date]];
//        }
//        date = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] + 24*60*60)];
//    }
//    [dateFormatter release];    
//    
//    NSMutableArray *array=[TgPortDao getTgPortByPortName:portLabel.text];
//    NSLog(@"查询 %@ 详细信息 %d条记录",stringType,[array count]);
//    TgPort *tgPort=(TgPort *)[array objectAtIndex:0];
//    date=minDate;
//    if([stringType isEqualToString: @"GKDJL"])
//    {
//        for ( int i = 0 ; i < graphData.xNum ; i++ ) {
//            //NSLog(@"date %@",date);
//            TmCoalinfo *tmCoalinfo=[TmCoalinfoDao getTmCoalinfoOne :tgPort.portCode:date];
//            if(tmCoalinfo == nil){
//            }
//            else{
//                HpiPoint *point=[[HpiPoint alloc]init];
//                point.x=i;
//                point.y=tmCoalinfo.import/10000-minY;
//                [graphData.pointArray  addObject:point];
//            }
//            date = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([date timeIntervalSinceReferenceDate] + 24*60*60)]; 
//        }
//    }
//    
//      
//    if (graphView) {
//        [graphView removeFromSuperview];
//        [graphView release];
//        graphView =nil;
//    }
//    //NSLog(@"graphView $$$$$$$$ %d",[graphView retainCount]);
//    self.graphView=[[HpiGraphView alloc] initWithFrame:CGRectMake(50, 120, 924, 550) :graphData];
//    if([stringType isEqualToString:@"GKDJL"]){
//        graphView.titleLabel.text=@"港口调进量(万吨)";
//    }
//    else if([stringType isEqualToString:@"GKDCL"]){
//        graphView.titleLabel.text=@"港口调出量(万吨)";
//    }
//    else if([stringType isEqualToString:@"GKCML"]){
//        graphView.titleLabel.text=@"港口存煤量(万吨)";
//    }
//    else if([stringType isEqualToString:@"ZGCS"]){
//        graphView.titleLabel.text=@"在港船数";
//    }
//    
//    //    graphView.titleLabel.text=stringType;
//    graphView.marginRight=60;
//    graphView.marginBottom=60;
//    graphView.marginLeft=60;
//    graphView.marginTop=80;
//    [graphView setNeedsDisplay];
//    [self.view addSubview:graphView];
//    [graphData release];    
}

@end