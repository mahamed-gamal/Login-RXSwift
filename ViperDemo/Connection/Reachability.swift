//
//  File.swift
//  TooliEngine
//
//  Created by Abdelrahman Ahmed on 12/8/18.
//

import Reachability
import RxReachability
import SystemConfiguration.CaptiveNetwork

#if os(iOS)
import CoreTelephony
#endif

extension Reachability {
    
   public static let shared: Reachability = {
        
        let reachability = Reachability()
        try? reachability?.startNotifier()
        return reachability!
    }()
}

public extension Reachability {
    
    enum NetworkName {
        case wifi(name:String)
        case ethernet
        case other(name:String, carrier:String)
    }

    #if os(iOS)
    public class  func getWiFiSsid() -> String? {
        var ssid: String?
        if let interfaces = CNCopySupportedInterfaces() as? [CFString] { // check it again : Nasser
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
        return ssid
    }
    #endif

    static  func getNetworkType() -> NetworkName {
        #if os(iOS)
        let reachability = Reachability(hostname: "https://www.apple.com/")

        let status =  reachability?.connection ?? .none

        if status == .none {
            return .other(name: "", carrier: "")
        } else if status == .wifi {
            let wifiName = Reachability.getWiFiSsid()
            return .wifi(name: wifiName ?? "")
        } else if status == .cellular {
 
            let networkInfo = CTTelephonyNetworkInfo()
            let carrier2 = networkInfo.subscriberCellularProvider
            let carrier = carrier2?.carrierName ?? ""

            let carrierType = networkInfo.currentRadioAccessTechnology

            switch carrierType {
            case
            CTRadioAccessTechnologyGPRS?,CTRadioAccessTechnologyEdge?,CTRadioAccessTechnologyCDMA1x?: return .other(name: "2G", carrier: carrier)
            case CTRadioAccessTechnologyWCDMA?,
                 CTRadioAccessTechnologyHSDPA?,
                 CTRadioAccessTechnologyHSUPA?,
                 CTRadioAccessTechnologyCDMAEVDORev0?,
                 CTRadioAccessTechnologyCDMAEVDORevA?,
                 CTRadioAccessTechnologyCDMAEVDORevB?,
                 CTRadioAccessTechnologyeHRPD?:
                return .other(name: "3G" , carrier: carrier)
            case CTRadioAccessTechnologyLTE?: return .other(name:"4G", carrier: carrier)
            default: return .other(name: "", carrier: carrier)
            }
        } else {
            return .other(name:" ", carrier: "carrier")
        }
        #else
        
        let reachability = Reachability(hostname: "https://www.apple.com/")
        
        let status =  reachability?.connection ?? .none
        
        if status == .none {
            return .other(name: " ", carrier: "")
        } else if status == .wifi {
            return .wifi(name: "")
        } else {
          return .ethernet
        }
        #endif
    }

}
