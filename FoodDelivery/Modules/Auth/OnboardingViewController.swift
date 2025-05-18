
import UIKit

class OnboardingViewController : BaseViewController {
    
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnGetStart: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        super.setupUI()
        self.navigationController?.navigationBar.isHidden = true
        btnGetStart.addRoundCorners(maskedCorners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 8, isAll: true)
        btnContinue.addBorder(borderWidth: 1, borderColor: .primary_color, bgColor: .white, isRounded: false, cornerRadius: 8)
    }
    
    override func bindData() {
        super.bindData()
        
        btnGetStart.tapPublisher.sink{
            AppScreens.AuthVC.navigateToLoginVC.show()
        }.store(in: &bindings)
        
        btnContinue.tapPublisher.sink{
            AppScreens.AuthVC.navigateToHomeVC.show()
        }.store(in: &bindings)
    }

}
