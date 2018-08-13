//
//  MainViewController.m
//  demo
//
//  Created by addcn on 2018/8/6.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "MainViewController.h"
#import "SearchView.h"
#import "DataModel.h"
#import "RentingCell.h"
#import "MenuView.h"
#import "UploadParametersModel.h"
#import "RegionModel.h"
#import "SearchViewController.h"
#import "AppDelegate.h"
#import "SortView.h"
@interface MainViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property(nonatomic,strong)NSMutableArray * dataArray; //装数据

@property(nonatomic,strong)UITableView * listTableView; //列表

@property(nonatomic,strong)UIButton * sortBtn; //搜索按钮

@property(nonatomic,assign)NSInteger page; //页码

@property(nonatomic,strong) UploadParametersModel * upLoadModel; //上传数据模型

@end

@implementation MainViewController
{

    UITextField * searchField;
    
    SearchView * Seview; //搜搜
    
    MenuView * menu; //菜单


}

#pragma mark Lazy load

-(UIButton *)sortBtn
{
    if (!_sortBtn)
    {
        _sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sortBtn.backgroundColor = [UIColor blackColor];
        //设置button正常状态下的图片
        [_sortBtn setImage:[UIImage imageNamed:@"icon_jiantou"] forState:UIControlStateNormal];
        //设置button高亮状态下的图片
        [_sortBtn setImage:[UIImage imageNamed:@"icon_jiantou"] forState:UIControlStateHighlighted];

        //button图片的偏移量，距上左下右分别(0, 0, 0, 0)像素点
        _sortBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_sortBtn setTitle:@"排序" forState:UIControlStateNormal];
        //button标题的偏移量，这个偏移量是相对于图片的
        _sortBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        //设置button正常状态下的标题颜色
        [_sortBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //设置button高亮状态下的标题颜色
        [_sortBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        _sortBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _sortBtn.layer.cornerRadius = 5.0f;
        _sortBtn.clipsToBounds = YES;
        [_sortBtn addTarget:self action:@selector(sortclick) forControlEvents:UIControlEventTouchUpInside];
        
    }

    return _sortBtn;
}

- (UITableView *)listTableView
{
    if (!_listTableView)
    {
        _listTableView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _listTableView.dataSource = self;
        _listTableView.delegate  = self;
        _listTableView.emptyDataSetSource = self;
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTableView.backgroundColor =[UIColor jk_colorWithHexString:@"fafafa"];
        _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // UITableViewStylePlain下 去掉多余分割线
        
    }
    
    return _listTableView;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray =[[NSMutableArray alloc] init];
    }
    
    return _dataArray;
}

#pragma mark LifeCycle
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //关闭隐藏nav线
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    [self xw_removeAllNotification];
    
    [menu transparentClick];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self receivingMessageChange];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor whiteColor];
    
   
     self.edgesForExtendedLayout = UIRectEdgeNone;//让布局从(0,64)以后布局
     self.page = 1;
    
     self.upLoadModel =[[UploadParametersModel alloc] init];

    [self creatNaviagtionBar];
     [self createUI];
    [self CreateMenuView];
    
    [self.listTableView.mj_header beginRefreshing];
    
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

