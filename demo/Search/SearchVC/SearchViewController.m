//
//  SearchViewController.m
//  demo
//
//  Created by addcn on 2018/8/8.
//  Copyright © 2018年 addcn. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchView.h"
#import "HistoryCell.h"
@interface SearchViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *historyListTableView; //历史列表

@property (nonatomic, strong) NSMutableArray *historyArray; //历史数据

@end

@implementation SearchViewController
{
    SearchView  *SeView; //搜索view
}

#pragma mark Lazy load

- (UITableView *)historyListTableView
{
    if (!_historyListTableView)
    {
        _historyListTableView =[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _historyListTableView.dataSource = self;
        _historyListTableView.delegate  = self;
        _historyListTableView.emptyDataSetSource = self;
        _historyListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _historyListTableView.backgroundColor =[UIColor jk_colorWithHexString:@"fafafa"];
        _historyListTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // UITableViewStylePlain下 去掉多余分割线
        
    }
    
    return _historyListTableView;
}

-(NSMutableArray *)historyArray
{
    if (!_historyArray)
    {
        _historyArray =[[NSMutableArray alloc] init];
    }
    
    return _historyArray;
}

#pragma mark LifeCycle
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //打开隐藏nav线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //关闭隐藏nav线
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor jk_colorWithHexString:@"fafafa"];
    
     self.edgesForExtendedLayout = UIRectEdgeNone;//让布局从(0,64)以后布局
    
    [self creatNaviagtionBar];
    
    [self InitializationProcessing];
   
    [self createUI];
    
}
#pragma mark Create View
- (void)creatNaviagtionBar
{
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];
    

    SeView = [[SearchView alloc]initWithFrame:CGRectMake(0, 10,KIsiPhoneX?300:KWIDTHShiPei 250 , 30.0f)];
    [SeView.seaechtextfield becomeFirstResponder];
    SeView.seaechtextfield.tintColor = [UIColor whiteColor];
    SeView.seaechtextfield.returnKeyType = UIReturnKeySearch;
    SeView.seaechtextfield.delegate = self;//设置代理
    UIBarButtonItem* backItem = [[UIBarButtonItem alloc] initWithCustomView:SeView];
    
 
    UIBarButtonItem *negativeSpacerleft = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
    negativeSpacerleft.width = - 5;
    self.navigationItem.leftBarButtonItems = @[negativeSpacerleft,backItem];
    
    UIButton * edit =[[UIButton alloc] init];

    edit.frame =CGRectMake(0, 0, 40.0f, 30.0f);
    [edit setTitle:@"取消" forState:UIControlStateNormal];
    edit.titleLabel.textColor =[UIColor whiteColor];
    edit.titleLabel.font  =[UIFont systemFontOfSize:16];
    [edit addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    edit.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    
    UIBarButtonItem* addItem = [[UIBarButtonItem alloc] initWithCustomView:edit];
    
    UIBarButtonItem *negativeSpacerright = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                            target:nil action:nil];
    negativeSpacerright.width = - 8;
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacerright,addItem];
    
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor clearColor]];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor clearColor]];
}

-(void)createUI
{
    [self.view addSubview:self.historyListTableView];
    
    WeakSelf(weakSelf)
    
    [self.historyListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(weakSelf.view.mas_left);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
        make.top.mas_equalTo(weakSelf.view.mas_top);
        make.right.mas_equalTo(weakSelf.view.mas_right);
        
    }];
    
   
}
//初始化数据
-(void)InitializationProcessing
{
    if (self.recordName.length>0)
    {
        SeView.seaechtextfield.text = self.recordName;
    }
    
    NSMutableArray * History =  [[NSUserDefaults standardUserDefaults]objectForKey:@"HistoryData"];
    
    if(History.count == 0)
    {
        self.historyListTableView.hidden = YES;
        
    }
    else
    {
        [self.historyArray addObjectsFromArray:History];
        
        self.historyListTableView.hidden = NO;
        
    }
}

#pragma mark Click Events
-(void)backClick
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:NO];
}

//搜索虚拟键盘响应
#pragma mark UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    if (self.searchNameBlock)
    {
        self.searchNameBlock(textField.text);
    }
        
    if (textField.text.length > 0)
    {
          [self addHistoryData:textField.text];
    }


    [textField resignFirstResponder];
    [self.navigationController popViewControllerAnimated:NO];
    
    return YES;
    
}
//添加历史消息
-(void)addHistoryData:(NSString *)name
{
    NSMutableArray * History = [[NSMutableArray alloc] init];

    NSMutableArray * oldDataArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"HistoryData"];

    [History addObjectsFromArray:oldDataArray];
    
    if (History.count == 0)
    {
        NSMutableArray * array =[[NSMutableArray alloc] init];
        
        [array insertObject:name atIndex:0];
        
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"HistoryData"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {

        [History insertObject:name atIndex:0];

         [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HistoryData"];
        [[NSUserDefaults standardUserDefaults] setObject:History forKey:@"HistoryData"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

#pragma  mark Tableview Delegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.historyArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"HistoryCell";
    HistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil)
    {
        cell = [[HistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor =[UIColor whiteColor];
        
    }
    
    cell.historyContent.text = self.historyArray[indexPath.section];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSString * name = self.historyArray[indexPath.section];
    
    if (self.searchNameBlock)
    {
        self.searchNameBlock(name);
    }
    
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.historyArray.count-1)
    {
        return 40;
    }
    
    return 0.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == self.historyArray.count-1)
    {
        UIButton *footview =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        footview.backgroundColor =[UIColor jk_colorWithHexString:@"fafafa"];
        [footview setTitle:@"清楚历史记录" forState:UIControlStateNormal];
        [footview setTitleColor:[UIColor jk_colorWithHexString:@"999999"] forState:UIControlStateNormal];
        footview.titleLabel.font =[UIFont systemFontOfSize:14];
        [footview addTarget:self action:@selector(clearHistoryData) forControlEvents:UIControlEventTouchUpInside];
        
        return footview;
    }
   
    return nil;
    
}
//清空历史记录
-(void)clearHistoryData
{
     [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"HistoryData"];
    
    [self.historyArray removeAllObjects];
    
    self.historyListTableView.hidden = YES;
    
}

#pragma mark Cancel The Keyboard
// 滑动 取消第一响应者 一般用来隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark ----- DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString *text =@"没有任何搜索记录";
    
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
