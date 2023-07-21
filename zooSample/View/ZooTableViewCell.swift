//
//  ZooTableViewCell.swift
//  zooSample
//
//  Created by Hsu Hua on 2023/7/21.
//

import UIKit
import Stevia
import Kingfisher



class ZooTableViewCell: UITableViewCell {
    let nameLabel = UILabel()
    let infoLabel = UILabel()
    let memoLable = UILabel()
    let houseImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        sv(houseImageView, nameLabel, infoLabel)

        houseImageView.contentMode = .scaleAspectFit
        houseImageView.clipsToBounds = true

        layout(
            10,
            |-10-houseImageView.width(80).height(80)-10-nameLabel-10-|,
            5,
            |-10-houseImageView.width(80).height(80)-100-infoLabel-10-|,
            20
        )
    }



    func configure(with exhibit: Exhibit) {
        let url = URL(string: exhibit.ePicURL ?? "")
        DispatchQueue.main.async {
            self.houseImageView.kf.setImage(with: url)
        }
        nameLabel.text = exhibit.eName
        infoLabel.text = exhibit.eInfo
        memoLable.text = exhibit.eMemo
    }
}
