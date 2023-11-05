
import UIKit

class TabBarViewController: UITabBarController {
    //MARK: Properties
    var homeBtn : UITabBarItem!
    var bookNowBtn : UITabBarItem!
    var contactBtn : UITabBarItem!
    var showSubscription : Bool!
    
    // private var customHeight: CGFloat = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.clipsToBounds = true // This ensures that content within the increased height won't overflow.
        let customTabBar = CustomTabBar()
        self.setValue(customTabBar, forKey: "tabBar")
       // UITabBar.appearance().tintColor = .clear
        self.tabBar.makeSpecificCornerRound(corners: .topTwo, radius: 25)
        //        UITabBar.appearance().unselectedItemTintColor = Asset.Colors.appColor2.color
       // UITabBar.appearance().backgroundImage = UIImage(named: "footer")
        // setUpTabController()
        setUpTabbarNavigation()
    }
    
    
    func setUpTabController () {
        if #available(iOS 13, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            //      appearance.backgroundColor = UIColor(red: 6/255.0, green: 159/255.0, blue: 190/255.0, alpha: 1.0)
            
            appearance.backgroundColor = .white
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
            
            self.tabBarController?.tabBar.standardAppearance = appearance
            
            // Update for iOS 15, Xcode 13
            if #available(iOS 15.0, *) {
                self.tabBarController?.tabBar.scrollEdgeAppearance = appearance
            }
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
     //   setShadow()
        setupCustomTabBar()

    }
    //===================================================
    override func loadView() {
          super.loadView()
        //  self.tabBar.addSubview(btnMiddle)
      }
      func setupCustomTabBar() {
          let path : UIBezierPath = getPathForTabBar()
          let shape = CAShapeLayer()
          shape.path = path.cgPath
          shape.lineWidth = 3
          shape.strokeColor = UIColor(hex: "#FAD232", alpha: 1.0)!.cgColor// FAD232
          shape.fillColor = UIColor(hex: "#FAD232", alpha: 1.0)!.cgColor//UIColor.white.cgColor
          self.tabBar.layer.insertSublayer(shape, at: 0)
          self.tabBar.itemWidth = 40
          self.tabBar.itemPositioning = .centered
          self.tabBar.itemSpacing = 180
          self.tabBar.tintColor = UIColor(hex: "#fe989b", alpha: 1.0)
      }
      
      func getPathForTabBar() -> UIBezierPath {
          let frameWidth = self.tabBar.bounds.width
          let frameHeight = self.tabBar.bounds.height + 20
          let holeWidth = 150
          let holeHeight = 50
          let leftXUntilHole = Int(frameWidth/2) - Int(holeWidth/2)
          
          let path : UIBezierPath = UIBezierPath()
          path.move(to: CGPoint(x: 0, y: 0))
          path.addLine(to: CGPoint(x: leftXUntilHole , y: 0)) // 1.Line
          path.addCurve(to: CGPoint(x: leftXUntilHole + (holeWidth/3), y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*6,y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*8, y: holeHeight/2)) // part I
          
          path.addCurve(to: CGPoint(x: leftXUntilHole + (2*holeWidth)/3, y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2/5, y: (holeHeight/2)*6/4), controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2 + (holeWidth/3)/3*3/5, y: (holeHeight/2)*6/4)) // part II
          
          path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + (2*holeWidth)/3,y: holeHeight/2), controlPoint2: CGPoint(x: leftXUntilHole + (2*holeWidth)/3 + (holeWidth/3)*2/8, y: 0)) // part III
          path.addLine(to: CGPoint(x: frameWidth, y: 0)) // 2. Line
          path.addLine(to: CGPoint(x: frameWidth, y: frameHeight)) // 3. Line
          path.addLine(to: CGPoint(x: 0, y: frameHeight)) // 4. Line
          path.addLine(to: CGPoint(x: 0, y: 0)) // 5. Line
          path.close()
          return path
      }
    
    // MARK: -  set Tabbar Navigation
    private func setUpTabbarNavigation() {
        homeBtn = UITabBarItem()
        bookNowBtn = UITabBarItem()
        contactBtn = UITabBarItem()
        setUpTabBarElements()
        
        //MARK: set controller  in tabbar button
       // /*
        var VC1 = UIViewController()
        var nav1 = UINavigationController()
        
        var showSubscriptionValue = UserDefaults.standard.value(forKey:"showSubscription")
        
        if showSubscriptionValue as! String == "no"{
           showSubscription = false
        }else{
            showSubscription = true
        }
        if showSubscription {
             //  VC1 = CoachesRequestVC.instantiate(fromAppStoryboard: .main)
             VC1 = SubscriptionVC.instantiate(fromAppStoryboard: .main)
            nav1 = SwipeableNavigationController(rootViewController: VC1)
            nav1.isNavigationBarHidden = true
        }else{
            VC1 = CoachesRequestVC.instantiate(fromAppStoryboard: .main)
            nav1 = SwipeableNavigationController(rootViewController: VC1)
            nav1.isNavigationBarHidden = true
        }
        
        //*/
        /*
        let VC1 = CoachesRequestVC.instantiate(fromAppStoryboard: .main)
        let nav1 = SwipeableNavigationController(rootViewController: VC1)
        nav1.isNavigationBarHidden = true
        */
        let VC2 = ChatVC.instantiate(fromAppStoryboard: .main)
        let nav2 = SwipeableNavigationController(rootViewController: VC2)
        nav2.isNavigationBarHidden = true
        
        let VC3 = ProfileVC.instantiate(fromAppStoryboard: .main)
        let nav3 = SwipeableNavigationController(rootViewController: VC3)
        nav3.isNavigationBarHidden = true
        
        VC1.tabBarItem = homeBtn
        VC2.tabBarItem = bookNowBtn
        VC3.tabBarItem = contactBtn
        
        let viewControllers = [nav1,nav2,nav3]
        //[nav1, nav2, nav3,nav4]
        
        self.viewControllers = viewControllers
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
    }
    
    // MARK: - Tabbar Elemements / Like as image and name
    private func setUpTabBarElements() {
        self.homeBtn.imageInsets    = UIEdgeInsets(top:15, left:0, bottom: 0, right: 0)
        self.bookNowBtn.imageInsets = UIEdgeInsets(top:-28, left:0, bottom: 0, right: 0)
        //self.bookNowBtn.imageInsets = UIEdgeInsets(top: -70, left:0, bottom: 20, right: 0)
        self.contactBtn.imageInsets = UIEdgeInsets(top:15, left:0, bottom: 0, right: 0)
        
        self.homeBtn.image     = UIImage(named: "chat")?.withRenderingMode(.alwaysOriginal)
       // self.bookNowBtn.image   = UIImage(named: "Group_34408")?.withRenderingMode(.alwaysOriginal)
        self.bookNowBtn.image   = UIImage(named: "tabhomeBtn")?.withRenderingMode(.alwaysOriginal)
        self.contactBtn.image   = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        self.homeBtn.selectedImage      = UIImage(named: "ChatClickable")?.withRenderingMode(.alwaysOriginal)
        //self.bookNowBtn.selectedImage   = UIImage(named: "Group 34406")?.withRenderingMode(.alwaysOriginal)
        self.contactBtn.selectedImage   = UIImage(named: "ProfileClickable")?.withRenderingMode(.alwaysOriginal)
        self.homeBtn.title      = ""
        self.bookNowBtn.title   = ""
        self.contactBtn.title   = ""
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
    }
    //MARK: FOR TAB BAR SHADOW AND CORNER
    func setShadow(){
        if tabBar.viewWithTag(200) != nil{
            return
        }
        
        var height = 0.0
        var width = 0.0
        if UIDevice.hasNotch{
            height = tabBar.frame.height * 1
            width = tabBar.frame.width * 1
        }
        else{
            height = tabBar.frame.height * 1
            width = tabBar.frame.width * 1
        }
        
        let x = (tabBar.frame.width - width) / 2
        //  tabBar.shadowImage = UIImage()
        //  tabBar.backgroundImage = UIImage(named: "bg")
        // tabBar.backgroundColor = .yellow//Asset.Colors.appColor2.color
        // tabBar.clipsToBounds = false
        
//        let bgView = UIImageView(image: UIImage(named: "tabbabrBackgroundImg"))
//        bgView.frame = self.tabBar.bounds
//        bgView.contentMode = .scaleAspectFill
//        self.tabBar.addSubview(bgView)
//        self.tabBar.sendSubviewToBack(bgView)
        
        let tabGradientView = UIView(frame: CGRect(x: x, y: 0, width: width, height: height))
        tabGradientView.tag = 200
        tabGradientView.layer.cornerRadius = 25
        tabGradientView.layer.shadowRadius = 4.0
        tabGradientView.layer.shadowOpacity = 0.6
        
        // tabGradientView.layer.shadowColor = UIColor.gray.cgColor
        tabGradientView.backgroundColor = .clear
        tabGradientView.translatesAutoresizingMaskIntoConstraints = false;
        // tabGradientView.layer.cornerRadius = tabGradientView.frame.height / 2
        tabGradientView.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabGradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabGradientView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // tabGradientView.center = tabBar.center
        // tabBar.sendSubviewToBack(tabGradientView)
    }
}

