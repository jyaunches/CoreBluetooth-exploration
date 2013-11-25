#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()
@property(nonatomic, strong) id myPeripheralManager;
@end

@implementation ViewController
- (IBAction)advertisePeripheral:(id)sender {

    CBUUID *myCharacteristicUUID = [CBUUID UUIDWithString:@"241858C4-6FBD-40DE-9C97-2EF41401EFA2"];
    CBUUID *myServiceUUID = [CBUUID UUIDWithString:@"BEFFC411-C5C7-4569-8991-D3E4CD52231B"];

    CBMutableCharacteristic *myCharacteristic =
            [[CBMutableCharacteristic alloc] initWithType:myCharacteristicUUID
                                               properties:CBCharacteristicPropertyRead
                                                    value:nil permissions:CBAttributePermissionsReadable];

    CBMutableService *myService = [[CBMutableService alloc] initWithType:myServiceUUID primary:YES];
    myService.characteristics = @[myCharacteristic];

    [self.myPeripheralManager addService:myService];

    [self.myPeripheralManager startAdvertising:@{ CBAdvertisementDataServiceUUIDsKey :
            @[myService.UUID] }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.myPeripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {

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

@end
