#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
@property(nonatomic, strong) CBPeripheralManager *myPeripheralManager;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myPeripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
}

- (IBAction)advertisePeripheral:(id)sender {
    CBUUID *myCharacteristicUUID = [CBUUID UUIDWithString:@"241858C4-6FBD-40DE-9C97-2EF41401EFA2"];

    CBMutableCharacteristic *myCharacteristic =
            [[CBMutableCharacteristic alloc] initWithType:myCharacteristicUUID
                                               properties:CBCharacteristicPropertyRead
                                                    value:nil permissions:CBAttributePermissionsReadable];

    CBMutableService *myService = [[CBMutableService alloc] initWithType:SERVICE_ID primary:YES];
    myService.characteristics = @[myCharacteristic];

    [self.myPeripheralManager addService:myService];

    [self.myPeripheralManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey :
            @[myService.UUID] }];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    NSLog(@"Peripheral manager updated state: %d", peripheral.state);
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral
            didAddService:(CBService *)service
                    error:(NSError *)error {
    if (error) {
        NSLog(@"Error publishing service: %@", [error localizedDescription]);
    }
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral
                                       error:(NSError *)error {
    if (error) {
        NSLog(@"Error advertising: %@", [error localizedDescription]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
