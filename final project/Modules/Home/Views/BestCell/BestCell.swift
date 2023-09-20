//
//  BestCell.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 30/09/22.
//

import UIKit

class BestCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var containerInfo: UIView!
    @IBOutlet weak var containerBlur: UIView!
    @IBOutlet weak var tittle: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    let blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(
            effect: UIBlurEffect(style: .systemUltraThinMaterial)
        )
        blurView.backgroundColor = .systemBackground.withAlphaComponent(0.005)
        return blurView
    }()
    
    static let cellIdentifier = "BestCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        
        containerBlur.addSubview(blurView)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: containerInfo.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: containerInfo.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: containerInfo.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: containerInfo.bottomAnchor)
        ])
    }

    func update(data: Game) {
        if let url = URL(string: data.background_image!) {
            backgroundImage.kf.setImage(with: url)
        }

        tittle.text = data.name
        rating.text = "\(data.rating ?? 0)"
    }
}
