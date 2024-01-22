import UIKit
import Combine

class LoginView: UIView {
    
    private lazy var emailTextField = MyTextField(
        placeholder: "Enter Email",
        isSecure: false,
        keyboardType: .email,
        textContentType: .email)
    
    private lazy var passwordTextField = MyTextField(
        placeholder: "Пароль",
        isSecure: true,
        keyboardType: .password,
        textContentType: .password)
    
    private var loginViewModel: LoginViewModel!
    
    func configure(with viewModel: LoginViewModel) {
        self.loginViewModel = viewModel
    }
    
    private let emailSublabel = UILabel(placeholderString: "  Example@mail.ru  ")
    private let passwordSublabel = UILabel(placeholderString: "  Пароль  ")
    private let orLabel = UILabel.createOptionLabel(string: "или")
    private let userAgreemant = UILabel.createOptionLabel(string: "Нажимая кнопку “Создать аккаунт” вы\nсоглашаетесь с ")
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        let linkAttributed = [NSAttributedString.Key.link: NSUnderlineStyle.single.rawValue]
        let attributedString = NSAttributedString(string: "Забыли пароль?", attributes: linkAttributed)
        button.setAttributedTitle(attributedString, for: .normal)
        button.setTitleColor(UIColor(red: 0.325,
                                     green: 0.357,
                                     blue: 0.855,
                                     alpha: 1),
                             for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(forgotPasswordButtonDidTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var vkLogoButton = UIButton(with: UIImage.vkLogo!,
                                             target: self,
                                             action: #selector(vkLogoButtonDidTapped))

    private lazy var yandexLogoButton = UIButton(with: UIImage.yandexLogo!,
                                             target: self,
                                             action: #selector(yandexLogoButtonDidTapped))
    @objc private func forgotPasswordButtonDidTapped() {
        print("FORGOT PASSWORD")
    }
    
    @objc private func vkLogoButtonDidTapped() {
        print("VK TAPPED")
    }
    
    @objc private func yandexLogoButtonDidTapped() {
        print("YANDEX TAPPED")
    }
    private let emptyEmailFieldWarning = UILabel(warningString: "Поле обязательное для заполнения")
    private let emptyPasswordFieldWarning = UILabel(warningString: "Поле обязательное для заполнения")
    private let emailWarninigLabel = UILabel(warningString: "Проверьте почту")
    private let passwordWarningLabel = UILabel(warningString: "Неверный пароль, попробуйте еще раз")
    private var cancellables: Set<AnyCancellable> = []
    
// MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
        becomeFirstResponder()
    }
    
    @objc private func emailTextFieldDidChange(_ textField: UITextField) {
        becomeFirstResponder()
    }
    
    private func updateConstraintsForEmptyTextField(_ textField: UITextField, relativeTo previousTextField: UITextField?, isEmpty: Bool) {
        let previousTextField = previousTextField ?? UITextField()
        let offset = isEmpty ? 33 : 16
        if isEmpty {
            previousTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            previousTextField.layer.borderColor = UIColor.black.cgColor
        }
        textField.snp.remakeConstraints { make in
            make.top.equalTo(previousTextField.snp.bottom).offset(offset)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(previousTextField.snp.height)
            make.width.equalTo(previousTextField.snp.width)
            
        }
    }
        
    private func updateConstraintsForValidTextField(_ textField: UITextField, relativeTo previousTextField: UITextField?, isValid: Bool) {
        let previousTextField = previousTextField ?? UITextField()
        let offset = isValid ? 16 : 53
        
        if !isValid {
            previousTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            previousTextField.layer.borderColor = UIColor.black.cgColor
        }
        textField.snp.remakeConstraints { make in
            make.top.equalTo(previousTextField.snp.bottom).offset(offset)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(previousTextField.snp.height)
            make.width.equalTo(previousTextField.snp.width)
        }
    }
    
    private func updateConstraintsForLabel(_ view: UIView, relativeTo previousTextField: UITextField, isEmpty: Bool, offset: CGFloat) {
        if isEmpty {
            previousTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            previousTextField.layer.borderColor = UIColor.black.cgColor
        }
        view.snp.remakeConstraints { make in
            make.top.equalTo(previousTextField.snp.bottom).offset(offset)
            make.leading.equalTo(previousTextField.snp.leading)
        }
    }
    
    private func observeEmailField() {
        Publishers.CombineLatest3(loginViewModel.$email, loginViewModel.isEmailEmptyPublisher, loginViewModel.isEmailValidPublisher)
            .sink { [weak self] (_, isEmpty, isValid) in
                guard let self else { return }
                self.emptyEmailFieldWarning.isHidden = !isEmpty
                if isEmpty {
                    self.updateConstraintsForEmptyTextField(self.passwordTextField, relativeTo: self.emailTextField, isEmpty: isEmpty)
                    self.emailWarninigLabel.isHidden = isEmpty
                } else {
                    self.updateConstraintsForValidTextField(self.passwordTextField, relativeTo: self.emailTextField, isValid: isValid)
                    self.emailWarninigLabel.isHidden = isValid
                }
            }
            .store(in: &cancellables)
    }
    
    private func observePasswordField() {
        Publishers.CombineLatest3(loginViewModel.$password, loginViewModel.isPasswordEmptyPublisher, loginViewModel.isPasswordValidPublisher)
            .sink { [weak self] (_, isEmpty, isValid) in
                guard let self else { return }
                self.updateConstraintsForLabel(self.forgotPasswordButton, relativeTo: self.passwordTextField, isEmpty: isEmpty, offset: 33)
                self.emptyPasswordFieldWarning.isHidden = !isEmpty
                if isEmpty {
                    self.passwordWarningLabel.isHidden = isEmpty
                } else {
                    self.passwordWarningLabel.isHidden = isValid
                }
            }
            .store(in: &cancellables)
    }
}

extension LoginView {
    
    private func addTargets() {
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidEnd(_:)), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(textFieldDidEnd(_:)), for: .editingDidEnd)
        emailTextField.addTarget(self, action: #selector(textFIeldDidStart(_:)), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(textFIeldDidStart(_:)), for: .editingDidBegin)
    }
    
    private func addSubviews() {
        addSubview(passwordTextField)
        addSubview(emailTextField)
        addSubview(emailSublabel)
        addSubview(passwordSublabel)
        addSubview(emptyEmailFieldWarning)
        addSubview(emptyPasswordFieldWarning)
        addSubview(emailWarninigLabel)
        addSubview(forgotPasswordButton)
        addSubview(orLabel)
        addSubview(yandexLogoButton)
        addSubview(vkLogoButton)
        addSubview(passwordWarningLabel)
        setConstraints()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        addTargets()
    }
    
    private func didStartTyping(in textField: UITextField, with sublLabel: UILabel) {
        textField.placeholder = ""
        textField.layer.borderWidth = 2
        sublLabel.enterSublabelAnimation()
    }
    
    private func textFieldDidEnd(_ textField: UITextField, and sublabel: UILabel) {
            sublabel.isHidden = true
            textField.layer.borderWidth = 1
    }
    
    @objc private func textFIeldDidStart(_ textField: UITextField) {
        switch textField {
        case emailTextField: 
            didStartTyping(in: emailTextField, with: emailSublabel)
            observeEmailField()
        case passwordTextField: 
            didStartTyping(in: passwordTextField, with: passwordSublabel)
            observePasswordField()
        default: break
        }
    }
    
    @objc private func textFieldDidEnd(_ textField: UITextField) {
        switch textField {
        case emailTextField: loginViewModel.email = textField.text ?? ""
            textFieldDidEnd(emailTextField, and: emailSublabel)
        case passwordTextField: loginViewModel.password = textField.text ?? ""
            textFieldDidEnd(passwordTextField, and: passwordSublabel)
        default:
            break
        }
    }
    
    @objc private func passwordTextFieldDidEnd(_ textField: UITextField) {
            loginViewModel.password = textField.text ?? ""
            textFieldDidEnd(passwordTextField, and: passwordSublabel)
        }
    
    private func setConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(20)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(348)
            make.height.equalTo(52)
        }
        emailSublabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.top).offset(-8)
            make.leading.equalTo(emailTextField.snp.leading).offset(16)
        }
        
        emptyEmailFieldWarning.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.equalTo(emailTextField.snp.leading).offset(16)
            make.trailing.equalTo(emailTextField.snp.trailing)
        }
        
        emailWarninigLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.equalTo(emailTextField.snp.leading).offset(16)
            make.trailing.equalTo(emailTextField.snp.trailing)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(12)
            make.centerX.equalTo(emailTextField.snp.centerX)
            make.height.equalTo(emailTextField.snp.height)
            make.width.equalTo(emailTextField.snp.width)
        }
        passwordSublabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.top).offset(-8)
            make.leading.equalTo(passwordTextField.snp.leading).offset(16)
        }
        emptyPasswordFieldWarning.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.equalTo(passwordTextField.snp.leading).offset(16)
            make.trailing.equalTo(passwordTextField.snp.trailing)
        }

        passwordWarningLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.equalTo(emailWarninigLabel)
            make.trailing.equalTo(emailWarninigLabel)
        }
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.leading.equalTo(emailTextField.snp.leading)
        }
        orLabel.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.bottom.equalTo(yandexLogoButton.snp.top).offset(-12)
        }
        yandexLogoButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(97)
            make.leading.equalTo(snp.leading).offset(110)
        }
        vkLogoButton.snp.makeConstraints { make in
            make.top.equalTo(yandexLogoButton.snp.top)
            make.leading.equalTo(yandexLogoButton.snp.trailing).offset(16)
            
        }
        
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        becomeFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
