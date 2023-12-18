import UIKit
import SnapKit

final class RegistrationViewController: UIViewController {
    
    var viewModel: RegistrationViewModel
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameValidType: String.ValidTypes = .name
    let emailValueType: String.ValidTypes = .email
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        var paragraphtyle = NSMutableParagraphStyle()
        paragraphtyle.lineHeightMultiple = 1.15
        label.attributedText = NSMutableAttributedString(
            string: "Имя",
            attributes: [NSAttributedString.Key.kern: -0.41,
                         NSAttributedString.Key.paragraphStyle: paragraphtyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        // textField.placeholder = "Введите Имя"
        textField.textColor = .black
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: 20,
                                               height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 16
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.addTarget(self, action: #selector(nameTextFieldDidChanged(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    @objc private func nameTextFieldDidChanged(_ textField: UITextField) {
        // TODO: make logic in viemodel?
    }
    
    private let surnameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        var paragraphtyle = NSMutableParagraphStyle()
        paragraphtyle.lineHeightMultiple = 1.15
        label.attributedText = NSMutableAttributedString(
            string: "Фамилия",
            attributes: [NSAttributedString.Key.kern: -0.41,
            NSAttributedString.Key.paragraphStyle: paragraphtyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var surnameTextField: UITextField = {
        let textField = UITextField()
        // textField.placeholder = "Введите Фамилию"
        textField.textColor = .black
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: 20,
                                               height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 16
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.addTarget(self, action: #selector(surnameTextFieldDidChanged(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    @objc private func surnameTextFieldDidChanged(_ textField: UITextField) {
        // TODO: make logic in viemodel?
    }
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        var paragraphtyle = NSMutableParagraphStyle()
        paragraphtyle.lineHeightMultiple = 1.15
        label.attributedText = NSMutableAttributedString(
            string: "E-mail",
            attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphtyle]
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        // textField.placeholder = "Введите E-mail"
        textField.textColor = .black
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: 20,
                                               height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 16
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.addTarget(self, action: #selector(emailTextFieldDidChanged(_:)), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    @objc private func emailTextFieldDidChanged(_ textField: UITextField) {
        // TODO: todo make logic in viemodel?
    }
    
    private lazy var buttonTermsOfBooking: UIButton = {
        let button = UIButton()
        let underlineAttributed = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributedString = NSAttributedString(string: "Ознакомиться с правилами бронирования", attributes: underlineAttributed)
        button.setAttributedTitle(attributedString, for: .normal)
        button.setTitleColor(UIColor(red: 0.463,
                                     green: 0.463,
                                     blue: 0.463,
                                     alpha: 1), for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.addTarget(self, action: #selector(didTappedTermsOfBooking), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func didTappedTermsOfBooking() { print("DID TAPPED") }
    
    private lazy var switcher: UISwitch = {
       let switcher = UISwitch()
        switcher.onTintColor = .black
        switcher.addTarget(self, action: #selector(switcherValueDidChanged(_:)), for: .valueChanged)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()
    
    @objc private func switcherValueDidChanged(_ switcher: UISwitch) {
        if switcher.isOn {
            print("ON")
        } else {
            print("OFF")
        }
    }
    
    private lazy var buttonContinue: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.backgroundColor = UIColor.black.cgColor
        button.layer.cornerRadius = 16
        button.addTarget(self,
                         action: #selector(didTappedContinueButton),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        // button.isHidden = true
        return button
    }()
    
    @objc private func didTappedContinueButton() {
        viewModel.openDocumentsCoordinator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension RegistrationViewController {
    
    func addSubviews() {
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(surnameLabel)
        view.addSubview(surnameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(buttonTermsOfBooking)
        view.addSubview(switcher)
        view.addSubview(buttonContinue)
    }
    
    func setupView() {
        view.backgroundColor = .white
        addSubviews()
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(111)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-340)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-17)
            make.height.equalTo(52)
        }
        
        surnameLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.trailing.equalTo(view.snp.trailing).offset(-300)
        }
        
        surnameTextField.snp.makeConstraints { make in
            make.top.equalTo(surnameLabel.snp.bottom).offset(10)
            make.leading.equalTo(nameTextField.snp.leading)
            make.trailing.equalTo(nameTextField.snp.trailing)
            make.height.equalTo(nameTextField.snp.height)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(surnameTextField.snp.bottom).offset(10)
            make.leading.equalTo(surnameLabel.snp.leading)
            make.trailing.equalTo(surnameLabel.snp.trailing)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.leading.equalTo(surnameTextField.snp.leading)
            make.trailing.equalTo(surnameTextField.snp.trailing)
            make.height.equalTo(surnameTextField.snp.height)
        }
        
        buttonTermsOfBooking.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(46)
            make.centerY.equalTo(switcher.snp.centerY)
            make.leading.equalTo(emailTextField.snp.leading)
        }
        
        switcher.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(40)
            make.trailing.equalTo(view.snp.trailing).offset(-12)
            make.height.equalTo(31)
            make.width.equalTo(51)
        }
        
        buttonContinue.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-55)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(324)
            make.height.equalTo(52)
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        switch textField {
        case nameTextField: textField.setTextField(textField: nameTextField,
                                                   validType: nameValidType,
                                                   string: string,
                                                   range: range)
        case surnameTextField: textField.setTextField(textField: surnameTextField,
                                                      validType: nameValidType,
                                                      string: string,
                                                      range: range)
        case emailTextField: textField.setTextField(textField: emailTextField,
                                                    validType: emailValueType,
                                                    string: string,
                                                    range: range)
        default:
            break
        }
        
        return false
    }
}