#pragma mark Create View
//导航栏
- (void)creatNaviagtionBar
{
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    
    UIButton * backicon =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 13.0f, 20.0f)];
    [backicon setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backicon addTarget:self action:@selector(backclick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:backicon];
    
    

    
    Seview = [[SearchView alloc]initWithFrame:CGRectMake(0, 10, KIsiPhoneX?260:KWIDTHShiPei 230, 30.0f)];
    Seview.seaechtextfield.delegate = self;
    Seview.seaechtextfield.tintColor = [UIColor clearColor];
    self.navigationController.navigationBar.topItem.titleView = Seview;

    
    UIBarButtonItem *negativeSpacerleft = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
    negativeSpacerleft.width = - 5;
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacerleft,backItem];
    
    UIButton * edit =[[UIButton alloc] init];
    
    
    edit.frame =CGRectMake(0, 0, 40.0f, 30.0f);
    [edit setTitle:@"地图" forState:UIControlStateNormal];
    edit.titleLabel.textColor =[UIColor whiteColor];
    edit.titleLabel.font  =[UIFont systemFontOfSize:16];
   // edit.backgroundColor =[UIColor redColor];
    edit.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    UIBarButtonItem* addItem = [[UIBarButtonItem alloc] initWithCustomView:edit];
    
    UIBarButtonItem *negativeSpacerright = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                            target:nil action:nil];
    negativeSpacerright.width = -8;
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacerright,addItem];
    
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor clearColor]];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor clearColor]];
}


//加载菜单
-(void)CreateMenuView
{

    NSArray * titleArray =@[@"區域",@"類型",@"租金",@"更多"];


    NSMutableArray * reginAllTitleArray =[[NSMutableArray alloc] init];

    NSArray * reTitleArray=@[@"區域",@"捷運",@"附近"];

    for (int i = 0;i < reTitleArray.count; i++)
    {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];

        if (i == 0)
        {
            [dic setObject:@"1" forKey:@"Select"];
        }
        else
        {
            [dic setObject:@"0" forKey:@"Select"];
        }

        [dic setObject:reTitleArray[i] forKey:@"TitleName"];

        [reginAllTitleArray addObject:dic];

    }

    NSMutableArray * allReginArray =[[NSMutableArray alloc] init];

    NSMutableArray * reginArray = [[AnalyticPlistData shareInstance] getReginPlistData];
    NSMutableArray * jieyunArray = [[AnalyticPlistData shareInstance] getJieYunPlistData];
    NSMutableArray * nearbyArray = [[AnalyticPlistData shareInstance] getNearByPlistData];

    [allReginArray addObject:reginArray];
    [allReginArray addObject:jieyunArray];
    [allReginArray addObject:nearbyArray];

    menu =[[MenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) withMenuTile:titleArray withFaterView:self.view];

    //类型数据
    NSMutableArray * typeArray = [[AnalyticPlistData shareInstance] getTpyePlistData];
    //租金数据
    NSMutableArray * priceArray = [[AnalyticPlistData shareInstance] getRentPricePlistData];


    [menu getrRegionRawDataWithDefault:reginAllTitleArray withaAllRegionDataMenu:allReginArray withTypeRawData:typeArray withRentRewData:priceArray];


}

-(void)createUI
{
    [self.view addSubview:self.listTableView];
    
    WeakSelf(weakSelf)
    
    [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
        make.top.mas_equalTo(weakSelf.view.mas_top).offset(44);
        make.right.mas_equalTo(weakSelf.view.mas_right);
        
    }];
    
    
    //下拉 触发加载刷新界面
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉结束回调，一般写请求网络数据
        weakSelf.page = 1;
 
        [weakSelf newRequestData];
    
    }];
    
    //上拉 触发加载更多
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
     
        [weakSelf newRequestData];
    }];
    
    self.listTableView.mj_header = header;
    self.listTableView.mj_footer = footer;
    
    self.sortBtn.frame = CGRectMake(CGRectGetMaxX(self.view.frame)-80, CGRectGetMaxY(self.view.frame)-60-80, 60, 30);
    
    [self.view addSubview:self.sortBtn];
}

#pragma mark Click Events
//返回
-(void)backclick
{
    
}

//排序点击事件
-(void)sortclick
{
     NSMutableArray * sortArray = [[AnalyticPlistData shareInstance] getSortPlistData];


      SortView * sort = [[SortView alloc] initWithFrame:[[UIScreen mainScreen] bounds] withListData:sortArray];

        AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

        [myDelegate.window addSubview:sort];


}

