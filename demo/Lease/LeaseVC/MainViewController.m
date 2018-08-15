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

// 数据处理类型
typedef NS_ENUM(NSInteger, ModelHandleType) {
    RentHandleType,
    typeHandleType,
    regionHandleType,
    sortHandleType,
};


@interface MainViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray; //装数据

@property (nonatomic, strong) UITableView *listTableView; //列表

@property (nonatomic, strong) SortBtn *sortBtn; //搜索按钮

@property (nonatomic, assign) NSInteger page; //页码

@property (nonatomic, strong) UploadParametersModel *upLoadModel; //上传数据模型

@property (nonatomic, assign) NSInteger TotalNumber; //总件数

@end

@implementation MainViewController
{
    SearchView *Seview; //搜索
    MenuView *Menu; //菜单

}

#pragma mark Lazy load

-(SortBtn *)sortBtn
{
    if (!_sortBtn)
    {
        _sortBtn = [[SortBtn alloc] init];
        [_sortBtn addTarget:self action:@selector(sortClick) forControlEvents:UIControlEventTouchUpInside];
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
    
    [Menu transparentClick];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];


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
    [self createMenuView];
    
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
-(void)createMenuView
{
    WeakSelf(weakSelf)
    NSArray * titleArray =@[@"區域",@"類型",@"租金",@"更多"];
    NSMutableArray * reginAllTitleArray =[[NSMutableArray alloc] init];
    NSArray * reTitleArray=@[@"區域",@"捷運",@"附近"];

    for (int i = 0;i < reTitleArray.count; i++){
        
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        if (i == 0){
            [dic setObject:@"1" forKey:@"Select"];
        }
        else{
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

    if (![self isLocationServiceOpen])//没有开启定位
    {
        [reginAllTitleArray removeLastObject];
        [allReginArray removeLastObject];
    }
    
    Menu =[[MenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) withMenuTile:titleArray withFaterView:self.view];

    //类型数据
    NSMutableArray * typeArray = [[AnalyticPlistData shareInstance] getTpyePlistData];
    //租金数据
    NSMutableArray * priceArray = [[AnalyticPlistData shareInstance] getRentPricePlistData];

    [Menu getrRegionRawDataWithDefaultArr:reginAllTitleArray reginAllArray:allReginArray typeArray:typeArray rentArray:priceArray];

    Menu.backRrginDataBlock = ^(NSMutableDictionary * uploadDic)//上传区域数据
    {
       [weakSelf modelDataEndowingWithDic:uploadDic withDataType:regionHandleType];
    };
    
    Menu.backTypeDataBlock = ^(NSMutableDictionary *uploadDic)//上传类型数据
    {
       [weakSelf modelDataEndowingWithDic:uploadDic withDataType:typeHandleType];
    };
    
    Menu.backRentDataBlock = ^(NSMutableDictionary *uploadDic)//上传租金数据
    {
        [weakSelf modelDataEndowingWithDic:uploadDic withDataType:RentHandleType];
    };
}
//数据赋予
-(void)modelDataEndowingWithDic:(NSMutableDictionary *)dic withDataType:(ModelHandleType)type
{
    [self.dataArray removeAllObjects];
    self.page = 1;
    
    if (dic)
    {
        if(type == RentHandleType){
            self.upLoadModel = [UploadDataManager uploadRentDataWithModel:self.upLoadModel WithDic:dic];
        }
        else if (type ==typeHandleType){
             self.upLoadModel = [UploadDataManager uploadTypeDataWithModel:self.upLoadModel WithDic:dic];
        }
        else if (type ==regionHandleType){
            self.upLoadModel = [UploadDataManager uploadRegionDataWithModel:self.upLoadModel WithDic:dic];
        }
        else if (type ==sortHandleType){
            self.upLoadModel = [UploadDataManager uploadSortDataWithModel:self.upLoadModel WithDic:dic];
        }
        
        self.upLoadModel.page = [NSString stringWithFormat:@"%ld",(long)self.page];
    }
    
    [self.listTableView.mj_header beginRefreshing];
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
    
    [[MyDIYRefresh shareRefresh] refreshView:self.listTableView refreshType:RefreshTypeDIYHeaderWithFooter headerRefreshBlock:^{
        
        weakSelf.page = 1;
        [weakSelf.dataArray removeAllObjects];
        weakSelf.upLoadModel.page = [NSString stringWithFormat:@"%ld",(long)self.page];
        [weakSelf getListRequest];
        
    } footerRefreshBlock:^{
        
        weakSelf.page++;
        weakSelf.upLoadModel.page = [NSString stringWithFormat:@"%ld",(long)weakSelf.page];
        [weakSelf getListRequest];
        
    }];
    
    self.listTableView.mj_footer.ignoredScrollViewContentInsetBottom = KIsiPhoneX ? 34 : 0;
    [self.view addSubview:self.sortBtn];
    
    CGFloat bottomH = KIsiPhoneX?180:140;
    self.sortBtn.frame = CGRectMake(CGRectGetMaxX(self.view.frame)-80, CGRectGetMaxY(self.view.frame)-bottomH, 60, 30);
    
}
#pragma mark Click Events

//排序点击事件
-(void)sortClick
{
    WeakSelf(weakSelf)
    
     NSMutableArray * sortArray = [[AnalyticPlistData shareInstance] getSortPlistDataWithSelectId:self.upLoadModel.sort];

      SortView * sort = [[SortView alloc] initWithFrame:[[UIScreen mainScreen] bounds] withListData:sortArray];
      
      sort.sendUploadDataBlock = ^(NSMutableDictionary *uploadDic)//上传排序数据
      {
          [weakSelf modelDataEndowingWithDic:uploadDic withDataType:sortHandleType];
      };
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
        
        weakSelf.page = 1;
        
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

//判断用户是否开启定位
-(BOOL)isLocationServiceOpen
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

//下拉刷新数据
-(void)loadNewData
{

}
#pragma mark 网络请求
-(void)getListRequest
{
    WeakSelf(weakSelf)
    
    LeaseViewModel * leaseModel = [[LeaseViewModel alloc] init];
    
    [leaseModel setBlockWithRequestType:ListRequest withSuccessBlock:^(NSMutableDictionary *dic) {
        
        if (dic) {

             NSString * records = dic[@"records"];
            NSMutableArray * dataArray =dic[@"modelArray"];
            
            if (records.length > 0 && weakSelf.page == 1){
                [weakSelf.view makeToast:[NSString stringWithFormat:@"共%@比物件",records] duration:2.0f position:[NSValue valueWithCGPoint:weakSelf.view.center]];
                weakSelf.TotalNumber = records.integerValue;
                weakSelf.dataArray = dataArray;
            }
            else
            {
                  [weakSelf.dataArray addObjectsFromArray:dataArray];
            }
            
            if (weakSelf.dataArray.count >= records.integerValue){
                [weakSelf.listTableView.mj_footer setHidden:YES];
            }
            else{
                [weakSelf.listTableView.mj_footer setHidden:NO];
            }
        }
        
        [weakSelf.listTableView.mj_header endRefreshing];
        [weakSelf.listTableView.mj_footer endRefreshing];
        [weakSelf.listTableView reloadData];
        
    } withFailureBlock:^(NSString *error) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.listTableView.mj_header endRefreshing];
            [weakSelf.listTableView.mj_footer endRefreshing];
        });
    }];
    
    [leaseModel getLeaseListDataWithModel:self.upLoadModel];
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
