//
//  Region.swift
//  BlueCap
//
//  Created by Troy Stribling on 8/24/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import Foundation
import CoreLocation

let DEFAULT_REGION_RADIUS = 100.0

public enum RegionState {
    case Start, Inside, Outside
}

public class Region {
    
    internal let _region : CLRegion
    
    internal var regionPromise  : StreamPromise<RegionState>
    
    public var identifier : String {
        return self._region.identifier
    }
    
    public var notifyOnEntry : Bool {
        get {
            return self._region.notifyOnEntry
        }
        set {
            self._region.notifyOnEntry = newValue
        }
    }
    
    public var notifyOnExit : Bool {
        get {
            return self._region.notifyOnExit
        }
        set {
            self._region.notifyOnExit = newValue
        }
    }
    
    internal var region : CLRegion {
        return self._region
    }
        
    internal init(region:CLRegion, capacity:Int? = nil) {
        self._region = region
        if let capacity = capacity {
            self.regionPromise = StreamPromise<RegionState>(capacity:capacity)
        } else {
            self.regionPromise = StreamPromise<RegionState>()
        }
    }

}

