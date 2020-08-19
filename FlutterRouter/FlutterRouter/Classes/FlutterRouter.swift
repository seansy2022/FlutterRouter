//
//  exchangeMethod.swift
//  Router
//
//  Created by sean on 2020/8/15.
//  Copyright © 2020 sean. All rights reserved.
//

import UIKit
import Flutter

protocol RouterName {
    var routerName : String {
        get
    }
    
    var isInTabbar : Bool {
        get
    }
}

class RouterFlutterViewController: UIViewController, RouterName {
    var routerName: String {
        return "/"
    }
    
    var isInTabbar: Bool {
        return false
    }
    
    private var snapShotView :UIImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(snapShotView)
        snapShotView.frame = self.view.bounds
        if(isInTabbar == false) {
            FlutterRouter.shared.viewController?.pushRoute(routerName)
            self.view.addSubview(FlutterRouter.shared.viewController?.view ?? UIView())
            FlutterRouter.shared.viewController?.view.frame = self.view.bounds
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FlutterRouter.shared.viewController?.viewWillAppear(false)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        snapShotView.image = snapImg()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
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


class FlutterRouter: NSObject{
    static let _share = FlutterRouter()
    var viewController: FlutterViewController?
    var chanel: FlutterMethodChannel?
    static var shared : FlutterRouter  {
        get{
            return _share
        }
        
    }
    
    static func register(viewController: FlutterViewController) {
        shared.viewController = viewController;
    }
    
}

