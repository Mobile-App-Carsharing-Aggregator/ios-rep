import Foundation

extension String {
    enum ValidTypes {
        case name
        case surname
        case phoneNumber
        case email
    }
    
    enum Regex: String {
        case name = "[а-яА-Яa-zA-Z]{1,}"
        case phoneNumber = "[+0-9]{1,10}"
        case email = "[a-zA-Z0-9._]+@[a-zA-Z0-9]+\\.[a-zA-Z]{2,}"
    }
    
    func isValid(validType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
        case .name: regex = Regex.name.rawValue
        case .phoneNumber: regex = Regex.phoneNumber.rawValue
        case .surname: regex = Regex.name.rawValue
        case .email: regex = Regex.email.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
