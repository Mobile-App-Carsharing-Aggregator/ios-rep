import UIKit
enum TextContentType {
    case password
    case email
    case other
    
    var textContentType: UITextContentType {
        switch self {
        case .password:
            return .password
        case .email:
            return .emailAddress
        case .other:
            return .name
        }
    }
}

enum KeyboardType {
    case password
    case email
    case other
    
    var uiKeyboardType: UIKeyboardType {
        switch self {
        case .password:
            return .default
        case .email:
            return .emailAddress
        case .other:
            return .default
        }
    }
}

class MyTextField: UITextField {
    var eyeButton: UIButton?
    var deleteButton: UIButton?
    
    func setTextField(textField: UITextField,
                      validType: String.ValidTypes,
                      wrongMessage: String,
                      string: String,
                      range: NSRange) {
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        if !result.isValid(validType: validType) {
            
        }
    }
        
    convenience init(placeholder: String,
                     isSecure: Bool,
                     keyboardType: KeyboardType,
                     textContentType: TextContentType) {
        self.init()
        let leftPaddingView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 16,
            height: frame.height))
        let rightPaddingView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 16,
            height: frame.height))
        
        leftView = leftPaddingView
        leftViewMode = .always
        
        rightView = rightPaddingView
        rightViewMode = .always
        self.placeholder = placeholder
        self.keyboardType = keyboardType.uiKeyboardType
        self.textContentType = textContentType.textContentType
        let placeholderColor = UIColor(red: 0.404,
                                       green: 0.404,
                                       blue: 0.404,
                                       alpha: 1)
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: placeholderColor,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ]
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        
        font = UIFont.systemFont(ofSize: 16, weight: .regular)
        layer.masksToBounds = true
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.carsharing.black.cgColor
        clearButtonMode = .whileEditing
        translatesAutoresizingMaskIntoConstraints = false
       
        let rightViewContainer = UIView(frame: isSecure ? CGRect(x: 0, y: 0, width: 62, height: 20) : CGRect(x: 0, y: 0, width: 38, height: 20))
            
            let clearButton = UIButton(type: .custom)
            clearButton.setImage(UIImage(named: "close_small"), for: .normal)
            clearButton.addTarget(self, action: #selector(deleteText), for: .touchUpInside)
            clearButton.tintColor = .black
            clearButton.frame = isSecure ? CGRect(x: 0, y: 0, width: 24, height: 24) : CGRect(x: 0, y: 0, width: 24, height: 24)
            self.deleteButton = clearButton
            rightViewContainer.addSubview(clearButton)
        if isSecure {
            isSecureTextEntry = true
            self.textContentType = .oneTimeCode
            let eyeButton = UIButton(type: .custom)
            eyeButton.setImage(isSecureTextEntry ? UIImage(named: "eyesClosed") : UIImage(named: "eyesOpen"), for: .normal)
            eyeButton.tintColor = .carsharing.grey
            eyeButton.addTarget(self, action: #selector(toogleEyeButton), for: .touchUpInside)
            self.eyeButton = eyeButton
            eyeButton.frame = CGRect(x: 24, y: 0, width: 24, height: 24)
            rightViewContainer.addSubview(eyeButton)
        }
        rightView = rightViewContainer
        rightViewMode = .whileEditing
    }
   
    @objc func deleteText() {
        self.text = ""
    }
    
    @objc func toogleEyeButton() {
        isSecureTextEntry = !isSecureTextEntry
        eyeButton?.setImage(isSecureTextEntry ? UIImage(named: "eyesClosed") : UIImage(named: "eyesOpen"), for: .normal)
    }
    
    func setPhoneNumberMask(textField: UITextField, mask: String, string: String, range: NSRange) -> String {
        let text = textField.text ?? ""
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        return result
    }
}
