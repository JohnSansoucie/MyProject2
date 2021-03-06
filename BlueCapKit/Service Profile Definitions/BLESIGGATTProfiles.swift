//
//  BLESIGGATTProfiles.swift
//  BlueCap
//
//  Created by Troy Stribling on 7/25/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import Foundation
import CoreBluetooth
import BlueCapKit

public struct BLESIGGATT {

    //***************************************************************************************************
    // Device Information Service
    public struct DeviceInformationService : ServiceConfigurable {

        // ServiceConfigurable
        public static let uuid = "180a"
        public static let name = "Device Information"
        public static let tag  = "BLESIGGATT"
        
        public struct ModelNumber : CharacteristicConfigurable {
            
            // CharacteristicConfigurable
            public static let uuid = "2a24"
            public static let name = "Device Model Number"
            public static let permissions  = CBAttributePermissions.Readable | CBAttributePermissions.Writeable
            public static let properties   = CBCharacteristicProperties.Read
            public static let initialValue = Serde.serialize("Model A")
            
        }
        
        public struct SerialNumber : CharacteristicConfigurable {

            // CharacteristicConfigurable
            public static let uuid = "2a25"
            public static let name = "Device Serial Number"
            public static let permissions  = CBAttributePermissions.Readable | CBAttributePermissions.Writeable
            public static let properties   = CBCharacteristicProperties.Read
            public static let initialValue = Serde.serialize("AAA11")
            
        }
        
        public struct FirmwareRevision : CharacteristicConfigurable {

            // CharacteristicConfigurable
            public static let uuid = "2a26"
            public static let name = "Device Firmware Revision"
            public static let permissions  = CBAttributePermissions.Readable | CBAttributePermissions.Writeable
            public static let properties   = CBCharacteristicProperties.Read
            public static let initialValue = Serde.serialize("1.0")

        }
        
        public struct HardwareRevision : CharacteristicConfigurable {
            
            // CharacteristicConfigurable
            public static let uuid = "2a27"
            public static let name = "Device Hardware Revision"
            public static let permissions  = CBAttributePermissions.Readable | CBAttributePermissions.Writeable
            public static let properties   = CBCharacteristicProperties.Read
            public static let initialValue = Serde.serialize("1.0")
            
        }
        
        public struct SoftwareRevision : CharacteristicConfigurable {
            
            // CharacteristicConfigurable
            public static let uuid = "2a28"
            public static let name = "Device Software Revision"
            public static let permissions  = CBAttributePermissions.Readable | CBAttributePermissions.Writeable
            public static let properties   = CBCharacteristicProperties.Read
            public static let initialValue = Serde.serialize("1.0")

        }
        
        public struct ManufacturerName : CharacteristicConfigurable {
            
            // CharacteristicConfigurable
            public static let uuid = "2a29"
            public static let name = "Device Manufacturer Name"
            public static let permissions  = CBAttributePermissions.Readable | CBAttributePermissions.Writeable
            public static let properties   = CBCharacteristicProperties.Read
            public static let initialValue = Serde.serialize("gnos.us")
            
        }
    }
    
    //***************************************************************************************************
    // Battery Service
    public struct BatteryService : ServiceConfigurable {

        // ServiceConfigurable
        public static let uuid = "180f"
        public static let name = "Battery"
        public static let tag  = "BLESIGGATT"
        
        public struct Level : RawDeserializable, CharacteristicConfigurable, StringDeserializable {
            
            public let value : UInt8
            
            // CharacteristicConfigurable
            public static let uuid                      = "2a19"
            public static let name                      = "Battery Level"
            public static let permissions               = CBAttributePermissions.Readable | CBAttributePermissions.Writeable
            public static let properties                = CBCharacteristicProperties.Notify | CBCharacteristicProperties.Read
            public static let initialValue : NSData?    = Serde.serialize(UInt8(100))

            // RawDeserializable
            public var rawValue : UInt8 {
                return self.value
            }
            public init?(rawValue:UInt8) {
                self.value = rawValue
            }
            
            // StringDeserializable
            public static let stringValues = [String]()
            
