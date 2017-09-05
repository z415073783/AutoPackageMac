//
//  YLLog.swift
//  AutoPackageContect
//
//  Created by zlm on 2017/9/4.
//  Copyright © 2017年 Yealink. All rights reserved.
//

import Cocoa

func log( _ closure: @autoclosure () -> String?) {
    YLLog.getInstance.logs += closure()! + "<br />"
}


class YLLog: NSObject {
    static let getInstance = YLLog()
    var logs: String = ""
}
