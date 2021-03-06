//
//  XMLParser.h
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
#import "VbTransplan.h"
#import "TmCoalinfo.h"
#import "TmShipinfo.h"
#import "TiListinfo.h"
#import "VbFactoryTrans.h"
#import "TfFactory.h"
#import "TfFactoryDao.h"
#import "TbFactoryState.h"
#import "VbFactoryTrans.h"
#import "TfShipCompany.h"
#import "TfShipCompanyDao.h"
#import "TfSupplier.h"
#import "TfSupplierDao.h"
#import "TfCoalType.h"
#import "TfCoalTypeDao.h"
#import "TsShipStage.h"
#import "TsShipStageDao.h"
#import "TH_ShipTrans.h"
#import "TH_ShipTransDao.h"


#import "TB_Latefee.h"
#import "TB_LatefeeDao.h"
#import "TfPort.h"
#import "TfPortDao.h"


#import "NTShipCompanyTranShare.h"
#import "NTShipCompanyTranShareDao.h"
#import "NTFactoryFreightVolume.h"
#import "NTFactoryFreightVolumeDao.h"

@interface XMLParser : NSObject<NSXMLParserDelegate>{
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSXMLParser *xmlParser;
    BOOL recordResults;
    TgPort *tgPort;
    TgFactory *tgFactory;
    TgShip *tgShip;
    TsFileinfo *tsFileinfo;
    TmIndexinfo *tmIndexinfo;
    TmIndexdefine *tmIndexdefine;
    TmIndextype *tmIndextype;
    VbShiptrans *vbShiptrans;
    VbTransplan *vbTransplan;
    TmCoalinfo  *tmCoalinfo;
    TmShipinfo  *tmShipinfo;
    TiListinfo  *tiListinfo;
    id webVC;
    TfFactory   *tfFactory;
    TbFactoryState *tbFactoryState;
    VbFactoryTrans  *vbFactoryTrans;
    TfShipCompany *tfShipCompany;
    TfSupplier *tfSupplier;
    TfCoalType *tfCoalType;
    TsShipStage *tsShipStage;
    
    //新添 调度日志
    TH_ShipTrans *thshiptrans;
    TB_Latefee *tblateFee;
    
    //tfport
    TfPort *tfport;
    
   NTShipCompanyTranShare *ntShipCompanyTranShare;
    NTFactoryFreightVolume *factoryFreightVolume;
    
}

@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;
@property(nonatomic, retain) TgPort *tgPort;
@property(nonatomic, retain) TgFactory *tgFactory;
@property(nonatomic, retain) TgShip *tgShip;
@property(nonatomic, retain) TsFileinfo *tsFileinfo;
@property(nonatomic, retain) TmIndexinfo *tmIndexinfo;
@property(nonatomic, retain) TmIndexdefine *tmIndexdefine;
@property(nonatomic, retain) TmIndextype *tmIndextype;
@property(nonatomic, retain) VbShiptrans *vbShiptrans;
@property(nonatomic, retain) VbTransplan *vbTransplan;
@property(nonatomic, retain) TmCoalinfo  *tmCoalinfo;
@property(nonatomic, retain) TmShipinfo  *tmShipinfo;
@property(nonatomic, retain) TiListinfo  *tiListinfo;
@property(nonatomic, assign) id webVC;
@property(nonatomic, retain) TfFactory  *tfFactory;
@property(nonatomic, retain) TbFactoryState *tbFactoryState;
@property(nonatomic, retain) VbFactoryTrans *vbFactoryTrans;
@property(nonatomic, retain) TfShipCompany *tfShipCompany;
@property(nonatomic, retain) TfSupplier *tfSupplier;
@property(nonatomic, retain) TfCoalType *tfCoalType;
@property(nonatomic,retain) TsShipStage *tsShipStage;

//新添 调度日志
@property(nonatomic,retain) TH_ShipTrans *thshiptrans;
@property(nonatomic,retain)TB_Latefee *tblateFee;
@property(nonatomic,retain) TfPort *tfport;




@property(nonatomic,retain) NTShipCompanyTranShare *ntShipCompanyTranShare;
@property(nonatomic,retain) NTFactoryFreightVolume *factoryFreightVolume;







- (void)getTgPort;
- (void)getTgFactory;
- (void)getTgShip;
- (void)getTsFileinfo;
- (void)getTmIndexinfo;
- (void)getTmIndexdefine;
- (void)getTmIndextype;
- (void)getVbShiptrans;
- (void)getVbTransplan;
- (void)getTmCoalinfo;
- (void)getTmShipinfo;
- (void)getTiListinfo;
- (void)getVbFactoryTrans;
- (void)getTfFactory;
- (void)getTbFactoryState;
- (void)getTfShipCompany;
- (void)getTfSupplier;
- (void)getTfCoalType;
- (void)getTsShipStage;
//新添  thshiptrans  调度日志
-(void)getTHShipTrans;

-(void)getTBLateFee;

-(void)getTfPort;



-(void)getTableDete:(NSInteger)Set_iSoapValue :(NSString *)RequestXMLMethodName;

- (void)getNtShipCompanyTranShare;
- (void)getNTFactoryFreightVolume;



-(NSInteger)iSoapTmIndextypeDone;
-(NSInteger)iSoapTmIndexdefineDone;
-(NSInteger)iSoapTmIndexinfoDone;
-(NSInteger)iSoapTsFileinfoDone;
-(NSInteger)iSoapTgPortDone;
-(NSInteger)iSoapTgFactoryDone;
-(NSInteger)iSoapTgShipDone;
-(NSInteger)iSoapVbShiptransDone;
-(NSInteger)iSoapVbTransplanDone;
-(NSInteger)iSoapTmCoalinfoDone;
-(NSInteger)iSoapTmShipinfoDone;
-(NSInteger)iSoapTiListinfoDone;
-(NSInteger)iSoapDone;
-(NSInteger)iSoapNum;
-(void)setISoapNum:(NSInteger)theNum;
-(NSInteger)iSoapTfFactoryDone;
-(NSInteger)iSoapTbFactoryStateDone;
-(NSInteger)iSoapVbFactoryTransDone;
-(NSInteger)iSoapTfShipCompanyDone;
-(NSInteger)iSoapTfSupplierDone;
-(NSInteger)iSoapTfCoalTypeDone;
-(NSInteger)iSoapTsShipStageDone;
//新添调度日志
-(NSInteger)iSoapThShipTransDone;
-(NSInteger)iSoapTbLateFeeDone;
-(NSInteger)iSoapTfPortDone;



-(NSInteger)iSoapNTShipCompanyTranShareDone;
-(NSInteger)iSoapNTFactoryFreightVolumeDone;

@end
