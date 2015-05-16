//
//  WEHomeCityVC.m
//  WestElectromechanical
//
//  Created by zuo on 15/4/27.
//  Copyright (c) 2015年 zuo. All rights reserved.
//

#import "WEHomeCityVC.h"
#import "RDVTabBarController.h"
#import "UIBarButtonItem+Extension.h"
#import "ChineseToPinyinResource.h"

#import "ChineseInclude.h"
#import "PinYinForObjc.h"
@interface WEHomeCityVC ()<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,UISearchBarDelegate>
//城市列表
@property (nonatomic ,weak)UITableView *listTable;
//搜索框
@property (nonatomic ,weak)UISearchBar *mySearchBar;
//搜索控制器
@property (nonatomic ,strong)UISearchDisplayController *mySearchDisplayController;
@property (nonatomic ,strong)NSDictionary *cities;
@property (nonatomic ,strong)NSMutableArray *keys;
@property (nonatomic ,strong)NSMutableArray *totalCitys;
//表头搜索数据结果
@property (nonatomic ,strong)NSMutableArray *searchResults;
//表头可搜索的所有数据
@property (nonatomic ,strong)NSMutableArray *searchData;
@property (nonatomic ,strong)NSMutableArray *sectionArr;
@property (nonatomic ,strong)NSMutableDictionary *sectionDict;
@end

@implementation WEHomeCityVC

#pragma mark -
#pragma mark - 销毁该控制器时的操作

- (void)dealloc
{
    [_searchResults removeAllObjects];
    _searchResults = nil;
    [_searchData removeAllObjects];
    _searchData = nil;
}

#pragma mark -
#pragma mark - 进入该控制器时的操作
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController]setTabBarHidden:YES animated:YES];
//    [self addRightBarButton];
    
    DLog(@"111");
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[self rdv_tabBarController]setTabBarHidden:YES animated:YES];

}
- (void)addRightBarButton{
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initTarget:self WithTitle:@"+好友" withColor:[UIColor redColor] action:@selector(addPeople:)];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-15时，间距正好调整
     *  为10；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -15;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, right];
}
- (void)addPeople:(UIButton*)btn{
//    [self.navigationController pushViewController:[[AddAddressVC alloc]init] animated:YES];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self updateRemarks];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DLog(@"133");
    self.view.backgroundColor =[UIColor colorFromHexCode:@"#f2f2f2"];
    _totalCitys =[NSMutableArray arrayWithCapacity:0];
    //初始化参数
    [self initParams];
    [self initData];
    //初始化数据
    //初始化通讯录列表
    [self initAddressBookTable];
    //初始化顶部搜索框
    [self initSearchBarControler];
}
- (void)updateRemarks{
    [_sectionArr removeAllObjects];
    [_sectionDict removeAllObjects];
//    __weak AddressBookHomeVC *bSelf =self;
//    FriendInfoHandler *friendInfoHandler =[[FriendInfoHandler alloc]init];
//    [friendInfoHandler executeFriendDaoWithAllFriendsInfoSuccess:^(id obj) {
//        [_totalFriends removeAllObjects];
//        [_totalFriends addObjectsFromArray:(NSMutableArray *)obj];
//        DLog(@"%@",_totalFriends);
//        _sectionDict =[NSMutableDictionary dictionaryWithDictionary:[bSelf groupingData:_totalFriends]];
//        [bSelf initData];
//        [_listTable reloadData];
//    } failed:^(id obj) {
//        
//    }];
    
    
//        [self initNetData];
    
}

#pragma mark -
#pragma mark - 网络数据操作和参数
- (void)initNetData{
    //判断是否是本次操作的第一次登录 如果是从本地数据库取出数据，如果不是，则从网络请求数据存储到本地，再从本地读取数据
//    __weak WEHomeCityVC *bSelf =self;
    
    
}

