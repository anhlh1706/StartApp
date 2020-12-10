//
//  UIDevice.swift
//  Base
//
//  Created by Hoàng Anh on 29/07/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

import UIKit.UIDevice

enum CurrentDevice {
    static let UUID =  UIDevice.current.identifierForVendor?.uuidString
    static let isIPad = UIDevice.current.userInterfaceIdiom == .pad
    static let isIPhone = UIDevice.current.userInterfaceIdiom == .phone
    
    /// Iphone 4.7"
    static let isIphone8 = Screen.height == 667
    /// Iphone 5.5"
    static let isIphonePlus = Screen.height == 736
    /// Iphone 5.8
    static let isIphoneX = Screen.height == 812
    /// Iphone 6.5
    static let isIphoneMax = Screen.height == 896
    ///nIncluded iphone 6Plus, 7Plus, 8Plus, XS Max, 11Pro Max
    static let isIphone414Width = (Screen.width == 414)
    /// Included iphone 6, 7, 8, X, XS, 11Pro
    static let isIphone375Width = (Screen.width == 375)
    /// Included iphone 5s, SE
    static let isIphone320Width = (Screen.width == 320)
    /// Included iphone X family
    static let isIphoneXSeries = (Screen.height == 812 || Screen.height == 896)
}
