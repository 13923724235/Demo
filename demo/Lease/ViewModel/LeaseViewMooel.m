//
//  LeaseViewMoel.m
//  demo
//
//  Created by addcn on 2018/8/15.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "LeaseViewModel.h"
#import "DataModel.h"
@implementation LeaseViewModel

//网络数据
- (void)setBlockWithRequestType:(RequsetType) type
               withSuccessBlock:(successListDataBlock) successBlock
               withFailureBlock:(failureDataBlock) failureBlock
{
    _requestType = type;
    _successBlock = successBlock;
    _failureBlock = failureBlock;
}

//获取租房列表数据
- (void)getLeaseListDataWithModel:(UploadParametersModel *)model
{
    if (_requestType == ListRequest)//列表获取
    {
        NSMutableArray * array =[[NSMutableArray alloc] init];
        NSMutableDictionary * temporaryDic =[[NSMutableDictionary alloc] init];
        
        NSString * url = [UploadParametersModel incomingDataModel:model];
        
        NetworkRequest * network = [NetworkRequest shareInstance];
        
        [network getRequestUrlStr:url success:^(id responseObject) {
            
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                    options:NSJSONReadingMutableContainers
                                                                      error:nil];
            
                NSDictionary * data = dic[@"data"];
                NSArray * item = data[@"items"];
            
                 NSString * records = data[@"records"];
            
                if (item.count > 0){
                    
                    for (NSDictionary * temp in item){
                        
                        DataModel * model = [DataModel yy_modelWithDictionary:temp];
                        [array addObject:model];
                    }
                }
                [temporaryDic setValue:array forKey:@"modelArray"];
                [temporaryDic setValue:records forKey:@"records"];
            
                if (self.successBlock)
                {
                    self.successBlock(temporaryDic);
                }
            
            } failure:^(NSString *errorInfo) {
                
                if (self.failureBlock) {
                    self.failureBlock(@"请求失败");
                }
            }];
    }

}

@end
