//
//  AutoShimmerView.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 19/09/23.
//

import ShimmerSwift

class AutoShimmerView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI() {
        self.clipsToBounds = true

        let shimmer = ShimmeringView(frame: self.frame)
        
        let content = UIView(frame: self.frame)
        content.backgroundColor = self.backgroundColor
        shimmer.contentView = content

        shimmer.isShimmering = true
        self.backgroundColor = .clear
        self.addSubview(content)
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}

// MARK: - Static Methods
extension AutoShimmerView {
    static func showShimmer(_ shimmerView: UIView, in vc: UIViewController) {
        AutoShimmerView.showShimmer(shimmerView, in: vc.view)
    }
    
    static func showShimmer(_ shimmerView: UIView, in view: UIView) {
        view.addSubview(shimmerView)
        
        shimmerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shimmerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shimmerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shimmerView.topAnchor.constraint(equalTo: view.topAnchor),
            shimmerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    static func hideShimmer(_ shimmerView: UIView?) {
        shimmerView?.removeFromSuperview()
    }
}
