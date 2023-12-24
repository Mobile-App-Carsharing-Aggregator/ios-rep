import UIKit
import Combine

class LoginView: UIView {
    
    private lazy var emailTextField = UITextField(
        placeholder: "Enter Email",
        isSecure: false,
        keyboardType: .email,
        textContentType: .email)
    
    private lazy var passwordTextField = UITextField(
        placeholder: "Пароль",
        isSecure: true,
        keyboardType: .password,
        textContentType: .password)
    
    private let viewModel = LoginViewModel()
    
    private let orLabel = UILabel().createOrLabel(string: "или")
    private let userAgreemant = UILabel().createOrLabel(string: "Нажимая кнопку “Создать аккаунт” вы\nсоглашаетесь с ")
    
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
    private let emptyEmailFieldWarning = UILabel(string: "Поле обязательное для заполнения")
    private let emptyPasswordFieldWarning = UILabel(string: "Поле обязательное для заполнения")
    private let emailWarninigLabel = UILabel(string: "Проверьте почту")
    private let passwordWarningLabel = UILabel(string: "Неверный пароль, попробуйте еще раз")
    private var cancellables: Set<AnyCancellable> = []
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
    
    private func observeEmailField() {
        Publishers.CombineLatest3(viewModel.$email, viewModel.isEmailEmptyPublisher, viewModel.isEmailValidPublisher)
            .sink { [weak self] (_, isEmpty, isValid) in
                guard let self = self else { return }
                if isEmpty {
                    self.updateConstraintsForEmptyTextField(self.passwordTextField, relativeTo: self.emailTextField, isEmpty: isEmpty)
                    self.emptyEmailFieldWarning.isHidden = !isEmpty
                    self.emailWarninigLabel.isHidden = isEmpty
                } else {
                    self.updateConstraintsForValidTextField(self.passwordTextField, relativeTo: self.emailTextField, isValid: isValid)
                    self.emptyEmailFieldWarning.isHidden = !isEmpty
                    self.emailWarninigLabel.isHidden = isValid
                }
            }
            .store(in: &cancellables)
    }
}

extension LoginView {
    
    private func addSubviews() {
        addSubview(passwordTextField)
        addSubview(emailTextField)
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
        emailTextField.addTarget(self, action: #selector(didEmailValid), for: .editingDidEnd)
    }
    
    @objc private func didEmailValid(_ textField: UITextField) {
        viewModel.email = textField.text ?? ""
        observeEmailField()
    }
    
    private func setConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(348)
            make.height.equalTo(52)
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
