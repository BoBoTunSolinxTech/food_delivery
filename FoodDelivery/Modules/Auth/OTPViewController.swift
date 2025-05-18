
import UIKit
import AEOTPTextField
class OTPViewController: BaseViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var oTPTextField: AEOTPTextField!
    @IBOutlet weak var lblCount: UILabel!
    
    var parseString = ""
    var isPhone = true
    
    var timeCount = 60
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func bindData() {
        super.bindData()
        
        btnClose.tapPublisher.sink{
            //AppScreens.AuthVC.navigateToOnboardingVC.show()
            self.navigationController?.popViewController(animated: true)
        }.store(in: &bindings)
        
        
//        btnContinue.tapPublisher.sink{
//            AppScreens.AuthVC.navigateToHomeVC.show()
//        }.store(in: &bindings)
    }
    
    override func setupUI() {
        super.setupUI()
        
        oTPTextField.textContentType = .oneTimeCode
        oTPTextField.otpFilledBorderColor = .gray
        oTPTextField.otpFontSize = 16
        oTPTextField.otpDelegate = self
        oTPTextField.configure(with: 6)
        
        self.setupTimerForResend()
    }
    private func setupTimerForResend(){
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [unowned self] timer in
            timeCount -= 1
            let remainSec : String = timeCount == 0 ? "" : "\(self.timeCount) s"
            
            
            lblCount.text = (timeCount > 0 ? remainSec : "Resend OTP")
            lblCount.isUserInteractionEnabled = timeCount > 0 ? false : true
            
            
            if timeCount == 0 {
                timeCount = 60
                timer.invalidate()
            }
                    }
    }
}

extension OTPViewController : AEOTPTextFieldDelegate {
    
    func didUserFinishEnter(the code: String) {
        AppScreens.AuthVC.navigateToUserInfoVC(self.isPhone).show()
      }
}