extension UIColor {
    public convenience init?(hex: String, alpha: Double = 1.0) {
        var pureString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (pureString.hasPrefix("#")) {
            pureString.remove(at: pureString.startIndex)
        }
        if ((pureString.count) != 6) {
            return nil
        }
        let scanner = Scanner(string: pureString)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            self.init(
                red: CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(hexNumber & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0))
            return
        }
        return nil
    }
}

extension UIViewController
{
    class var storyboardID : String {
        return "\(self)"
    }
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}

enum AppStoryboard : String {
    case main = "Main"
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

extension UIDevice {
    static var hasNotch: Bool {
        guard #available(iOS 11.0, *), let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return false }
        if UIDevice.current.orientation.isPortrait {
            return window.safeAreaInsets.top >= 44
        } else {
            // return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0 ||  window.safeAreaInsets.bottom == 0
            return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
        }
    }
}

extension UIView
{
    func makeSpecificCornerRound(corners: RoundedCorner,radius: CGFloat){
        switch corners {
        case .bottomTwo:
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        case .topTwo:
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            print("")
        case .leftTwo:
            print("")
        case .rightTwo:
            print("")
        }
    }
}

enum RoundedCorner {
    case topTwo
    case bottomTwo
    case leftTwo
    case rightTwo
}

class CustomTabBar: UITabBar {
    // Adjust the desired height here
    private var customHeight: CGFloat = 70
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = customHeight
        return sizeThatFits
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: customHeight)
    }
}
//*/

