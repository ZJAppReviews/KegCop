//
//  ViewControllerRootHomeLeftPanel.m
//  KegCop
//
//  Created by capin on 11/19/14.
//
//

#import "ViewControllerRootHomeLeftPanel.h"
#import "ViewControllerRootHome.h"
#import "ViewControllerRootHomeCenter.h"
#import "KCModalPickerView.h"
#import "ViewControllerUsers.h"
#import "Account.h"
#import "ViewControllerWebService.h"
#import "ViewControllerDev2.h"

#define SLIDE_TIMING .25

@interface ViewControllerRootHomeLeftPanel ()

@property (nonatomic, weak) IBOutlet UITableViewCell *cellMain;
@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSArray *userNames;
@property (strong, nonatomic) NSMutableArray *names;
@property (strong, nonatomic) NSMutableArray *zeroToFifty;
@property (strong, nonatomic) NSString  *strSelectedUN;
@property (strong, nonatomic) UIPickerView *pickerView;

@end

@implementation ViewControllerRootHomeLeftPanel {
    
}
@synthesize myDelegate;

- (UITableView *)makeTableView {
    CGFloat x = 0;
    CGFloat y = 50;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - 50;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.rowHeight = 45;
    tableView.sectionFooterHeight = 22;
    tableView.sectionHeaderHeight = 22;
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Core Data
    if (_managedObjectContext == nil)
    {
        _managedObjectContext = [[AccountsDataModel sharedDataModel]mainContext];
        NSLog(@"After _managedObjectContext: %@",  _managedObjectContext);
    }
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Account"];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:_managedObjectContext];
    request.resultType = NSDictionaryResultType;
    request.propertiesToFetch = [NSArray arrayWithObject:[[entity propertiesByName] objectForKey:@"username"]];
    request.returnsDistinctResults = YES;
    
    _userNames = [_managedObjectContext executeFetchRequest:request error:nil];
    
    // tableView cell options
    _options = [[NSMutableArray alloc] initWithObjects:@"Add Credits", @"Change Pin", @"Logoff", nil];
    
//    @"Test Bluno Connection"
//    @"Connect to Web Service",
    
    // nums for Add Credits
    _zeroToFifty = [NSMutableArray arrayWithCapacity:50];
    for (int j=0; j < 50; j++) {
        [_zeroToFifty addObject:[NSString stringWithFormat:@"%d",j]];
    }

    
    
    
    self.tableView = [self makeTableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Options"];
    [self.view addSubview:self.tableView];
    
    // load array items - TEMP ITEMS TO LOAD IN UIPICKERVIEW
    self.items = [NSArray arrayWithObjects:@"Red",@"Green",@"Blue", nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Option";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // configure the cell
    cell.textLabel.text = [NSString stringWithFormat:[_options objectAtIndex:indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_options count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate

- (void)showViewControllerRootHomeCenter {
    if (self.myDelegate){
        [myDelegate loadVCRH];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    
    NSString *currentString = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    
    if ([currentString isEqualToString:@"Logoff"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    if ([currentString isEqualToString:@"Manage Accounts"]) {
        NSLog(@"Manage Accounts button pressed");
        
        // do any additional checks / loads for managing accounts.
        
        // What is the current view controller? i.e. print current vc
        NSLog(@"The current vc is %@",self);
        
        NSLog(@"The parent vc is %@",self.parentViewController);
        
        [myDelegate loadVCRH];
    }
    
    if ([currentString isEqualToString:@"Add Credits"]) {
        NSLog(@"Add Credits field / button tapped");
        
        NSLog(@"The current vc is %@",self);
        
        NSLog(@"The parent vc is %@",self.parentViewController);
        
        if (self.parentViewController.isViewLoaded)
        {
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:_managedObjectContext];
            [fetchRequest setEntity:entity];
            
            fetchRequest.propertiesToFetch = [NSArray arrayWithObject:[[entity propertiesByName] objectForKey:@"username"]];
            
            NSError *error = nil;
            NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
            
            if (error) {
                NSLog(@"Unable to execute fetch request.");
                NSLog(@"%@, %@", error, error.localizedDescription);
            } else {
                NSLog(@"%@", result);
            }
            
            _names = [NSMutableArray arrayWithCapacity:[result count]];
            for (Account *account in result) {
                NSString *accountName = account.username;
                if (!accountName) {
                    accountName = @"<Unknown Account>";
                }
                [_names addObject:accountName];
            }
            
            NSLog(@"load UIPickerView here :)");
            _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 400, 320, 200)];
            
            // add toolbar to pickerView
            UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 43)];
            toolBar.barStyle = UIBarStyleBlackOpaque;
            
            UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            
//            UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
//            [infoButton addTarget:self action:@selector(displayAboutUs) forControlEvents:UIControlEventTouchDown];
//            UIBarButtonItem *itemAboutUs = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
//            
            
            UIBarButtonItem *btnAddCredit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCreditToUser:)];
            NSLog(@"btnAddCredit %hhd",btnAddCredit.isEnabled);
            
            [toolBar setItems:[NSArray arrayWithObjects:flex,btnAddCredit,nil]];
            
            toolBar.userInteractionEnabled = true;
            
            // line below is problematic line
            
            [_pickerView addSubview:toolBar];
            
            
            _pickerView.delegate = self;
            _pickerView.showsSelectionIndicator = YES;
            
//             [self.parentViewController.view addSubview:toolBar];
            [self.parentViewController.view addSubview:_pickerView];
//            [self.parentViewController.view addSubview:infoButton];
            
            //            KCModalPickerView *pickerView = [[KCModalPickerView alloc] initWithValues:names];
//            
//            [pickerView presentInView:self.parentViewController.view withBlock:^(BOOL madeChoice) {
//                NSLog(@"Made choice? %d", madeChoice);
//            }];
        
        
        [myDelegate loadVCRH];
        
        // how to remove pickerView from parent VC?
            
//      [self.parentViewController.view removeFromSuperview:pickerView];
            
//            [pickerView presentInView:self.parentViewController.view ];
        }
    }
    
    if ([currentString isEqualToString:@"Change Pin"]) {
        NSLog(@"Change Pin field / cell tapped");
        // load ViewControllerUsers vc.
        AppDelegate *appDelegate = APPDELEGATE;
        UIStoryboard *storyboard = appDelegate.storyboard;
        UIViewController *changePin = [storyboard instantiateViewControllerWithIdentifier:@"users"];
        [self presentViewController:changePin animated:YES completion:nil];
    }
    
    if ([currentString isEqualToString:@"Create Web Service"]) {
        ViewControllerWebService *webServiceVC = [[ViewControllerWebService alloc] initWithNibName:@"ViewControllerWebService" bundle:nil];
        // establish delegate for vc
        webServiceVC.delegate = self;
        [self presentViewController:webServiceVC animated:YES completion:nil];
    }
    
    if ([currentString isEqualToString:@"Test Bluno Connection"]) {
        AppDelegate *appDelegate = APPDELEGATE;
        UIStoryboard *storyboard = appDelegate.storyboard;
        ViewControllerDev2 *blunoTestVC = [storyboard instantiateViewControllerWithIdentifier:@"dev2"];
        [self presentViewController:blunoTestVC animated:YES completion:nil];
    }
}

- (void)displayAboutUs{
    NSLog(@"inside displayAboutUs");
}

- (void)addCreditToUser:(UIBarButtonItem *)sender {
    NSLog(@"inside AddCreditToUser method");
    // get current selected user / credit from pickerView
    
    // get currently selected username in pickerview and store it as a NSString variable
    NSInteger row;
    
    row = [_pickerView selectedRowInComponent:0];
    _strSelectedUN = _userNames[row][@"username"];
    NSLog(@"The currently selected row is %@",_strSelectedUN);
}

#pragma mark - pickerView Delegate methods

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // handle selection
    
}
/*
 * tell the picker how many rows are available for a given component
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    if(component == 0) {
        return _userNames.count;
    }
    else if(component == 1){
    
        return _zeroToFifty.count;
    }
}

/*
 * tell the picker how many components it will have
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

/*
 * tell the picker the title for a given component
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    NSString *title;
//    title = [@"" stringByAppendingFormat:@"%d",row];
//    return title;
    
    if(component == 0) {
     return _userNames[row][@"username"];
    }
    else if (component == 1) {
//        return _zeroToFifty;
        // how to return a NSMutableArray
        return [_zeroToFifty objectAtIndex:row];
        }
}

/*
 * tell the picker the width of each row for a given component
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        int sectionWidth = 150;
    return sectionWidth;
    }
    else if (component == 1) {
        int sectionWidth = 50;
    return sectionWidth;
    }
}

@end