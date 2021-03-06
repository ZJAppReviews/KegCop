//
//  ViewControllerAbout.m
//  KegCop
//
//  Created by capin on 6/11/12.
//

#import "ViewControllerAbout.h"

@interface ViewControllerAbout () {
    
}
// add properties below this line
@property (nonatomic, retain) UINavigationBar *navBar;

@property (nonatomic, retain) UILabel *buildnumber;
@property (nonatomic, retain) UILabel *createdaccounts;

@property (nonatomic, retain) UIButton *demoVideo;
@property (nonatomic, retain) UIButton *issueButton;
@property (nonatomic, retain) UIButton *importUsersBtn;


@end

@implementation ViewControllerAbout {
    
}
-(void)addUIElements {
    _navBar = [[UINavigationBar alloc] init];
    [_navBar setFrame:CGRectMake(0,0,CGRectGetWidth(self.view.frame),60)];
    UINavigationItem *titleItem = [[UINavigationItem alloc] initWithTitle:@"KegCop - About"];
    _navBar.barTintColor = [UIColor colorWithRed:100.0f/255.0f
                                          green:83.0f/255.0f
                                           blue:0.0f/255.0f
                                          alpha:1.0f];
    _navBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0f/255.0f
                                                                                   green:239.0f/255.0f
                                                                                    blue:160.0f/255.0f
                                                                                   alpha:1.0f]};
    _navBar.translucent = NO;
    
    // add navbar btn
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissAboutScene:)];
    // add doneBtn / item to navBar
    titleItem.rightBarButtonItem = doneBtn;
    
    _navBar.items = @[titleItem];
    
    [self.view addSubview:_navBar];
    
    // add logic to present UIButton that loads / displays a youtube video
    _demoVideo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    // set button title
    [_demoVideo setTitle:@"Watch Demo Video" forState:UIControlStateNormal];
    // change color of demoVideo button text to blue
    [_demoVideo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    // draw / render button to screen
//    _demoVideo.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    // add action to button
    [_demoVideo addTarget:self action:@selector(loadDemoVideo)
        forControlEvents:UIControlEventTouchUpInside];
    [_demoVideo setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_demoVideo];
    
    _issueButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_issueButton setTitle:@"Report Issue" forState:UIControlStateNormal];
    [_issueButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    _issueButton.frame = CGRectMake(80, 300, 160.0, 40.0);
    [_issueButton addTarget:self action:@selector(submitIssue) forControlEvents:UIControlEventTouchUpInside];
    // add button(s) to view
    [_issueButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_issueButton];
    
    // add importUsersBtn to VC
    _importUsersBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_importUsersBtn setTitle:@"Import Users" forState:UIControlStateNormal];
    [_importUsersBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_importUsersBtn addTarget:self action:@selector(importUsers) forControlEvents:UIControlEventTouchUpInside];
    [_importUsersBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_importUsersBtn];
    
    // _buildNumber setup
    _buildnumber = [[UILabel alloc] init];
    // set version and build numbers
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    _buildnumber.text = [NSString stringWithFormat:@"Version %@ Build %@", version, build];
    [_buildnumber setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_buildnumber];
    
    // display created user accounts
    _createdaccounts = [[UILabel alloc] init];
    _createdaccounts.text = [NSString stringWithFormat:@"%lu accounts have been created.",(unsigned long)[self countUsernames]];
    [_createdaccounts setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:_createdaccounts];
}
-(void)addUIElementConstraints {
    
    // add constraint to _buildNumber
    NSLayoutConstraint *pullBuildNumberToTop = [NSLayoutConstraint constraintWithItem:_buildnumber attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_buildnumber.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:80.0];
    
    // center _buildNumber horizontaly in view
    NSLayoutConstraint *centerXBuildNumber = [NSLayoutConstraint constraintWithItem:_buildnumber                                                 attribute:NSLayoutAttributeCenterX                                                               relatedBy:NSLayoutRelationEqual toItem:_buildnumber.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    // add constraints
    [_buildnumber.superview addConstraints:@[pullBuildNumberToTop, centerXBuildNumber]];
    
    NSLayoutConstraint *pullCreatedAccountsToTop = [NSLayoutConstraint constraintWithItem:_createdaccounts attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_createdaccounts.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:120.0];
    
    NSLayoutConstraint *centerXCreatedAccounts = [NSLayoutConstraint constraintWithItem:_createdaccounts                                                 attribute:NSLayoutAttributeCenterX                                                               relatedBy:NSLayoutRelationEqual toItem:_createdaccounts.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];

    
    [_createdaccounts.superview addConstraints:@[pullCreatedAccountsToTop, centerXCreatedAccounts]];
    
    // center demo btn horizontally
    NSLayoutConstraint *centerXdemoBtn = [NSLayoutConstraint constraintWithItem:_demoVideo                                                 attribute:NSLayoutAttributeCenterX                                                               relatedBy:NSLayoutRelationEqual toItem:_demoVideo.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *pulldemoToTop = [NSLayoutConstraint constraintWithItem:_demoVideo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_demoVideo.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:160.0];
    
    [_demoVideo.superview addConstraints:@[centerXdemoBtn, pulldemoToTop]];
    
    // center issue btn horizontally
    NSLayoutConstraint *centerXissueBtn = [NSLayoutConstraint constraintWithItem:_issueButton                                                 attribute:NSLayoutAttributeCenterX                                                               relatedBy:NSLayoutRelationEqual toItem:_issueButton.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *pullIssueButtonToTop = [NSLayoutConstraint constraintWithItem:_issueButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_issueButton.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:200.0];
    
    [_issueButton.superview addConstraints:@[centerXissueBtn, pullIssueButtonToTop]];
    
    // add constraints for importUsersBtn
    NSLayoutConstraint *centerXimportUsersBtn = [NSLayoutConstraint constraintWithItem:_importUsersBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_importUsersBtn.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *pullImportUsersBtnToTop = [NSLayoutConstraint constraintWithItem:_importUsersBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_importUsersBtn.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:240];
    
    [_importUsersBtn.superview addConstraints:@[centerXimportUsersBtn, pullImportUsersBtnToTop]];

}

#pragma mark - View Did Load
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _context = [[AccountsDataModel sharedDataModel]mainContext];
#ifdef DEBUG
    NSLog(@"context is %@",_context);
#endif
    [self addUIElements];
    [self addUIElementConstraints];
}

- (void)loadDemoVideo {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.youtube.com/watch?v=1a6hxUb3zfU"]];
}

- (void)submitIssue {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/ipatch/KegCop/issues"]];
}
#pragma mark - importUsers
- (void)importUsers {
#ifdef DEBUG
    NSLog(@"inside importUsers method");
#endif
    [self getCSV];
}
#pragma mark - getCSV
- (void)getCSV {
    // use AFNetworking to retrieve remote CSV file from the API then log the output of file
    
    NSString *url;
#ifdef DEBUG
    // use this variable on DEBUG build
    url = @"http://localhost:3000/api/csv_files";
#else
    // use this variable on RELEASE build
    url = @"http://api.kegcop.chrisrjones.com/api/csv_files";
#endif
    
    NSDictionary *parameters = @{@"foo": @"bar", @"baz": @[@1, @2, @3]};
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
//    __weak typeof(self) weakSelf = self;
    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:parameters error:nil];
//    AFJSONRequestOperation *operation =
//    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
//                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//                                                        NSDictionary *jsonDict = (NSDictionary *) JSON;
//                                                        // this is the array that stores the JSON response
//                                                        NSArray *csvFiles = [jsonDict objectForKey:@"csv_files"];
//                                                        [csvFiles enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop){
//                                                            //                                                              NSString *csvFileFilename = [obj objectForKey:@"csv_file_filename"];
//                                                            //                                                              NSLog(@"CSV Filenames:%@",csvFileFilename);
//                                                            [weakSelf processJSONResponse:csvFiles];
//                                                        }];
//
//                                                    }   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//                                                        NSLog(@"Request Failure Because %@",[error userInfo]);
//                                                    }];
//    [operation start];
}
#pragma mark - processJSONResponse
- (void)processJSONResponse:(NSArray *) csvFiles {
    
    NSLog(@"CSV Files array:%@",csvFiles);
    
    NSString *idfv = [SSKeychain passwordForService:@"com.chrisrjones.KegCop.idfv" account:@"com.chrisrjones.KegCop"];
    
    NSString *fileName = [NSString stringWithFormat:@"KegCop-users-%@.csv",idfv];
    
    BOOL hasString = NO;
    for (NSDictionary *fileInfo in csvFiles) {
        if ([fileInfo[@"csv_file_filename"] isEqualToString:fileName]) {
            hasString = YES;
            break;
        }
    }
    NSLog(@"%d",hasString);
    //    the below method will return the id of the CSV file
    //    [self getIDFromCSVArray:csvFiles];
    NSLog(@"the id is:%ld",(long)[self getIDFromCSVArray:csvFiles]);
    [self getSpecificCSVFile:csvFiles];
}
#pragma mark - getSpecificCSVFile
- (void)getSpecificCSVFile:(NSArray *) csvFiles {
    // setup method to use AFNetworking to retrieve CSV file
    
    // afnetworking - https://cocoapods.org/?q=afnetworking
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // afnetworking
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url;
#ifdef DEBUG
    // use this variable on DEBUG build
    url = [NSURL URLWithString:@"http://localhost:3000/api/csv_files/"];
#else
    // use this variable on RELEASE build
    url = [NSURL URLWithString:@"http://api.kegcop.chrisrjones.com/api/csv_files/"];
#endif
    
    // convert int into string - call the "getIDFromCSVArray"
    NSString *railsID = [NSString stringWithFormat:@"%ld",(long)[self getIDFromCSVArray:csvFiles]];
    
    NSURL *getURLrailsCSVID = [url URLByAppendingPathComponent:railsID];
    
//    NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:getURLrailsCSVID];
    
    
    NSURLSessionDownloadTask *downloadCVSFile = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
//        NSLog(@"Response: %@", [[response MIMEType] lowercaseString]);
        
        __block NSArray* responseObjectArray = nil;
        // save the Specific CSV File to an NSArray
        responseObjectArray = (NSArray*)response;
        
        NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *users = [documents stringByAppendingPathComponent:@"KegCop-imported-users.csv"];
        
        [responseObjectArray writeToFile:users atomically:YES];
        
        [self processCSVFile];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadCVSFile resume];
    
    
    
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:getURLrailsCSVID.absoluteString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
//
////        NSLog(@"JSON: %@", responseObject);
//        // Print the response body in text
//        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//             __block NSArray* responseObjectArray = nil;
//            // save the Specific CSV File to an NSArray
//            responseObjectArray = (NSArray*)responseObject;
//
////         save the array to a file in the Documents dir
//           NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//
//           NSString *users = [documents stringByAppendingPathComponent:@"KegCop-imported-users.csv"];
//
//            [responseObjectArray writeToFile:users atomically:YES];
//
//        [self processCSVFile];
//
    
//    } failure:^(NSURLSessionTask *operation, NSError *error) {
//
//        NSLog(@"Error: %@", error);
//    }];
//    [operation start];
    
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
//                                                            path:railsID
//                                                      parameters:nil];
//    __block NSArray* responseObjectArray = nil;
//
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        // Print the response body in text
//        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//
//        // save the Specific CSV File to an NSArray
//        responseObjectArray = (NSArray*)responseObject;
//
//        // save the array to a file in the Documents dir
//        NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//
//        NSString *users = [documents stringByAppendingPathComponent:@"KegCop-imported-users.csv"];
//
//        [responseObjectArray writeToFile:users atomically:YES];
//
//        [self processCSVFile];
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//    [operation start];
}
#pragma mark - process CSV File
- (void) processCSVFile {
    
    // create function to open KegCop-imported-users.csv file
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *users = [documents stringByAppendingPathComponent:@"KegCop-imported-users.csv"];
    
    NSURL *filePath = [NSURL fileURLWithPath:users];
    
    CHCSVParser *file = [[CHCSVParser alloc] initWithContentsOfCSVURL:filePath];
    
    [file setDelegate:self];
    
    // parse above listed file
    [file parse];
}



- (BOOL)addUsersFromArray {
    
    NSArray *importKeys = @[@"pin", @"credit", @"email", @"lastLogin", @"rfid", @"phoneNumber"];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Account"];
    
    NSLog(@"usersArray = %@",usersArray);
        id username = usersArray [0];
        
        NSError *error = nil;
        // See if we already have an Account for this user - username is unique key
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"username = %@", username];
        NSArray *fetched = [_context executeFetchRequest:fetchRequest error:&error];
        if (fetched == nil) return NO;
        
        NSManagedObject *account = [fetched firstObject];
        if (account == nil) {
            account = [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:_context];
            [account setValue:username forKey:@"username"];
        }
        for (NSString *key in importKeys) {
            id value = usersArray[[importKeys indexOfObject:key] + 1];
            if (value) {
                if ([key isEqualToString:@"credit"]) {
                    [account setValue:@([value integerValue]) forKey:key];
                }
                else {
                    if([key isEqualToString:@"lastLogin"]) {
                        [account setValue:[NSDate date]forKey:key];
                    }
                    else {
                        [account setValue:[value description] forKey:key];
                    }
                }
            }
        }
        [_context save:&error];
    return YES;
}

