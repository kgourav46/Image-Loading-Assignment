//
//  BaseViewController.swift
//  Assignment
//
//  Created by Gourav Kumar on 16/04/24.
//

import UIKit

protocol InstantiableFromStoryboard {
    static var storyBoardId: String { get }
    static var storyBoardName: String { get }
    static func instantiateFromStoryBoard() -> Self
}

extension InstantiableFromStoryboard {
    static func instantiateFromStoryBoard() -> Self {
        let storyBoard = UIStoryboard.init(name: storyBoardName, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: storyBoardId)
        return vc as! Self
    }
}

typealias BaseViewController = BaseViewControllerClass & InstantiableFromStoryboard

class BaseViewControllerClass: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
