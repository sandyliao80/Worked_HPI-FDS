//
//  PubInfo.h
//  Hpi-FDS
//
//  Created by zcx on 12-3-30.
//  Copyright (c) 2012年 Landscape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TgPort.h"
#import "TgFactory.h"
#import "TgShip.h"
#import "TsFileinfo.h"
#import "TmIndexinfo.h"
#import "TmIndexdefine.h"
#import "TmIndextype.h"
#import "VbShiptrans.h"

#import "TgPortDao.h"
#import "TgFactoryDao.h"
#import "TgShipDao.h"
#import "TsFileinfoDao.h"
#import "TmIndexinfoDao.h"
#import "TmIndexdefineDao.h"
#import "TmIndextypeDao.h"
#import "VbShiptransDao.h"

typedef enum{
    kPORT=0,
    kFACTORY,
    kSHIP
} CoordinateType;

#define All_PORT    @"全部港口"
#define All_FCTRY   @"全部电厂"
#define All_SHIP    @"全部船舶"
#define kYES        @"1"
#define kNO         @"0"


@interface PubInfo : NSObject

+(void)initdata;
+(void)save;
+(NSString *)baseUrl;
+(NSString *)url;
+(NSString *)userName;
+(void)setUserName:(NSString*) theuserName;
+(NSString *)autoUpdate;
+(void)setAutoUpdate:(NSString*) update;
+(NSString *)updateTime;
+(void)setUpdateTime:(NSString*) time;
@end
