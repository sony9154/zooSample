//
//  ZooTableViewCell.swift
//  zooSample
//
//  Created by Hsu Hua on 2023/7/21.
//

import UIKit
import Stevia

class ZooTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let detailLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        subviews(titleLabel, detailLabel)
        layout(
            10,
            titleLabel,
            5,
            detailLabel,
            10
        )
    }

    func configure(with exhibit: Exhibit) {
        titleLabel.text = exhibit.eName
        detailLabel.text = exhibit.eInfo
    }
}
