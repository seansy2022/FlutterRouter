//
//  exchangeMethod.swift
//  Router
//
//  Created by sean on 2020/8/15.
//  Copyright © 2020 sean. All rights reserved.
//

import UIKit
import Flutter

public protocol RouterName {
    var routerName : String {
        get
    }
    
    var isInTabbar : Bool {
        get
    }
}

open class RouterFlutterViewController: UIViewController, RouterName {
    public var routerName: String {
        return "/"
    }
    
    public var isInTabbar: Bool {
        return false
    }
    
    private var snapShotView :UIImageView = UIImageView()
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(snapShotView)
        snapShotView.frame = self.view.bounds
        if(isInTabbar == false) {
            FlutterRouter.shared.viewController?.pushRoute(routerName)
            self.view.addSubview(FlutterRouter.shared.viewController?.view ?? UIView())
            FlutterRouter.shared.viewController?.view.frame = self.view.bounds
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FlutterRouter.shared.viewController?.viewWillAppear(false)
    }
    
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        snapShotView.image = snapImg()
    }
    
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        FlutterRouter.shared.viewController?.pushRoute(routerName)
        self.view.addSubview(FlutterRouter.shared.viewController?.view ?? UIView())
        FlutterRouter.shared.viewController?.view.frame = self.view.bounds
    }
    
    
    private func snapImg() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, false, 0.0)
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}


public class FlutterRouter: NSObject{
    static let _share = FlutterRouter()
    var viewController: FlutterViewController?
    var chanel: FlutterMethodChannel?
    public  static var shared : FlutterRouter  {
        get{
            return _share
        }
        
    }
    
    public  static func register(viewController: FlutterViewController) {
        shared.viewController = viewController;
    }
    
}

