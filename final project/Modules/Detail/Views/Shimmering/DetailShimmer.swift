//
//  DetailShimmer.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 19/09/23.
//

import UIKit

class DetailShimmer: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        let contentView = Bundle.main.loadNibNamed("DetailShimmer", owner: self, options: nil)![0] as! UIView
        contentView.frame = self.frame
        self.addSubview(contentView)
    }
}
