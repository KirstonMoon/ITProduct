//
//  CustomPickerView.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import UIKit

protocol CustomPickerViewDelegate: AnyObject {
    func didTapped(_ picker: CustomPickerView)
}

class CustomPickerView: UIPickerView {

    weak var myDelegate: CustomPickerViewDelegate?

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        if !self.point(inside: point, with: event) {
            return nil
        }

        myDelegate?.didTapped(self)

        return super.hitTest(point, with: event)
    }
}
