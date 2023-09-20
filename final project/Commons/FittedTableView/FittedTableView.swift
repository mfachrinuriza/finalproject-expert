//
//  FittedTableView.swift
//  final project
//
//  Created by Muhammad Fachri Nuriza on 03/08/23.
//

import UIKit

class FittedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
