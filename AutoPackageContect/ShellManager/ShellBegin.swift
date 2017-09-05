//
//  ShellBegin.swift
//  AutoPackageContect
//
//  Created by zlm on 2017/9/4.
//  Copyright © 2017年 Yealink. All rights reserved.
//

import Cocoa

class ShellBegin: NSObject {
    static let getInstance = ShellBegin()
    var isRuning = false
    
    
    class func begin() -> Bool {
        if getInstance.isRuning {
            return false
        }
//        imformationPath = infoPath
        getInstance.isRuning = true
        YLLog.getInstance.logs = ""
        
 
        //获取文件信息
        let audioV = DataManager.getAudioVersion()
        let h323V = DataManager.getH323Version()
        let sipV = DataManager.getSipVersion()
        let videoV = DataManager.getVideoVersion()
        print("get File Data: audioV:\(String(describing: audioV)) h323V:\(h323V) sipV:\(sipV) videoV:\(String(describing: videoV))")
        //拷贝并替换文件
        if audioV != nil && (audioV?.characters.count)! > 0 {
            
            let path = classPath + "audio/" + audioV! + ".a"
            let goalURL = URL(fileURLWithPath: goalPath + "audio/\(audioName)")
            let isExist = FileManager.default.fileExists(atPath: path)
            if isExist {
                do {
                    
                    try FileManager.default.removeItem(at: goalURL)
                    print("begin path: \(path)\n goal path:\(goalPath + "audio/\(audioName)")")
                    try FileManager.default.copyItem(at: URL(fileURLWithPath: path), to: goalURL)
                }catch {
                    print("replace Audio file is fail")
                }
            }
        }
        if h323V != nil && (h323V?.characters.count)! > 0 {
            let path = classPath + "h323/" + h323V! + ".a"
            let goalURL = URL(fileURLWithPath: goalPath + "h323/\(h323Name)")
            let isExist = FileManager.default.fileExists(atPath: path)
            if isExist {
                do {
                    try FileManager.default.removeItem(at: goalURL)
                    print("begin path: \(path)\n goal path:\(goalURL)")
                    try FileManager.default.copyItem(at: URL(fileURLWithPath: path), to: goalURL)
                }catch {
                    print("replace h323 file is fail")
                }
            }
        }
        if sipV != nil && (sipV?.characters.count)! > 0 {
            let path = classPath + "sip/" + sipV! + ".a"
            let goalURL = URL(fileURLWithPath: goalPath + "sip/\(sipName)")
            let isExist = FileManager.default.fileExists(atPath: path)
            if isExist {
                do {
                    try FileManager.default.removeItem(at: goalURL)
                    print("begin path: \(path)\n goal path:\(goalURL)")
                    try FileManager.default.copyItem(at: URL(fileURLWithPath: path), to: goalURL)
                }catch {
                    print("replace sip file is fail")
                }
            }
        }
        if videoV != nil && (videoV?.characters.count)! > 0 {
            let path = classPath + "video/" + videoV! + ".a"
            let goalURL = URL(fileURLWithPath: goalPath + "video/\(videoName)")
            let isExist = FileManager.default.fileExists(atPath: path)
            if isExist {
                do {
                    try FileManager.default.removeItem(at: goalURL)
                    print("begin path: \(path)\n goal path:\(goalURL)")
                    try FileManager.default.copyItem(at: URL(fileURLWithPath: path), to: goalURL)
                }catch {
                    print("replace video file is fail")
                }
            }
        }
        print("----copy file end----")
        
        print("write in Version Number")
        DataManager.getInstance.writePackageVersion()
        
        
        
        //#路径
        let date = showNormalDate(timeInterval: Date().timeIntervalSince1970)
        let ipaPath = kShellPath + "/autoBuildIPA/" + date
        let ipaName = kProjectName + ".ipa"
        
        //cd $shellPath
        
        ///Users/zlm/Documents/VCM3.0ScriptFile
        print("-----build begin-----")
        let xcarchive = ipaPath + "/" + kProjectName + ".xcarchive"
        DataManager.runScript(path: kCodebuildPath, arguments: ["-workspace", kXcworkspacePath, "-scheme", kProjectName, "-configuration", kBuildConfigType, "clean", "-archivePath", xcarchive, "archive"])
        print("----build end----")
        var result = FileManager.default.fileExists(atPath: xcarchive)
        if result == false {
            //检查文件是否存在
            log("生成.app文件失败")
        }else {
            log("生成.app文件成功")
        }
       
        //打包api
        DataManager.runScript(path: kCodebuildPath, arguments: ["-exportArchive", "-exportOptionsPlist", ipaPath + "/" + kProjectName + ".xcarchive/info.plist", "-archivePath", ipaPath + "/" + kProjectName + ".xcarchive", "-exportPath", ipaPath + "/"])
        print("------export ipa end------")
        result = FileManager.default.fileExists(atPath: ipaPath + "/" + kProjectName + ".ipa")
        if result == false {
             //检查文件是否存在
            log("打包ipa文件失败")
        }else {
            log("打包ipa文件成功")
        }
        //#build
        //xcodebuild -workspace $SOURCEPATH/$SCHEMENAME/$SCHEMENAME.xcworkspace -scheme $SCHEMENAME -configuration $buildConfig clean -archivePath $IPAPATH/$SCHEMENAME.xcarchive archive
        //
        //xcodebuild -exportArchive -exportOptionsPlist $IPAPATH/$SCHEMENAME.xcarchive/info.plist -archivePath $IPAPATH/$SCHEMENAME.xcarchive -exportPath $IPAPATH/
        //
        if kUploadUrlType == "fir" {
            print("login fir account")
            DataManager.runScript(path: kFirPath, arguments: ["login", kFirToken])
            print("begin uploading .ipa file to fir.im")
            DataManager.runScript(path: kFirPath, arguments: ["p", ipaPath + "/" + ipaName])
            DataManager.runScript(path: kCurlPath, arguments: ["-X", "PUT", "--data", "changelog=", "http://fir.im/api/v2/app/" + kBundleID + "?token=" + kFirToken])
        }
        if kUploadUrlType == "pgyer" {
            print("begin uploading to pgyer")
            DataManager.runScript(path: kCurlPath, arguments: ["-F", "file=@" + ipaPath + "/" + ipaName, "-F", "uKey=" + kPgyerUserKey, "-F", "_api_key=" + kPgyerAPIKey, "https://qiniu-storage.pgyer.com/apiv1/app/upload"])
        }
        print("-----------operation end!-------------")
        log("-----------操作结束!-------------")
        getInstance.isRuning = false
        return true
    }
    //更新最新代码
    class func updateGit(gitPath: String, branchname: String) {
        
        
//        DataManager.runScript(path: kCDPath, arguments: [kProjectPath, gitPath])
//        let branchname = "master"
        //git update
        DataManager.runScript(path: kGitShellPath, arguments: ["checkout",gitPath, kBranchName])
        
        //git pull
        DataManager.runScript(path: kGitShellPath, arguments: ["pull", gitPath])
        
        //回退到最新代码 git reset --hard master
        DataManager.runScript(path: kGitShellPath, arguments: ["reset", "--hard"])
        

    }
    
    
    
}
