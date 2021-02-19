//
//  CustomPickerView.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import UIKit

protocol CustomCollectionViewDelegate: AnyObject {
    func didTapped(_ picker: CustomCollectionView)
}

final class CustomCollectionView: UICollectionView {

    weak var myDelegate: CustomCollectionViewDelegate?

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        if !self.point(inside: point, with: event) {
            return nil
        }

        myDelegate?.didTapped(self)

        return super.hitTest(point, with: event)
    }
}
