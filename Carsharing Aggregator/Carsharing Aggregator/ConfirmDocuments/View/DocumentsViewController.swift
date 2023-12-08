import UIKit

final class DocumentsViewController: UIViewController {
    var viewModel: DocumentsViewModel
    
    init(viewModel: DocumentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let passportLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.46, green: 0.444, blue: 0.444, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        var paragraphtyle = NSMutableParagraphStyle()
        paragraphtyle.lineHeightMultiple = 1.15
        label.attributedText = NSMutableAttributedString(string: "Паспорт", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphtyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let licenseLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.46, green: 0.444, blue: 0.444, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        var paragraphtyle = NSMutableParagraphStyle()
        paragraphtyle.lineHeightMultiple = 1.15
        label.attributedText = NSMutableAttributedString(string: "Водительское удоствериние", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphtyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let photoWithDocumentsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.46, green: 0.444, blue: 0.444, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        var paragraphtyle = NSMutableParagraphStyle()
        paragraphtyle.lineHeightMultiple = 1.15
        label.numberOfLines = 0
        
        label.attributedText = NSMutableAttributedString(
            string: "Фото с любым загруженным \n документом",
            attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphtyle])
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var passportButtonArrow: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.circleArrows, for: .normal)
        button.backgroundColor = UIColor.white
        button.tintColor = .black
        button.layer.masksToBounds = true
        button.addTarget(self,
                         action: #selector(passportButtonTapped),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let disclaimerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.46, green: 0.444, blue: 0.444, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.15
        
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSMutableAttributedString(
            string: "Должны быть четко видны номера\nдокументов, фото и персональные данные",
            attributes: [
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.kern: -0.41,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
        )
        
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    private lazy var licenseButtonArrow: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.circleArrows, for: .normal)
        button.backgroundColor = UIColor.white
        button.tintColor = .black
        button.layer.masksToBounds = true
        button.addTarget(self,
                         action: #selector(licenseButtonTapped),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var photoWithDocumentsButtonArrow: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage.circleArrows, for: .normal)
        button.backgroundColor = UIColor.white
        button.tintColor = .black
        button.layer.masksToBounds = true
        button.addTarget(self,
                         action: #selector(photoWithDocumentsButtonTapped),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var sendDocumentsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Проверить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.backgroundColor = UIColor.black.cgColor
        button.layer.cornerRadius = 16
        button.addTarget(self,
                         action: #selector(didTappedSendDocumentsButton),
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
    @objc private func didTappedSendDocumentsButton() {
            print("Button tapped")
        }
    
    @objc private func passportButtonTapped() {
            print("Button tapped")
        }
    
    @objc private func licenseButtonTapped() {
            print("Button tapped")
        }
    @objc private func photoWithDocumentsButtonTapped() {
            print("Button tapped")
        }
}

extension DocumentsViewController {
    
    private func addSubviews() {
        view.addSubview(passportLabel)
        view.addSubview(licenseLabel)
        view.addSubview(photoWithDocumentsLabel)
        view.addSubview(passportButtonArrow)
        view.addSubview(licenseButtonArrow)
        view.addSubview(photoWithDocumentsButtonArrow)
        view.addSubview(disclaimerLabel)
        view.addSubview(sendDocumentsButton)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        addSubviews()
        passportLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(162)
            make.leading.equalTo(view.snp.leading).offset(33)
            make.trailing.equalTo(view.snp.trailing).offset(-288)
        }
        
        licenseLabel.snp.makeConstraints { make in
            make.top.equalTo(passportLabel.snp.bottom).offset(34)
            make.leading.equalTo(passportLabel.snp.leading)
            make.trailing.equalTo(view.snp.trailing).offset(-115)
        }
        
        photoWithDocumentsLabel.snp.makeConstraints { make in
            make.top.equalTo(licenseLabel.snp.bottom).offset(39)
            make.leading.equalTo(licenseLabel.snp.leading)
            make.trailing.equalTo(view.snp.trailing).offset(-113)
            make.height.equalTo(44)
        }
        
        passportButtonArrow.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(157)
            make.trailing.equalTo(view.snp.trailing).offset(-26)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        
        disclaimerLabel.snp.makeConstraints { make in
            make.top.equalTo(photoWithDocumentsLabel).offset(54)
            make.leading.equalTo(view.snp.leading).offset(33)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
        }
        
        licenseButtonArrow.snp.makeConstraints { make in
            make.top.equalTo(licenseLabel.snp.top)
            make.trailing.equalTo(passportButtonArrow.snp.trailing)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        
        photoWithDocumentsButtonArrow.snp.makeConstraints { make in
            make.top.equalTo(photoWithDocumentsLabel.snp.top)
            make.trailing.equalTo(licenseButtonArrow.snp.trailing)
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        
        sendDocumentsButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-88)
            make.leading.equalTo(view.snp.leading).offset(28)
            make.trailing.equalTo(view.snp.trailing).offset(-38)
            make.height.equalTo(52)
        }
    }
}
