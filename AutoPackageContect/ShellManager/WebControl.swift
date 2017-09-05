//
//  WebControl.swift
//  AutoPackageContect
//
//  Created by zlm on 2017/9/4.
//  Copyright © 2017年 Yealink. All rights reserved.
//

import Cocoa

class WebControl: NSObject {

    class func addBody(body: String) -> String {
        var htmlStr = "<html xmlns='http://www.w3.org/1999/xhtml' xml:lang='en' lang='en'><head><title></title><meta http-equiv='Content-Type' content='text/html; charset=utf-8' /></head><body>"
        htmlStr = htmlStr + body + "</body></html>"
        return htmlStr
    }
    
    
}