            public var stringValue : [String:String] {
                return [Level.name:"\(self.value)"]
            }
            
            public init?(stringValue:[String:String]) {
                if let valueInit = uint8ValueFromStringValue(Level.name, stringValue) {
                    self.value = valueInit
                } else {
                    return nil
                }
            }

        }
    }

    //***************************************************************************************************
    // Tx Power Service
    public struct TxPowerService : ServiceConfigurable {

        // ServiceConfigurable
        public static let uuid = "1804"
        public static let name = "Tx Power Level"
        public static let tag  = "BLESIGGATT"

        public struct Level : RawDeserializable, CharacteristicConfigurable, StringDeserializable {
            
            public let value : Int8
            
            // CharacteristicConfigurable
            public static let uuid                      = "2a07"
            public static let name                      = "Tx Power Level"
            public static let permissions               = CBAttributePermissions.Readable | CBAttributePermissions.Writeable
            public static let properties                = CBCharacteristicProperties.Notify | CBCharacteristicProperties.Read
            public static let initialValue : NSData?    = Serde.serialize(Int8(-40))
            
            // RawDeserializable
            public var rawValue : Int8 {
                return self.value
            }
            public init?(rawValue:Int8) {
                self.value = rawValue
            }
            
            // StringDeserializable
            public static let stringValues = [String]()
            
            public var stringValue : [String:String] {
                return [Level.name:"\(self.value)"]
            }
            
            public init?(stringValue:[String:String]) {
                if let valueInit = int8ValueFromStringValue(Level.name, stringValue) {
                    self.value = valueInit
                } else {
                    return nil
                }
            }

        }
    }
    
}

public class BLESIGGATTProfiles {
    
    public class func create () {
        
        let profileManager = ProfileManager.sharedInstance
        
        //***************************************************************************************************
        // Device Information Service
        let deviceInformationService = ConfiguredServiceProfile<BLESIGGATT.DeviceInformationService>()
        let deviceModelNumberCharacteristic = StringCharacteristicProfile<BLESIGGATT.DeviceInformationService.ModelNumber>()
        let deviceSerialNumberCharacteristic = StringCharacteristicProfile<BLESIGGATT.DeviceInformationService.SerialNumber>()
        let deviceFirmwareVersion = StringCharacteristicProfile<BLESIGGATT.DeviceInformationService.FirmwareRevision>()
        let deviceHardwareRevision = StringCharacteristicProfile<BLESIGGATT.DeviceInformationService.HardwareRevision>()
        let deviceSoftwareRevision = StringCharacteristicProfile<BLESIGGATT.DeviceInformationService.SoftwareRevision>()
        let deviceManufactureName = StringCharacteristicProfile<BLESIGGATT.DeviceInformationService.ManufacturerName>()
        
        deviceInformationService.addCharacteristic(deviceModelNumberCharacteristic)
        deviceInformationService.addCharacteristic(deviceSerialNumberCharacteristic)
        deviceInformationService.addCharacteristic(deviceFirmwareVersion)
        deviceInformationService.addCharacteristic(deviceHardwareRevision)
        deviceInformationService.addCharacteristic(deviceSoftwareRevision)
        deviceInformationService.addCharacteristic(deviceManufactureName)
        profileManager.addService(deviceInformationService)
        

        //***************************************************************************************************
        // Battery Service
        let batteryService = ConfiguredServiceProfile<BLESIGGATT.BatteryService>()
        let batteryLevelCharcteristic = RawCharacteristicProfile<BLESIGGATT.BatteryService.Level>()
        
        batteryService.addCharacteristic(batteryLevelCharcteristic)
        profileManager.addService(batteryService)

        //***************************************************************************************************
        // Tx Power Service
        let txPowerService = ConfiguredServiceProfile<BLESIGGATT.TxPowerService>()
        let txPowerLevel = RawCharacteristicProfile<BLESIGGATT.TxPowerService.Level>()
        
        txPowerService.addCharacteristic(txPowerLevel)
        profileManager.addService(txPowerService)
    }
}