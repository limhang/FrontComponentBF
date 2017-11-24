
#import "ButterFlyLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "CLLocation+Sino.h"
#import "MBProgressHUD+ButterFly.h"
@interface ButterFlyLocationManager()<CLLocationManagerDelegate>
/**地理位置管理**/
@property (nonatomic, strong) CLLocationManager *locationManager;
/**数据模型**/
@property (nonatomic, strong) ButterFlyLocationModel *locationModel;
/**回调闭包**/
@property (nonatomic, copy) ButterFlyLocationManagerDrivingBlock locationModelBlock;


@end


@implementation ButterFlyLocationManager

- (instancetype)init {
    self = [super init];
    if (self) {
        //设置locationManager属性
        [self setLocationManager];
    }
    return self;
}

- (void)setLocationManager{
    if (!_locationManager) {
        _locationManager=[[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=10;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            
            if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
                [_locationManager requestWhenInUseAuthorization];
            }else if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [_locationManager requestAlwaysAuthorization];
            }
        }
    }
}

- (void)getLocation:(ButterFlyLocationManagerDrivingBlock)locationModelBlock {
    [_locationManager startUpdatingLocation];
    self.locationModelBlock = locationModelBlock;
}
#pragma mark - CoreLocation Delegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
                if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
                    [_locationManager requestWhenInUseAuthorization];
                }else if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
                {
                    [_locationManager requestAlwaysAuthorization];
                }
            }
        }
            break;
        case kCLAuthorizationStatusNotDetermined:
            break;
        case kCLAuthorizationStatusDenied:
            [MBProgressHUD showAutoDissmissAlertView:nil msg:@"请在设置-隐私-定位服务中开启定位功能"];
            break;
        case kCLAuthorizationStatusRestricted:
            [MBProgressHUD showAutoDissmissAlertView:nil msg:@"定位服务无法使用"];
            break;
        default:
            break;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0){
             
             //获取详细信息
             //             placemark.addressDictionary
             
             CLPlacemark *placemark = [array objectAtIndex:0];
             //NSLog(@"%@",placemark.name);//具体位置
             //获取城市
             //             self.country = placemark.country;
             //             self.province = placemark.administrativeArea;
             //             self.city = placemark.locality;
             //             self.district = placemark.subLocality;
             //             self.street = placemark.thoroughfare;
             self.locationModel = [[ButterFlyLocationModel alloc]init];
             self.locationModel.country = placemark.country;
             self.locationModel.province = placemark.administrativeArea;
             self.locationModel.city = placemark.locality;
             self.locationModel.district = placemark.subLocality;
             self.locationModel.street = placemark.thoroughfare;
             
             //返回计算得到的地理位置模型
             if (self.locationModelBlock) {
                 self.locationModelBlock(self.locationModel);
             }
             //             NSDictionary *dic = self.locationModel.mj_keyValues;
//             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//             [defaults setObject:dic forKey:@"locationModel"];
             
             NSString *city = placemark.locality;
             if (!city) {
                 city = placemark.administrativeArea;
             }
             if([city rangeOfString:@"市"].location != NSNotFound){
                 city = [city stringByReplacingOccurrencesOfString:@"市" withString:@""];
             }else if([city rangeOfString: @"自治区"].location != NSNotFound){
                 city = [city stringByReplacingOccurrencesOfString: @"自治区" withString: @""];
             }else if([city rangeOfString: @"自治州"].location != NSNotFound){
                 city = [city stringByReplacingOccurrencesOfString: @"自治州" withString: @""];
             }else if([city rangeOfString:@"特别行政区"].location != NSNotFound){
                 city = [city stringByReplacingOccurrencesOfString:@"特别行政区" withString:@""];
             }
             
             NSMutableDictionary * locations =[NSMutableDictionary dictionary];
             [locations setObject:city forKey:@"LocationCity"];
             NSString *currentLocationSubCity = [NSString stringWithFormat:@"%@%@",placemark.locality?:@"",placemark.subLocality?:@""];
             [locations setObject:currentLocationSubCity forKey:@"currentLocationSubCity"];
             if (placemark.location) {
                 CLLocation *locationMar = [placemark.location locationMarsFromEarth];
                 CLLocation *locationBear = [locationMar locationBearPawFromMars];
                 NSString *lontitude   = [NSString stringWithFormat:@"%.8f",locationBear.coordinate.longitude];
                 NSString *latitude    = [NSString stringWithFormat:@"%.8f",locationBear.coordinate.latitude];
                 
                 NSArray *locationList = [placemark.addressDictionary objectForKey:@"FormattedAddressLines"];
                 NSString *addr        =  locationList?locationList.firstObject:@"";
                 
                 NSString *time        = [NSString stringWithFormat:@"%@",placemark.location.timestamp?:@""];
                 
                 NSDictionary *currentLocationDic = @{@"lontitude":lontitude,@"latitude":latitude,@"addr":addr,@"time":time};
                 
                 [locations setObject:currentLocationDic forKey:@"currentString"];
             }
             //             if (city&&![CSAppUserSettings shareInstance].isLoacation) {
             //                 [CSAppUserSettings shareInstance].isLoacation = YES;
             //                 //                [[CSAppUserSettings shareInstance] setUserLocation:locations];
             //                 [[NSNotificationCenter defaultCenter]postNotificationName:CSARefreshLocation object:locations];
             //             }
             [manager stopUpdatingLocation];
             //结束定位任务之后开启发送数据
             //             [self startTimerWithBlock];
             //             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             //                 [self fetchHistoryDataAction];
             //             });
             
             //             [self fetchHistoryDataAction];
         }else if (error == nil && [array count] == 0){
             NSLog(@"No results were returned.");
         }else if (error != nil){
             NSLog(@"An error = %@", error);
         }
         
     }];
}


@end

@implementation ButterFlyLocationModel

@end

