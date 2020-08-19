# FlutterRouter# FlutterRouter
1.在创建Engine之后，注册routter并将创建的viewController传进来
``` swift
     FlutterRouter.register(viewController: controller)
```

2.继承RouterFlutterViewController
 * 在routerName返回对应的路由名
 * 如果是viewController在UITabbarController中
 在isInTabbar返回ture
``` swift
class  LoginController: RouterFlutterViewController {
    override var routerName : String {
        get {
            return "/login"
        }
     }
    
    override var isInTabbar: Bool {
        get {
            return true
        }
    }
}
```
