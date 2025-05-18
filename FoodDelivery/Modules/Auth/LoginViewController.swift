
import UIKit

class LoginViewController: BaseViewController {
    
    
    @IBOutlet weak var inputBg: UIView!
    @IBOutlet weak var buttonBgView: UIView!
    @IBOutlet weak var btnPhonePrefix: UIButton!
    @IBOutlet weak var imgFlag: UIImageView!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var lblNewMember: UILabel!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var phoneOrEmailTextField: UITextField!
    @IBOutlet weak var phonePrefixView: UIView!
    @IBOutlet weak var btnPhone: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    var isPhone = true
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        super.setupUI()
        self.navigationController?.navigationBar.isHidden = true
        updateLoginView(loginType: .phone)
        btnPhone.addRoundCorners(maskedCorners: nil, radius: 8, isAll: true)
        btnEmail.addRoundCorners(maskedCorners: nil, radius:8, isAll: true)
        btnContinue.addRoundCorners(maskedCorners: nil, radius: 4, isAll: true)
        phoneOrEmailTextField.delegate = self
        btnSkip.addRoundCorners(maskedCorners: nil, radius: self.btnSkip.frame.height/2, isAll: true)
        inputBg.addBorder(borderWidth: 1, borderColor: .stoke_colorII, bgColor: .white, isRounded: false, cornerRadius: 8)
        buttonBgView.addBorder(borderWidth: 1, borderColor: .stoke_colorII, bgColor: .white, isRounded: false, cornerRadius: 8)
    }
    
    override func bindData() {
        super.bindData()
        
        btnBack.tapPublisher.sink{
//            AppScreens.AuthVC.navigateToOnboardingVC.show()
            self.navigationController?.popViewController(animated: true)
        }.store(in: &bindings)
        
        btnPhone.tapPublisher.sink{
            self.updateLoginView(loginType: .phone)
        }.store(in: &bindings)
        
        btnEmail.tapPublisher.sink{
            self.updateLoginView(loginType: .email)
        }.store(in: &bindings)
        
        btnContinue.tapPublisher.sink{ [self] in
            AppScreens.AuthVC.navigateToOTPVC(isPhone, phoneOrEmailTextField.text ?? "").show()
        }.store(in: &bindings)
    }


}

extension LoginViewController {
    func updateLoginView(loginType: LoginType) {
        btnContinue.isEnabled = false
        btnContinue.alpha = 0.3
        if loginType == .email {
            isPhone = false
            phonePrefixView.isHidden = true
            
            btnEmail.setTitleColor(.primary_color, for: .normal)
            btnPhone.setTitleColor(.dark_gray_color, for: .normal)
            
            btnEmail.backgroundColor = .button_active_color
            btnPhone.backgroundColor = .white
            
            phoneOrEmailTextField.placeholder = "example@domainname.com"
            phoneOrEmailTextField.keyboardType = .emailAddress
        }else{
            isPhone = true
            phonePrefixView.isHidden = false
            
            btnEmail.setTitleColor(.dark_gray_color, for: .normal)
            btnPhone.setTitleColor(.primary_color, for: .normal)
            
            btnEmail.backgroundColor = .white
            btnPhone.backgroundColor = .button_active_color
            phoneOrEmailTextField.placeholder = "09"
            phoneOrEmailTextField.keyboardType = .phonePad
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty {
            btnContinue.isEnabled = true
            btnContinue.alpha = 1
        }else{
            btnContinue.isEnabled = false
            btnContinue.alpha = 0.3
        }
        return true
    }
}
