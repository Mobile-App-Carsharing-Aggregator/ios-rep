import UIKit
import SnapKit

final class EnterViewController: UIViewController {
    
    private let registrationViewModel = RegistrationViewModel()
    
    var currentButtonState: EnterButtonState = .login {
        didSet {
            updateButtonColors()
        }
    }
    
    private let enterViewModel: EnterViewModel
    
    init(enterViewModel: EnterViewModel) {
        self.enterViewModel = enterViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let customDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loginButton = UIButton(
        for: .login,
        selectionState: currentButtonSelectionState,
        target: self,
        action: #selector(didTapLoginButton))
    
    private lazy var registrationButton = UIButton(
        for: .registration,
        selectionState: currentButtonSelectionState,
        target: self,
        action: #selector(didTapRegistrationButton))
    
    var currentButtonSelectionState: EnterButtonState.ButtonSelectionState {
        return currentButtonState == .login ? .selected : .deselected
    }
    
    private var loginView: LoginView = {
        let view = LoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var registrationView: RegistrationView = {
        let view = RegistrationView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var enterButton = UIButton(
        for: currentButtonState,
        target: self,
        action: #selector(didTapEnterButton))
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 21
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registrationView.registrationViewModel = registrationViewModel
        enterViewModel.registrationViewModel = registrationViewModel
    }
    
    @objc private func didTapRegistrationButton() {
        if loginView.isHidden == false {
            loginView.isHidden = true
        }
        currentButtonState = .registration
        registrationView.isHidden = false
        
    }

    @objc private func didTapLoginButton() {
        if registrationView.isHidden == false {
            registrationView.isHidden = true
        }
        currentButtonState = .login
        loginView.isHidden = false
    }
    
    @objc private func didTapEnterButton() {
        switch currentButtonState {
            case .login:
            print("login pressed")
            enterViewModel.isSubmitLoginEnabled()
            case .registration:
            print("registration pressed")
            enterViewModel.isSubmitRegistrationEnabled()
            }
    }
    private func updateButtonColors() {
        loginButton.setTitleColor(EnterButtonState.login.color(for: currentButtonSelectionState), for: .normal)
        registrationButton.setTitleColor(EnterButtonState.registration.color(for: currentButtonSelectionState), for: .normal)
        updateEnterButtonTitle()
    }
    
    private func updateEnterButtonTitle() {
        enterButton.setTitle(currentButtonState.enterTitle, for: .normal)
        
    }
    
    deinit {
        print("LoginVC is deinited")
    }
}

extension EnterViewController {
    
    private func addSubviews() {
        view.backgroundColor = .white
        view.addSubview(loginView)
        view.addSubview(registrationView)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(customDividerView)
        stackView.addArrangedSubview(registrationButton)
        view.addSubview(stackView)
        view.addSubview(enterButton)
    }
    
    private func setupView() {
        addSubviews()
        updateButtonColors()
        loginView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.leading.equalTo(view.snp.leading).offset(33)
            make.trailing.equalTo(view.snp.trailing).offset(-33)
            make.height.equalTo(200)
        }
        
        registrationView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(enterButton.snp.top)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(105)
            make.left.equalTo(view.snp.left).offset(21)
            make.right.equalTo(view.snp.right).offset(-21)
        }
        loginButton.snp.makeConstraints { make in
            make.leading.equalTo(stackView.snp.leading).offset(6)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.leading.equalTo(customDividerView.snp.trailing).offset(29)
        }
        
        customDividerView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(2)
            make.height.equalTo(24)
        }
        
        enterButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-50)
            make.leading.equalTo(view.snp.leading).offset(31)
            make.trailing.equalTo(view.snp.trailing).offset(-31)
            make.width.equalTo(348)
            make.height.equalTo(52)
        }
    }
}
