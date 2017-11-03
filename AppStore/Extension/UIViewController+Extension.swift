//
//  UIViewController+Extension.swift
//  RentPhone
//
//  Created by 泽i on 2017/10/23.
//  Copyright © 2017年 泽i. All rights reserved.
//

extension UIViewController {
    func push(_ vc: UIViewController, animated: Bool = true) {
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: animated)
    }
    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
}
