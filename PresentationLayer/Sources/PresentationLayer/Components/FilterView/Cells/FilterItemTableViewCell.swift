//
//  FilterItemTableViewCell.swift
//  
//
//  Created by Jobson Mateus on 09/10/24.
//

import UIKit

class FilterItemTableViewCell: UITableViewCell {
    lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.primaryColor
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func bind(item: String) {
        itemLabel.text = item
    }
}

extension FilterItemTableViewCell {
    func setupLayout() {
        addSubview(itemLabel)
        
        setupItemLabel()
    }
    
    func setupItemLabel() {
        NSLayoutConstraint.activate([
            itemLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            itemLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            itemLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            itemLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
}