#pragma mark - delegate methods for CHCSVParser
-(void) parserDidBeginDocument:(CHCSVParser *)parser {
    NSLog(@"Parser started!");
}

-(void) parserDidEndDocument:(CHCSVParser *)parser {
    
}

- (void) parser:(CHCSVParser *)parser didFailWithError:(NSError *)error {
    
}

-(void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber {
    usersArray = [[NSMutableArray alloc] init];
    
}

-(void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex {
    [usersArray addObject:field];
    // iterate through CSV file, group objects in 7
    if( fieldIndex %7 == 6) {
        [self addUsersFromArray];
        [usersArray removeAllObjects];
    }
    NSLog(@"field = %@",field);
}

- (void) parser:(CHCSVParser *)parser didEndLine:(NSUInteger)lineNumber {
    NSLog(@"finished line! %@", usersArray);
//    [self addUsersFromArray];
    
}

#pragma mark - getIDFromCSVArray
- (NSInteger)getIDFromCSVArray:(NSArray *) csvFiles {
    
    NSString *idfv = [SSKeychain passwordForService:@"com.chrisrjones.KegCop.idfv" account:@"com.chrisrjones.KegCop"];

    for (NSDictionary *fileInfo in csvFiles) {
        if ([fileInfo[@"csv_file_filename"] containsString:idfv]) {
            return [fileInfo[@"id"] integerValue];
        }
    }
    return -1;
}
#pragma mark - count Usernames
- (NSUInteger)countUsernames {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesSubentities:NO];
    [request setEntity:[NSEntityDescription entityForName:@"Account" inManagedObjectContext:_context]];
    
    NSError *err;
    NSUInteger count = [_context countForFetchRequest:request error:&err];
    if(count == NSNotFound) {
        //Handle error
    }
    return count;
}
#pragma mark - dismiss About VC / Scene
- (IBAction)dismissAboutScene:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
# pragma mark - device orientation

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 90000
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
#endif
    
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}
@end
