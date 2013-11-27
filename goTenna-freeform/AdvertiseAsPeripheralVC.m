//
//  AdvertiseAsPeripheralVC.m
//  goTenna-freeform
//
//  Created by Julietta Yaunches on 11/26/13.
//  Copyright (c) 2013 Julietta Yaunches. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import "AdvertiseAsPeripheralVC.h"
#import "AppDelegate.h"

@interface AdvertiseAsPeripheralVC ()
@property(nonatomic, strong) CBPeripheralManager *myPeripheralManager;
@end

@implementation AdvertiseAsPeripheralVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myPeripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];

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
    if(peripheral.state == CBPeripheralManagerStatePoweredOn){
        self.statusLabel.text = @"Advertising Service";
    }else{
        self.statusLabel.text = [NSString stringWithFormat:@"Problem starting up. State: %d", peripheral.state];
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral
            didAddService:(CBService *)service
                    error:(NSError *)error {
    if (error) {
        self.statusLabel.text = [NSString stringWithFormat:@"Error publishing service: %@", [error localizedDescription];
    }
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral
                                       error:(NSError *)error {
    if (error) {
        self.statusLabel.text = [NSString stringWithFormat:@"Error advertising: %@", [error localizedDescription];
    }
}

@end
