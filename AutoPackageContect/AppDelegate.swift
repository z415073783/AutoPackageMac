//
//  AppDelegate.swift
//  AutoPackageContect
//
//  Created by zlm on 2017/9/4.
//  Copyright © 2017年 Yealink. All rights reserved.
//

import Cocoa
import Swifter
let kSwiftPath = "/usr/bin/swift"
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        openLogServer()
    }
    var server:HttpServer!
    public func openLogServer() {
        DispatchQueue.main.async {
            do {
                self.server = HttpServer()
                
                self.server[""] = scopes {
                    do {
                        var htmlStr = "<html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'><head><title></title><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /></head><body>"
                        htmlStr = htmlStr + "打包系统已启动" + "</body></html>"
                        html {
                            body {
                                inner = htmlStr
                            }
                        }
                        
                    }catch {
                    }
                }
                self.server["/init"] = scopes {
                    do {
                        
                        
                        
                        
                    }catch {
                        
                    }
                }
                self.server["/vcmPackage"] = scopes {
                    do {
                        
                         let result = ShellBegin.begin()
                        
                        html {
                            body {
                                if result == false {
                                    inner = WebControl.addBody(body: "已有项目正在运行中,请稍候再试")
                                }else {
                                    inner = WebControl.addBody(body: YLLog.getInstance.logs)
                                }
                            }
                        }
                        
                    }catch {
                        
                    }
                }
                self.server["/vcmUpdate"] = scopes {
                    do {
//                        "master"
                        let result = ShellBegin.getInstance.isRuning
                        if result == false {
                            ShellBegin.updateGit(gitPath: kGitPath, branchname: kBranchName)
                        }
                        
                        
                        html {
                            body {
                                if result == true {
                                    inner = WebControl.addBody(body: "已有项目正在运行中,请稍候再试")
                                }else {
                                    inner = WebControl.addBody(body: YLLog.getInstance.logs)
                                }
                            }
                        }
                        
                    }catch {
                        
                    }
                }
                
                
                
                
                self.server["/log"] = scopes {
                    do {
                        
                    }catch {
                        
                    }
                }
                self.server["/file"] = shareFile(NSHomeDirectory() + "/Library/Caches/diagnose/app_1.log")
                self.server["/path"] = shareFilesFromDirectory(NSHomeDirectory())
                try self.server.start(portNumber)
            } catch  {
                
            }
        }
    }
    
    func runScript(path: String, arguments: [String]? = nil, _ isErrStop: Bool? = false) {
        
        print("---runScript begin-----path:\(path)\n arguments:\(String(describing: arguments))\n -------\n")
        let task = Process()
        task.launchPath = path
        task.arguments = arguments
        task.launch()
        task.waitUntilExit()
        if task.standardError != nil {
            print("----error-----path:\(path)\n arguments:\(String(describing: arguments))\n standardError:\(String(describing: task.standardError))-------\n")
        }
        if isErrStop == true {
            exit(0)
        }
    }
    

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

