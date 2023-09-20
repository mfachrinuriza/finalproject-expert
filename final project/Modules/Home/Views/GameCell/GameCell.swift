//
//  GameCell.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 09/10/22.
//

import UIKit
import RxCocoa
import RxSwift

class GameCell: UITableViewCell {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    static let cellIdentifier = "GameCell"
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    func update(data: Game) {
        if let url = URL(string: data.background_image!) {
            backgroundImage.kf.setImage(with: url)
        }

        title.text = data.name
        rating.text = "\(data.rating ?? 0)"
    }
}
