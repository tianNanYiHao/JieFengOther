  //
//  Request.h
//  QuickPos
//
//  Created by 糊涂 on 15/3/18.
//  Copyright (c) 2015年 张倡榕. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ResponseData <NSObject>

- (void)responseWithDict:(NSDictionary*)dict requestType:(NSInteger)type;

@end
// 请求标识定义
enum{

    
    
    
    REQUSET_AD,
    REQUSET_PRODUCTLIST,//商城产品列表
    REQUSET_PRODUCTIDLIST,//商城产品列表
    REQUSET_ORDER_INQUIRY,
    REQUSET_FIRST,//51
    REQUSET_PRODUCTDETAIL,
    REQUSET_GETMONEY,
    REQUSET_GETORDER,//商城订单标示
    REQUSET_GETORIGIN,//详情页面--商品溯源
    
    
    
    
    
    REQUSET_Lccplist, //理财产品列表 55
    REQUSET_MyMangeZiChanList, //查询我的理财资产列表// 56
    REQUSET_HoldingList, //持有中.... 57
    REQUSET_ZHUCEMANGE, //开通理财账户 58
    REQUSET_showHadRedeem,//已赎回列表 59
    REQUSET_GETPRODUCTDITAIL, //获取产品详情列表 60
    REQUSET_getManageProductOrder, //生成理财产品订单接口 61
    


    REQUSET_GETTODAYKILL,//今日秒杀商城 62
    REQUEST_GETMASTMALL,//溯源商城
    REQUEST_GETCROSSBORDER,//跨商电竞
    
    
    REQUSET_GETCOMPENYSY,//独立--商品溯源
    REQUSET_products,//根据企业ID、条码或名称查询匹配的企业产品列表
    REQUSET_PRODUCTINFO,  //3.4根据ID的产品查询
    REQUSET_ProductID,         //3.5最近3笔数据插叙
    REQUSET_validation,        //3.6追溯码的追溯查询
    REQUSET_categories,     //3.2平台产品分类查询
    REQUSET_categoriesProduct,// 7 根据名字查询
    REQUSET_snCode,                  // 追溯查询
    REQUSET_Complaint,             //投诉post
    
};
//
@interface Request : NSObject
//
- (instancetype)initWithDelegate:(NSObject<ResponseData>*)delegate;
//







//中农信合(溯源商城和跨境电商)产品列表接口
- (void)getProductIdWithCardId:(NSString*)cardId;
- (void)sendInfo;
- (void)getAD;
- (void)getProductWithCardId:(NSString*)cardId;
- (void)getInfoWithMobile:(NSString*)mobile;
- (void)getDetailInfoWithProductId:(NSString*)productId withTraceabilityId:(NSString*)traceabilityId;
- (void)getMoneyInfoWithProductId:(NSString*)productId productList:(id)productlist;
- (void)getTodyKillProductWithCardId:(NSString*)cardId;//今日秒杀商城
//- (void)getTodyKillProductWithCateId:(NSString*)cateId;//今日秒杀商城
- (void)getMastmallProductWithCardId:(NSString*)cateId;//百步商城
- (void)getCrossBorderProductWithCardId:(NSString*)cateId;//跨境电商
- (void)gettotalMoneyWithProductLists:(NSArray*)productlists withMobile:(NSString *)mobile withTotal:(NSString*)total;
//产品详情里--商品溯源接口
- (void)getproductId:(NSString*)productId;

/**************************独立商品溯源************************************/
// 查询溯源企业
- (void)getCompanySYwihtName:(NSString*)name fieldNames:(NSString*)fieldNames regionCity:(NSString*)regionCity pageNo:(NSString*)pageNo pageSize:(NSString*)pageSize Bool:(BOOL)yes;
/**
 * 根据企业ID、条码或名称查询匹配的企业产品列表
 */
-(void)getCompanyListWithID:(NSString*)ID pageNo:(NSString*)pageNO pageSize:(NSString*)pagesize;
/**
 *3.4根据ID的产品查询
 */
- (void)getProductInfoWihtID:(NSString*)ID;
/**
 *3.5最近三笔三笔进货记录查询
 */
- (void)getProductInfoNearLyThreeList:(NSString*)CodeID;
/**
 *3.6追溯码的追溯查询
 */
-(void)getProductNodeListProductID:(NSString*)ID productionDate:(NSString*)date batch:(NSString*)batch;

//3.2平台产品分类查询
-(void)getProductSYcategories;
/**7
 * 根据产品名称查产品列表
 * */
-(void)getProductSYcategoriesWithName:(NSString*)name pageNo:(NSString*)pageNo pageSIze:(NSString*)pageSize;
//**6snCode搜索
- (void)getProductSYInfoByScCode:(NSString*)code;
// 投诉接口
- (void)postComplaintWithtagId:(NSString*)tagId tagSn:(NSString*)tagSn tagSnProducerCode:(NSString*)tagSnProducerCode enterpriseId:(NSString*)enterpriseId productId:(NSString*)productId  userName:(NSString*)userName mobile:(NSString*)mobile comments:(NSString*)comments;



@end
