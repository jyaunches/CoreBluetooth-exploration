#import <CoreBluetooth/CoreBluetooth.h>
#import "NearbyPeripheralsVC.h"
#import "AppDelegate.h"

@interface NearbyPeripheralsVC ()
@property(nonatomic, strong) CBCentralManager *myCentralManager;
@end

@implementation NearbyPeripheralsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBCentralManagerStatePoweredOn) {
        NSLog(@"Central manager status, powered on");
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
        [self.myCentralManager scanForPeripheralsWithServices:@[SERVICE_ID] options:options];
    }else{
        NSLog(@"Central manager updated state: %d", central.state);
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"Discovered Peripheral!!");
}


@end