#pragma mark tetextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    WeakSelf(weakSelf)

    __strong typeof(weakSelf) strongSelf = weakSelf;

    [textField resignFirstResponder];
    
    SearchViewController * search =[[SearchViewController alloc] init];
    
    if (Seview.seaechtextfield.text.length > 0)
    {
        search.recordName = Seview.seaechtextfield.text;
    }
    
    search.searchNameBlock = ^(NSString *name) {
        
        [weakSelf.dataArray removeAllObjects];
        
         strongSelf->Seview.seaechtextfield.text = name;
        
        weakSelf.upLoadModel.keywords = name;
        
         [weakSelf.listTableView.mj_header beginRefreshing];
        
    };
    [self.navigationController pushViewController:search animated:YES];
    
}

#pragma  mark Tableview Delegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 105;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *Identifier = @"Identifier";
    RentingCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil)
    {
        cell = [[RentingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        
        cell.backgroundColor =[UIColor whiteColor];
        
    }

    if (self.dataArray.count > 0)
    {
        DataModel * model = self.dataArray[indexPath.section];

        if (model)
        {
            cell.model = model;
        }
    }


    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark Network Request
-(void)newRequestData
{

    WeakSelf(weakSelf)
    

    NSString * url = [NetworkRequest modelDataIncomingDictionary:self.upLoadModel withPage:self.page];
    
   // NSLog(@"字符串===%@",url);
    
    [NetworkRequest getRequestUrlStr:url success:^(id responseObject) {

        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
        
        NSDictionary * data = dic[@"data"];
        
        NSArray * item = data[@"items"];
        
        NSString * records = data[@"records"];

        NSLog(@"请求成功------数据条数--%lu",(unsigned long)item.count);
        
        if (records.length > 0)
        {
            [weakSelf.view makeToast:[NSString stringWithFormat:@"共%@比物件",records] duration:2.0f position:[NSValue valueWithCGPoint:weakSelf.view.center]];
        }

        if (item.count > 0)
        {
            for (NSDictionary * temp in item)
            {

                DataModel * model = [DataModel yy_modelWithDictionary:temp];

                [weakSelf.dataArray addObject:model];
            }
        }


        [weakSelf.listTableView.mj_header endRefreshing];
        [weakSelf.listTableView.mj_footer endRefreshing];
    
        [weakSelf.listTableView reloadData];
        
    } failure:^(NSString *errorInfo) {

        NSLog(@"请求失败");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.listTableView.mj_header endRefreshing];
            [weakSelf.listTableView.mj_footer endRefreshing];
        });
        
    }];
    
}

