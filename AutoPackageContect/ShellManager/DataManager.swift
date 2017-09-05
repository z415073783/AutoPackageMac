//
//  DataManager.swift
//  AutoPackage
//
//  Created by zlm on 2017/8/30.
//  Copyright © 2017年 Yealink. All rights reserved.
//

import Foundation

class DataManager {
    static let getInstance = DataManager()
    func getInitData() ->NSMutableDictionary {
        let data = NSMutableDictionary(contentsOf: URL(fileURLWithPath: kInfoPath))
        print("project plist data:\(data) kInfoPath = \(kInfoPath)")
        return data!
    }
    func getBuildVersion() -> String {
        let data = getInitData()
        let buildVersion = data["CFBundleVersion"]
        print("---buildVersion:\(String(describing: buildVersion))---")
        return buildVersion as! String
    }
    func writeInitData() {
        let buildVersion = DataManager.getInstance.getBuildVersion()
        let data = NSMutableDictionary(contentsOf: imformationURL)
        data?["Version Number"] = buildVersion
        //清除.a库版本记录
        data?["Audio Version Number"] = ""
        data?["H323 Version Number"] = ""
        data?["Sip Version Number"] = ""
        data?["Video Version Number"] = ""
        data?.write(to: imformationURL, atomically: true)
    }
    func writePackageVersion() {
        let needWriteData = NSMutableDictionary(contentsOf: imformationURL)
        let data = getInitData()
        data["CFBundleVersion"] = needWriteData?["Version Number"]
        data.write(to: URL(fileURLWithPath: kInfoPath), atomically: true)
    }
    
    
    //读取Audio版本号
    class func getAudioVersion() -> String? {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        return data?["Audio Version Number"] as? String
    }
    
    //读取H323版本号
    class func getH323Version() -> String? {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        return data?["H323 Version Number"] as? String
    }
    
    //读取Sip版本号
    class func getSipVersion() -> String? {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        return data?["Sip Version Number"] as? String
    }
    //读取Video版本号
    class func getVideoVersion() -> String? {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        return data?["Video Version Number"] as? String
    }
    
    
    
    @discardableResult class func runScript(path: String, arguments: [String]? = nil, _ isErrStop: Bool? = false) -> Bool? {
        print("---runScript begin-----path:\(path)\n arguments:\(String(describing: arguments))\n -------\n")
        let task = Process()
        task.launchPath = path
        task.arguments = arguments
        task.launch()
        task.waitUntilExit()
        if task.standardError != nil {
            print("----error-----path:\(path)\n arguments:\(String(describing: arguments))\n standardError:\(String(describing: task.standardError))-------\n")
//            log("----error-----path:\(path)\n arguments:\(String(describing: arguments))\n standardError:\(String(describing: task.standardError))-------\n")
            return false
        }
        if isErrStop == true {
            exit(0)
        }
        return true
    }
    
    
}




