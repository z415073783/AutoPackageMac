
//  WholeDefine.swift
//  AutoPackage
//
//  Created by zlm on 2017/8/30.
//  Copyright © 2017年 Yealink. All rights reserved.
//
import Foundation
let kGitShellPath = "/usr/bin/git"
let kCodebuildPath = "/usr/bin/xcodebuild"
let kCDPath = "/usr/bin/cd"
let kFirPath = "/usr/local/bin/fir"
let kCurlPath = "/usr/bin/curl"

var kProjectPath: String {
    get {
        print("imformationURL path = \(imformationURL)")
        let data = NSMutableDictionary(contentsOf: imformationURL)
        let path = data?["ProjectPath"] as! String
        print("project path = \(path)")
        return path
    }
}
var kShellPath: String {
    get {
        print("imformationURL path = \(imformationURL)")
        let data = NSMutableDictionary(contentsOf: imformationURL)
        let path = data?["ScriptPath"] as! String
        print("shell path = \(path)")
        return path
    }
}
var kProjectName: String {
    get {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        let name = data?["ProjectName"] as! String
        print("project name = \(name)")
        return name
    }
}
var kInfoPath: String {
    get {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        let name = data?["Project Info List"] as! String
        print("Project Info List = \(name)")
        return name
    }
}
var kLogicServerPath: String {
    get {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        let name = data?["logicServer Path"] as! String
        print("logicServer Path = \(name)")
        return name
    }
}
var kBranchName: String {
    get {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        let name = data?["Branch Name"] as! String
        print("Branch Name = \(name)")
        return name
    }
}
//上传平台 pgy,fir
var kUploadUrlType: String {
    get {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        let name = data?["Upload URL Type"] as! String
        print("Upload URL Type = \(name)")
        return name
    }
}
//打包版本 Debug,Release
var kBuildConfigType: String {
    get {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        let name = data?["Build Config Type"] as! String
        print("Build Config Type = \(name)")
        return name
    }
}
//fir token
var kFirToken: String {
    get {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        let name = data?["Fir Token"] as! String
        print("Fir Token = \(name)")
        return name
    }
}
//pgyer user key
var kPgyerUserKey: String {
    get {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        let name = data?["Pgyer User key"] as! String
        print("Pgyer User key = \(name)")
        return name
    }
}
//pgyer api key
var kPgyerAPIKey: String {
    get {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        let name = data?["Pgyer API Key"] as! String
        print("Pgyer API Key = \(name)")
        return name
    }
}
var kBundleID: String {
    get {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        let name = data?["Bundle ID"] as! String
        print("Bundle ID = \(name)")
        return name
    }
}
var kXcworkspacePath: String {
    get {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        let name = data?["Project Workspace Path"] as! String
        print("Project Workspace Path = \(name)")
        return name
    }
}
var kGitPath: String {
    get {
        let data = NSMutableDictionary(contentsOf: imformationURL)
        let name = data?["GitPath"] as! String
        print("GitPath = \(name)")
        return name
    }
}





let imformationURL = URL(fileURLWithPath: imformationPath)
let classPath = "ClassFile/"
let goalPath = kLogicServerPath + "/yllibs/"
let audioName = "libaudio_engine.a"
let h323Name = "libh323app.a"
let sipName = "libsipapp.a"
let videoName = "libVideo.a"

//显示正常的时间格式 yyyy/MM/dd HH:mm:ss
func showNormalDate(timeInterval: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: timeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = DateFormatter.Style.full
    dateFormatter.dateFormat = "yyyy_MM_dd_HH_mm_ss"
    return dateFormatter.string(from: date)
}