//- (NSDictionary *)groupingData:(NSMutableArray *)dataArrayDic{
//    _sectionArr =[NSMutableArray arrayWithCapacity:0];
//    //排序
//    //建立一个字典，字典保存key是A-Z  值是数组
//    NSMutableDictionary * sectionIndex  =[NSMutableDictionary dictionaryWithCapacity:0];
//    
//    for (NSString *model in dataArrayDic) {
//        NSString *str;
//        if ([model.remarks isEqualToString:@""]) {
//            
//            if ([model.nickName isEqualToString:@""]||[model.nickName isEqual:[NSNull null]]) {
//                str = model.user_id;
//            }else{
//                str = model.nickName;
//            }
//            
//        }else{
//            str = model.remarks;
//        }
//        DLog(@"groupingData----->%@",str);
//        //获得中文拼音首字母，如果是英文或数字则#
//        NSString *strFirLetter = [NSString stringWithFormat:@"%c",pinyinFirstLetter([str characterAtIndex:0])];
//        
//        if ([strFirLetter isEqualToString:@"#"]) {
//            
//            strFirLetter =[self upperStr:[str substringToIndex:1]];
//        }
//        //        strFirLetter = [self upperStr:strFirLetter];
//        NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"] invertedSet];
//        
//        //判断字符串是否在指定的字符集范围内
//        
//        NSRange userNameRange = [strFirLetter rangeOfCharacterFromSet:nameCharacters];
//        
//        if (userNameRange.location != NSNotFound) {
//            
//            strFirLetter = @"#";
//        }
//        NSString * upperStrFirLetter = [self upperStr:strFirLetter];
//        if ([[sectionIndex allKeys]containsObject:upperStrFirLetter]) {
//            //判断index字典中，是否有这个key如果有，取出值进行追加操作
//            [[sectionIndex objectForKey:upperStrFirLetter] addObject:model];
//        }else{
//            NSMutableArray*tempArray=[NSMutableArray arrayWithCapacity:0];
//            [tempArray addObject:model];
//            [sectionIndex setObject:tempArray forKey:upperStrFirLetter];
//        }
//        
//    }
//    [_sectionArr addObjectsFromArray:[sectionIndex allKeys]];
//    _sectionArr = [self sortMethod:_sectionArr];
//    [_sectionArr removeObject:@"#"];
//    [_sectionArr addObject:@"#"];
//    
//    return sectionIndex;
//}
//#pragma  mark 字母转换大小写--6.0
//-(NSString*)upperStr:(NSString*)str{
//    //全部转换为大写
//    NSString *upperStr = [str uppercaseStringWithLocale:[NSLocale currentLocale]];
//    return upperStr;
//}
//#pragma mark 排序
//-(NSMutableArray*)sortMethod:(NSMutableArray *)sortArr
//{
//    
//    return [NSMutableArray arrayWithArray:[sortArr sortedArrayUsingFunction:sortFriendcmp context:NULL]];
//}
////构建数组排序方法SEL
////NSInteger cmp(id, id, void *);
//NSInteger sortFriendcmp(NSString * a, NSString* b, void * p)
//{
//    if([a compare:b] == 1){
//        return NSOrderedDescending;//(1)
//    }else
//        return  NSOrderedAscending;//(-1)
//}


//初始化数据
- (void)initData{
    
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"ofType:@"plist"];
//    获取所有的城市数组
    self.cities = [[[NSDictionary alloc]
                       initWithContentsOfFile:path] mutableCopy];
        //对区头进行排序并赋值给数组self.keys
    self.keys = [[[_cities allKeys] sortedArrayUsingSelector:
                     @selector(compare:)] mutableCopy];
    
    [_searchData removeAllObjects];
    //获取所有的搜索数据
    for (int i = 0; i < _cities.count; i ++) {
        NSArray *sectionCities =[_cities objectForKey:[_keys objectAtIndex:i]];
        for (int j = 0; j < sectionCities.count; j ++) {
            [_searchData addObject:[sectionCities objectAtIndex:j]];
        }
    }
//     _sectionDict =[NSMutableDictionary dictionaryWithDictionary:[bSelf groupingData:_totalFriends]];
    
}
//初始化参数
- (void)initParams
{
    _keys =[NSMutableArray arrayWithCapacity:0];
    _cities =[NSDictionary dictionary];
    _searchResults =[NSMutableArray arrayWithCapacity:0];
    _searchData    =[NSMutableArray arrayWithCapacity:0];
    _sectionArr    =[NSMutableArray arrayWithCapacity:0];
    _sectionDict   =[NSMutableDictionary dictionaryWithCapacity:0];
}

