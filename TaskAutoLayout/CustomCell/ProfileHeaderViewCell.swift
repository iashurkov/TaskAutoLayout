//
//  ProfileHeaderViewCell.swift
//  TaskAutoLayout
//
//  Created by Igor Ashurkov on 28.03.2022.
//

import UIKit

protocol ProfileHeaderViewCellDelegate: AnyObject {
    func didTapEditButton()
}

final class ProfileHeaderViewCell: UITableViewCell {
    
    // MARK: - Public structures
    
    enum Constants {
        static let profileImageViewInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0)
        static let profileImageViewSize = CGSize(width: 88, height: 88)
        static let profileImageViewCornerRadius = profileImageViewSize.height / 2
        
        static let heightElementProfileInfoStack: CGFloat = 40
        
        static let profileInfoStackInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: -16)
        
        static let editProfileButtonInset = UIEdgeInsets(top: 8, left: 16, bottom: -8, right: -16)
        static let editProfileButtonHeight: CGFloat = 40
        static let editProfileButtonCornerRadius: CGFloat = 8
    }
    
    // MARK: - Private Properties
    
    weak var delegate: ProfileHeaderViewCellDelegate?
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = Constants.profileImageViewCornerRadius
        
        imageView.backgroundColor = .red
        
        return imageView
    }()
    
    private lazy var profileInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "NickName"
        label.backgroundColor = .green
        
        return label
    }()
    
    private lazy var dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "23.09.2020"
        label.backgroundColor = .blue
        
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isHidden = true
        
        textField.backgroundColor = .yellow
        
        return textField
    }()
    
    private var topConstraintEditProfileButton = NSLayoutConstraint()
    private lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = Constants.editProfileButtonCornerRadius
        button.setTitle("Edit", for: .normal)
        button.addTarget(self, action: #selector(self.didTapToEditProfile), for: .touchUpInside)
        
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: nil)
        self.drawSelf()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.drawSelf()
    }
    
    // MARK: - Drawing
    
    private func drawSelf() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .white
        
        self.addSubview(self.profileImageView)
        
        self.profileInfoStackView.addArrangedSubview(self.nickNameLabel)
        self.profileInfoStackView.addArrangedSubview(self.dateOfBirthLabel)
        self.profileInfoStackView.addArrangedSubview(self.textField)
        self.addSubview(self.profileInfoStackView)
        
        self.addSubview(self.editProfileButton)
        
        let constraintsForProfileImageView = self.constraintsForProfileImageView()
        let constraintsForProfileInfoStackView = self.constraintsForProfileInfoStackView()
        let constraintsForEditProfileButton = self.constraintsForEditProfileButton()
        
        let constraintsForNickNameLabel = self.constraintsForNickNameLabel()
        let constraintsForDateOfBirthLabel = self.constraintsForDateOfBirthLabel()
        let constraintsForTextField = self.constraintsForTextField()
        
        NSLayoutConstraint.activate(
            constraintsForProfileImageView +
            constraintsForProfileInfoStackView +
            constraintsForEditProfileButton +
            
            constraintsForNickNameLabel +
            constraintsForDateOfBirthLabel +
            constraintsForTextField
        )
    }
    
    
    private func constraintsForProfileImageView() -> [NSLayoutConstraint] {
        let topAnchor = self.profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.profileImageViewInset.top)
        let leadingAnchor = self.profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.profileImageViewInset.left)
        let height = self.profileImageView.heightAnchor.constraint(equalToConstant: Constants.profileImageViewSize.height)
        let width = self.profileImageView.widthAnchor.constraint(equalToConstant: Constants.profileImageViewSize.width)
        
        return [
            topAnchor,
            leadingAnchor,
            height,
            width
        ]
    }
    
    private func constraintsForProfileInfoStackView() -> [NSLayoutConstraint] {
        let topAnchor = self.profileInfoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.profileInfoStackInset.top)
        let trailingAnchor = self.profileInfoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.profileInfoStackInset.right)
        let leadingAnchor = self.profileInfoStackView.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: Constants.profileInfoStackInset.left)
        
        return [
            topAnchor,
            trailingAnchor,
            leadingAnchor
        ]
    }
    
    private func constraintsForNickNameLabel() -> [NSLayoutConstraint] {
        let heightAnchor = self.nickNameLabel.heightAnchor.constraint(equalToConstant: Constants.heightElementProfileInfoStack)
        
        return [
            heightAnchor
        ]
    }
    
    private func constraintsForDateOfBirthLabel() -> [NSLayoutConstraint] {
        let heightAnchor = self.dateOfBirthLabel.heightAnchor.constraint(equalToConstant: Constants.heightElementProfileInfoStack)
        
        return [
            heightAnchor
        ]
    }
    
    private func constraintsForTextField() -> [NSLayoutConstraint] {
        let heightAnchor = self.textField.heightAnchor.constraint(equalToConstant: Constants.heightElementProfileInfoStack)
        
        return [
            heightAnchor
        ]
    }
    
    private func constraintsForEditProfileButton() -> [NSLayoutConstraint] {
        let topAnchor = self.editProfileButton.topAnchor.constraint(equalTo: self.profileInfoStackView.bottomAnchor, constant: Constants.editProfileButtonInset.top)
        let trailingAnchor = self.editProfileButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.editProfileButtonInset.right)
        let leadingAnchor = self.editProfileButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.editProfileButtonInset.left)
        let bottomAnchor = self.editProfileButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.editProfileButtonInset.bottom)
        bottomAnchor.priority = .defaultLow
        let heightAnchor = self.editProfileButton.heightAnchor.constraint(equalToConstant: Constants.editProfileButtonHeight)
        
        return [
            topAnchor,
            trailingAnchor,
            leadingAnchor,
            bottomAnchor,
            heightAnchor
        ]
    }
    
    @objc private func didTapToEditProfile() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.textField.isHidden.toggle()
        })
        
        self.layoutIfNeeded()
        
        self.delegate?.didTapEditButton()
    }
}
