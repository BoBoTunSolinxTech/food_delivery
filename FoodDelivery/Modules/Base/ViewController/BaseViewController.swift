
import UIKit
import Combine
import SnapKit

class BaseViewController: UIViewController {
    
    var bindings = Set<AnyCancellable>()
    
    var errorHandlerView : ErrorHandlerView?
    var view_model = BaseViewModel()
    var customerId = 0
   // var locationManager : LocationManager?
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let userVo = UserDefaultManager.getUserProfile() {
//            customerId = userVo.customerID ?? 0
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Current VC ::: \(self)")
        AppScreens.shared.currentVC = self
        checkViewControllerAndShowHideTabBar(vc: self)
        checkViewControllerAndAddBackBtn(vc: self)
        bindViewModel()
        setupUI()
        setupLanguage()
        setNavigationColor()
        bindData()
        addTapGestures()
        setupTest()
//        if let _ = locationManager {
//            self.locationManager = nil
//        }
//        locationManager = LocationManager.shared
    }
    
    
    

    @objc func reload(){
        setupLanguage()
        setupUI()
    }
    
    func removeNavigationBorder(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func checkViewControllerAndShowHideTabBar(vc : UIViewController) {
        let isTop : Bool = isTopViewController(vc: vc)
        isHiddenTabBar(isHidden: !isTop)
    }
    
    func checkViewControllerAndAddBackBtn(vc : UIViewController) {
        if !isTopViewController(vc: vc){
            addBackButton()
        }
    }
    
    func isTopViewController(vc : UIViewController) -> Bool {
        return navigationController?.children.first == vc
    }
    
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupUI(){
        isHiddenTabBar(isHidden: !isTopViewController(vc: self))
    }
    
    func setupLanguage(){
        
    }
    
    func bindViewModel() {

    }
    
    func bindData() {
        
    }
    
    func reloadScreen() {
        setupUI()
        setNavigationColor()
        setupLanguage()
    }
    
    func setupTest(){
        
    }
    
    func setNavigationColor(){
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22)]
            //appearance.backgroundColor = .primary_color
            appearance.shadowColor = .clear
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
            //navigationController?.navigationBar.barTintColor = .primary_color
        } else {
            if let navigationBar = navigationController?.navigationBar {
                let navigationLayer = CALayer()
                var bounds = navigationBar.bounds
                bounds.size.height += view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
                navigationLayer.frame = bounds
                navigationLayer.backgroundColor = UIColor.white.cgColor
                
                if let image = getImageFrom(layer: navigationLayer) {
                    navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
                }
            }
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get{
            return .portrait
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func isHiddenTabBar(isHidden : Bool) {
        tabBarController?.tabBar.isHidden = isHidden
    }
    
    func addTapGestures() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    func removeAllPerviousControllers(controller: AnyClass) {
        navigationController?.viewControllers.removeAll(where: { (vc) -> Bool in
            return !vc.isKind(of: controller) && !vc.isKind(of: controller)
        })
    }
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
        willDismissKeyBoard()
    }
    
    func showNoInternetConnectionAlert(){

    }
    
    func willDismissKeyBoard() {
        
    }
    
    func isShowNoDataAndInternet(isShow : Bool , isServerError : Bool = false) {
        errorHandlerView?.removeFromSuperview()
        errorHandlerView = ErrorHandlerView(frame: view.frame)
        errorHandlerView?.translatesAutoresizingMaskIntoConstraints = false
        errorHandlerView?.delegate = self
        if isShow {
            errorHandlerView?.setupView(isShow: isShow, isServerError: isServerError)
            view.addSubview(errorHandlerView!)
            errorHandlerView?.snp.makeConstraints({ (errorView) in
                errorView.left.equalToSuperview()
                errorView.right.equalToSuperview()
                errorView.centerY.equalToSuperview()
            })
            
        } else {
            errorHandlerView?.removeView()
        }
        
    }
    
    func setupNavigationRightBarButton() {
        
//        let menuBtn = UIButton(type: .custom)
//        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 100, height: 20)
//        menuBtn.addTarget(self, action: #selector(didTapRightBarItem), for: .touchUpInside)
//        let menuBarItem = UIBarButtonItem(customView: menuBtn)
//        //menuBtn.layer.cornerRadius = 17.5
//        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 35)
//        currWidth?.isActive = true
//        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 35)
//        currHeight?.isActive = true
////        let img = UIImage(named: "ic_logout")?.imageWithColor(color: .secondary_color)
////        menuBtn.setImage(img, for: .normal)
//        menuBtn.setTitle("Skip >>", for: .normal)
//        menuBtn.setTitleColor(.black, for: .normal)
//        navigationItem.rightBarButtonItem = menuBarItem
        
        let skip = UIBarButtonItem(title: "Skip >>", style: .plain, target: self, action: #selector(didTapRightBarItem))
        
        //skip.setTitleColor(.black, for: .normal)
        skip.tintColor = .black

        navigationItem.rightBarButtonItems = [skip]
        
    }
    
    func addBackButton(color : UIColor = UIColor.black , image : UIImage = UIImage(named: "ic_back")?.imageWithColor(color: .white) ?? UIImage() , backgroundColor : UIColor = UIColor.clear) {
        let backBtn = RoundedCornerUIButton(type: .custom)
        backBtn.shadowColor = .clear
        backBtn.borderColor = .clear
        backBtn.cornerRadius = 10
        backBtn.contentMode = .left
        backBtn.backgroundColor = backgroundColor
        backBtn.setImage(image, for: .normal)
        if UIDevice.is_iPadDevice() {
            backBtn.frame = CGRect(x: 10, y: 0, width: 40, height: 40)
        }
        else {
            backBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        }
        
        backBtn.addTarget(self, action: #selector(didTapBackBtn), for: .touchUpInside)
        backBtn.tintColor = color
        let backBarBtnItem = UIBarButtonItem(customView: backBtn)
        navigationItem.leftBarButtonItem = backBarBtnItem
    }
    
    @objc func didTapBackBtn() {
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapRightBarItem(){

    }
    
    func isUserLogin() -> Bool {
        return UserDefaultManager.retrieveUserLogin(key: UserDefaultManager.Keys.isUserLogin.rawValue)
    }
    
}

extension BaseViewController : ErrorHandlerDelegate {
    func didTapRetry() {
        if !InternetConnectionManager.isInternetAvailable() {
            showNoInternetConnectionToast()
            isShowNoDataAndInternet(isShow: true)
        } else {
            isShowNoDataAndInternet(isShow: false)
            reloadScreen()
        }
    }
}

extension BaseViewController {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        touch.view == view
    }
}