#pragma mark -
#pragma mark - 创建UI界面
//初始化通讯录列表
- (void)initAddressBookTable{
    UITableView *listTable =[[UITableView alloc]init];
    listTable.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    listTable.delegate =self;
    listTable.dataSource =self;
    listTable.backgroundColor =[UIColor clearColor];
    //设置索引列文本的颜色
    listTable.sectionIndexColor = [UIColor blackColor];
    listTable.sectionIndexBackgroundColor=[UIColor clearColor];
    listTable.sectionIndexTrackingBackgroundColor=[UIColor clearColor];
    listTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:listTable];
    _listTable =listTable;
    _listTable.tableFooterView =[[UIView alloc]init];
}
//初始化顶部搜索框
- (void)initSearchBarControler
{
    
    UISearchBar *mySearchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    mySearchBar.delegate =self;
    [mySearchBar setPlaceholder:@"搜索"];
    [mySearchBar setClearsContextBeforeDrawing:YES];
    [mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [mySearchBar sizeToFit];
//    mySearchBar.backgroundImage =[self imageWithColor:[UIColor clearColor] size:mySearchBar.bounds.size];
    _mySearchBar = mySearchBar;
    _mySearchDisplayController =[[UISearchDisplayController alloc]initWithSearchBar:_mySearchBar contentsController:self];
    _mySearchDisplayController.searchResultsDataSource =self;
    _mySearchDisplayController.searchResultsDelegate =self;
    _listTable.tableHeaderView =_mySearchBar;
    
}

////取消searchbar背景色
//- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
//{
//    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return image;
//}

#pragma mark -
#pragma mark - UISearchBarDelegate 和 UISearchDisplayDelegate
//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _mySearchBar.showsCancelButton = YES;
    
    NSArray *subViews;
    
    if (IOS7_OR_LATER) {
        subViews = [(_mySearchBar.subviews[0]) subviews];
    }
    else {
        subViews = _mySearchBar.subviews;
    }
    
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}
//searchBar进行搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [_searchResults removeAllObjects];
    if (_mySearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:_mySearchBar.text]) {
        for (int i=0; i<_searchData.count; i++) {
            BOOL isAdd =NO;
           NSString *str =_searchData[i];
            if ([ChineseInclude isIncludeChineseInString:str]) {
                NSString *tempPinYinStr1 = [PinYinForObjc chineseConvertToPinYin:str];
                NSRange titleResult1=[tempPinYinStr1 rangeOfString:_mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult1.length>0) {
                    [_searchResults addObject:str];
                    isAdd = YES;
                }
                NSString *tempPinYinHeadStr1 = [PinYinForObjc chineseConvertToPinYinHead:str];
                NSRange titleHeadResult1=[tempPinYinHeadStr1 rangeOfString:_mySearchBar.text options:NSCaseInsensitiveSearch];
                
                if (titleHeadResult1.length>0) {
                    if (isAdd) {
                        
                    }else{
                        [_searchResults addObject:str];
                        isAdd =YES;
                    }
                    
                }
            }else{
                NSRange titleResult1=[str rangeOfString:_mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult1.length>0) {
                    if (isAdd) {
                        
                    }else{
                        [_searchResults addObject:str];
                        isAdd = YES;
                    }
                    
                }
            }
        }
    } else if (_mySearchBar.text.length>0&&[ChineseInclude isIncludeChineseInString:_mySearchBar.text]) {
        for (NSString *str in _searchData) {
            NSRange titleResult1=[str rangeOfString:_mySearchBar.text options:NSCaseInsensitiveSearch];
           
            if (titleResult1.length>0) {
                [_searchResults addObject:str];
            }
        }
    }
}


#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (tableView == self.listTable) {
        return self.keys.count+1;
    }else return 1;
    
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.listTable) {
        if (section<1) {
            return 1;
        }
        NSString *key =[_keys objectAtIndex:section-1];
        NSArray *sectionCities =[_cities objectForKey:key];
        DLog(@"%lu",(unsigned long)sectionCities.count);
        return sectionCities.count;
    }else return _searchResults.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60   ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView == self.listTable) {

//        DLog(@"%@",[_sectionArr objectAtIndex:section-1]);
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        view.backgroundColor =[UIColor colorFromHexCode:@"#ebebeb"];
        UILabel *sectionLabel =[[UILabel alloc]init];
        sectionLabel.frame =CGRectMake(  10,0,SCREEN_WIDTH-20,20);
        sectionLabel.numberOfLines =1;
        sectionLabel.font =font(15);
        sectionLabel.textColor =[UIColor colorFromHexCode:@"#999999"];
        sectionLabel.backgroundColor =[UIColor clearColor];
        
        [view addSubview:sectionLabel];
        if (section<1) {
            sectionLabel.text  = @"热门城市";
        }else{
            sectionLabel.text =[_keys objectAtIndex:section-1];
        }
        return view;
        
    }else return nil;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.listTable) {
//        if (section >1) {
            return 20;
//        }else return 0;
        
    }else return 0;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tableView == self.listTable) {
        if (title == UITableViewIndexSearch)
        {
            [self.listTable scrollRectToVisible:self.mySearchBar.frame animated:NO];
            return -1;
        }
        return [_keys indexOfObject:title]+1;
    }else return 0;
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if(tableView == self.listTable)
    {
        NSMutableArray *indexArr =[NSMutableArray arrayWithArray:_keys];
        if (tableView == self.listTable)  // regular table
        {
            [indexArr insertObject:UITableViewIndexSearch atIndex:0];
        }
        
        return indexArr;
        
    }else return nil;
    
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
//        cell.accessoryType  =UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (tableView == self.listTable) {
        if (indexPath.section<1) {
            cell.textLabel.text =@"上海";
        }else cell.textLabel.text = [[_cities objectForKey:[_keys objectAtIndex:indexPath.section-1]] objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text =_searchResults[indexPath.row];
    }
    
   
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)setHomeCityBlock:(homeCityBlock)block
{
    _block = block;
}
#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    NSString *city = cell.textLabel.text;
    
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:kHomeCityKey];
//    if (indexPath.section<1) {
//        city = @"上海";
//    }else {
//        city = [[_cities objectForKey:[_keys objectAtIndex:indexPath.section-1]] objectAtIndex:indexPath.row];
//    }
    if (_block) {
        _block(city);
    }
    [self.navigationController popViewControllerAnimated:NO];
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
