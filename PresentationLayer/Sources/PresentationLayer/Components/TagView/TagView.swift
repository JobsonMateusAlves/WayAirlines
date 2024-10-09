//
//  TagView.swift
//  
//
//  Created by Jobson Mateus on 07/10/24.
//

import UIKit

class TagView: UIView {
    lazy var tagLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(tag: String, color: UIColor) {
        self.tagLabel.text = tag
        self.tagLabel.textColor = color
        self.layer.borderColor = color.cgColor
        
        self.setupLayout()
    }
}

extension TagView {
    func setupLayout() {
        self.addSubview(self.tagLabel)
        
        self.setupTagLabel()
    }
    
    func setupTagLabel() {
        NSLayoutConstraint.activate([
            self.tagLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.tagLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            self.tagLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.tagLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        
        self.layoutIfNeeded()
        
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = 1
    }
}
