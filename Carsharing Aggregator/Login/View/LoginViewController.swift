import UIKit


final class LoginViewController: UIViewController {
    weak var coordinator: LoginCoordinator?
    
    private var loginViewModel: LoginViewModelProtocol
    
    init(loginViewModel: LoginViewModelProtocol) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private var verifyCodeView: VerifyCodeView = {
        let view = VerifyCodeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private var verifyNumberView: VerifyNumberView = {
        let view = VerifyNumberView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    
    private lazy var sendCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отправить код", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.backgroundColor = UIColor.black.cgColor
        button.layer.cornerRadius = 16
        button.addTarget(self,
                         action: #selector(didTappedSendCodeButton),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.isHidden = true
        return button
    }()
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        sendCodeButton.isHidden = !verifyNumberView.needToShowButton()
    }
    
    @objc private func didTappedSendCodeButton() {
        loginViewModel.openRegister()
    }
    
    deinit {
        print("LoginVC is deinited")
    }
}

extension LoginViewController {
    
   private func addSubviews() {
       view.backgroundColor = .white
       view.addSubview(verifyNumberView)
       view.addSubview(sendCodeButton)
       view.addSubview(verifyCodeView)
    }
    
    private func setupView() {
        addSubviews()
        verifyNumberView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(222)
            make.leading.equalTo(view.snp.leading).offset(33)
            make.trailing.equalTo(view.snp.trailing).offset(-33)
            make.height.equalTo(200)
        }
        
        verifyCodeView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(173)
            make.leading.equalTo(view.snp.leading).offset(36)
            make.trailing.equalTo(view.snp.trailing).offset(-36)
      
        }
        
        sendCodeButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(287)
            make.trailing.equalTo(view.snp.trailing).offset(-33)
            make.leading.equalTo(view.snp.leading).offset(33)
            make.height.equalTo(52)
        }
    }
}