#pragma mark Message Center
- (void)receivingMessageChange
{
    WeakSelf(weakSelf)

    //二级区域不限
    [self xw_addNotificationForName:@"REGIONCHANGE" block:^(NSNotification * _Nonnull notification)
     {
         weakSelf.upLoadModel.regionid = @"0";
         weakSelf.upLoadModel.sectionid = @"0";
         weakSelf.upLoadModel.subway_line = @"0";
         weakSelf.upLoadModel.subway_id = @"0";
         weakSelf.upLoadModel.metter = @"0";

         [weakSelf.listTableView.mj_header beginRefreshing];

     }];

    //三级列表
    [self xw_addNotificationForName:@"SPECIFIC" block:^(NSNotification * _Nonnull notification)
     {
         NSMutableDictionary * dic = [notification object];

         [weakSelf.dataArray removeAllObjects];

         weakSelf.page = 1;

         NSString * SelectRegion = dic[@"type"];

         if (SelectRegion.length > 0)
         {
             if ([SelectRegion isEqualToString:DEFAULTREGINNAME])//区域
             {
                 RegionModel * model = dic[@"model"]; //县市id

                 if (model)
                 {
                     weakSelf.upLoadModel.regionid = model.number;
                 }

                 RegionModel * secondModel = dic[@"secondModel"];//乡镇id

                 if (secondModel)
                 {
                     weakSelf.upLoadModel.sectionid = secondModel.number;
                 }

                 weakSelf.upLoadModel.subway_line = @"0";
                 weakSelf.upLoadModel.subway_id = @"0";
                 weakSelf.upLoadModel.metter = @"0";
             }
             else if ([SelectRegion isEqualToString:JIEYUNNAME])//捷运
             {
                 RegionModel * model = dic[@"model"]; //捷运id

                 if (model)
                 {
                     weakSelf.upLoadModel.subway_line = model.number;
                 }

                 RegionModel * secondModel = dic[@"secondModel"];//具体车站id

                 if (secondModel)
                 {
                     weakSelf.upLoadModel.subway_id = secondModel.number;
                 }

                 weakSelf.upLoadModel.regionid = @"0";
                 weakSelf.upLoadModel.sectionid = @"0";
                 weakSelf.upLoadModel.metter = @"0";
             }
              else if ([SelectRegion isEqualToString:NEARBYMNAME])//附近
              {
                  RegionModel * secondModel = dic[@"secondModel"];//具体车站id

                  if (secondModel)
                  {
                      weakSelf.upLoadModel.metter = secondModel.number;
                  }

                  weakSelf.upLoadModel.regionid = @"0";
                  weakSelf.upLoadModel.sectionid = @"0";
                  weakSelf.upLoadModel.subway_line = @"0";
                  weakSelf.upLoadModel.subway_id = @"0";
              }
         }

         [weakSelf.listTableView.mj_header beginRefreshing];



     }];

    //选择类型
    [self xw_addNotificationForName:@"TYPE" block:^(NSNotification * _Nonnull notification)
     {
         [weakSelf.dataArray removeAllObjects];

         weakSelf.page = 1;

         NSMutableDictionary * dic = [notification object];

         RegionModel * model = dic[@"model"];

         if (model)
         {
             weakSelf.upLoadModel.kind = model.number;
         }


         [weakSelf.listTableView.mj_header beginRefreshing];

     }];

    //租金类型
    [self xw_addNotificationForName:@"RENT" block:^(NSNotification * _Nonnull notification)
     {
         [weakSelf.dataArray removeAllObjects];

         weakSelf.page = 1;

         NSMutableDictionary * dic = [notification object];

         RegionModel * model = dic[@"model"];

         if (model)
         {
             weakSelf.upLoadModel.price = model.number;
         }

         [weakSelf.listTableView.mj_header beginRefreshing];
     }];

    //排序类型
    [self xw_addNotificationForName:@"SORT" block:^(NSNotification * _Nonnull notification)
     {
         [weakSelf.dataArray removeAllObjects];

         weakSelf.page = 1;

         NSData * data =  [[NSUserDefaults standardUserDefaults]objectForKey:@"SortListSelect"];

         if (data)
         {
             RegionModel * totalmodel = [NSKeyedUnarchiver unarchiveObjectWithData:data];

             weakSelf.upLoadModel.sort = totalmodel.number;
         }

         [weakSelf.listTableView.mj_header beginRefreshing];
     }];

    //手动输入价格
    [self xw_addNotificationForName:@"INPUTPRITY" block:^(NSNotification * _Nonnull notification)
     {
         [weakSelf.dataArray removeAllObjects];

         weakSelf.page = 1;

         NSMutableDictionary * dic = [notification object];

         NSString * min = dic[@"Min"];
         NSString * max = dic[@"Max"];

         if (min)
         {
             weakSelf.upLoadModel.minprice = min;
         }

         if (max)
         {
             weakSelf.upLoadModel.maxprice = max;
         }

         weakSelf.upLoadModel.price =@"99";


         [weakSelf.listTableView.mj_header beginRefreshing];
     }];
}
#pragma mark ----- DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text =@"抱歉,暂时没有您搜寻的物件换个条件试试";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"searchBlank.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
