//
//  PubInfo.h
//  Hpi-FDS
//
//  Created by zcx on 12-3-30.
//  Copyright (c) 2012年 Landscape. All rights reserved.

#import <Foundation/Foundation.h>
#import "NSString+Verify.h"
#import "TgPort.h"
#import "TgFactory.h"
#import "TgShip.h"
#import "TsFileinfo.h"
#import "TmIndexinfo.h"
#import "TmIndexdefine.h"
#import "TmIndextype.h"
#import "VbShiptrans.h"
#import "VbTransplan.h"
#import "TmCoalinfo.h"
#import "TmShipinfo.h"
#import "TiListinfo.h"
#import "VbFactoryTrans.h"
#import "TfFactory.h"
#import "TbFactoryState.h"


#import "TgPortDao.h"
#import "TgFactoryDao.h"
#import "TgShipDao.h"
#import "TsFileinfoDao.h"
#import "TmIndexinfoDao.h"
#import "TmIndexdefineDao.h"
#import "TmIndextypeDao.h"
#import "VbShiptransDao.h"
#import "VbTransplanDao.h"
#import "TmCoalinfoDao.h"
#import "TmShipinfoDao.h"
#import "TiListinfoDao.h"
#import "VbFactoryTransDao.h"
#import "TfFactoryDao.h"
#import "TbFactoryStateDao.h"
#import "TfShipCompany.h"
#import "TfShipCompanyDao.h"
#import "TfSupplier.h"
#import "TfSupplierDao.h"
#import "TfCoalType.h"
#import "TfCoalTypeDao.h"
#import "TsShipStage.h"
#import "TsShipStageDao.h"
#import "NTShipCompanyTranShare.h"
#import "NTShipCompanyTranShareDao.h"
#import "NTColorConfig.h"
#import "NTColorConfigDao.h"
#import "NTFactoryFreightVolume.h"
#import "NTFactoryFreightVolumeDao.h"
#import "PortEfficiency.h"

typedef enum{
    kPORT=0,
    kFACTORY,
    kSHIP,
    kChPORT,
    kChFACTORY,
    kChSHIP,
    kChCOM,
    kChSTAT,
    kPORTBUTTON,
    kSHIPCOMPANY,
    
    kCOALTYPE,
    kKEYVALUE,
    kTRADE,
    kSHIPSTAGE,
    kSUPPLIER,//14
    kshiptransStage,//15
    kfactoryCate,
    kTYPE, //电厂类型
    kSCHEDULE, //班轮
} CoordinateType;


//数据查询菜单
typedef enum{
    kMenuDCDTCX=0, //电厂动态查询
    kMenuHYGSFETJ, //航运公司份额统计
    kMenuDCYLYLTJ, //电厂运力运量统计
    kMenuZXGXLTJ, //装卸港效率统计
    kMenuSSCBCX, //实时船舶查询
    kMenuCYJH, //船运计划
    kMenuDDRZCX, //调度日志查询
    kMenuZQFMXCX, //滞期费明细查询
    kMenuZQFTJ, //滞期费统计
    kMenuGKMJZGSJ, //港口平均装港时间统计
    kDataQueryMenu_MAX,//最大数量

} DataQueryMenu;

#define All_PORT    @"全部港口"
#define All_FCTRY   @"全部电厂"
#define All_SHIP    @"全部船舶"
#define All_        @"全部"
#define kYES        @"1"
#define kNO         @"0"


@interface PubInfo : NSObject

+(void)initdata;
+(void)save;
+(NSString *)baseUrl;
+(NSString *)url;
+(NSString *)userInfoUrl;
+(NSString *)userName;
+(void)setUserName:(NSString*) theuserName;
+(NSString *)autoUpdate;
+(void)setAutoUpdate:(NSString*) update;
+(NSString *)updateTime;
+(void)setUpdateTime:(NSString*) time;
+(NSString *)deviceID;
+(NSString *)currTime;

//计算两个YYYYMM格式字符串之间月份之差
+(NSInteger)getMonthDifference:(NSString *)startDate :(NSString *)endDate;




//计算两个 时间段[%d天%d小时%d分钟]  [%d天%d小时%d分钟]的和       返回[%d天%d小时%d分钟]字符串      string1/string2  [days,@"days",hours,@"hours",minutes,@"minutes"]  
+(NSString *)getTotalTime:(NSMutableDictionary *)string1:(NSMutableDictionary *)string2 ;


//从数据库时间（string）里格式化 字符串时间   返回formateStr @"yyyy/MM/dd"格式字符串  或  “未知”    
+(NSString *)formaDateTime:(NSString *)string  FormateString:(NSString *)formateStr;


//计算两个  string1(yyyy-MM-dd HH:mm:ss) 和string2(yyyy-MM-dd HH:mm:ss)做差    时间之间的时间段 返回 [days,@"days",hours,@"hours",minutes,@"minutes"]字典 如果有一个时间为“未知”   则返回 [0,@"days",0,@"hours",0,@"minutes"]

+(NSMutableDictionary *)formatInfoDate1:(NSString *)string1 :(NSString *)string2;



//计算两个  string1(yyyy-MM-dd HH:mm:ss) 和string2(yyyy-MM-dd HH:mm:ss)    时间之间的时间段 返回 %d天%d小时%d分钟  如果有一个时间为“未知”   则返回 0天0小时0分钟
+(NSString *)formatInfoDate  :(NSString *)string1 :(NSString *)string2;


@end
