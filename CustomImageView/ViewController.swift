//
//  ViewController.swift
//  CustomImageView
//
//  Created by Prudhvi Gadiraju on 6/2/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: UI Elements
    
    let sv: UIScrollView = {
        let sv = UIScrollView()
        sv.minimumZoomScale = 1
        sv.maximumZoomScale = 3.0
        return sv
    }()
    
    let iv: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()

    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sv.delegate = self
        view.addSubview(sv)
        sv.fillSuperview()
        
        sv.addSubview(iv)
        iv.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        load(with: "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE4MDAzNDEwMzY0NDMzOTM0/jessica-alba-299896-1-402.jpg")
    }
    
    // MARK: Helpers
    
    private func load(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.iv.image = image
                    }
                }
            }
        }
    }
}

// MARK: Scroll View Delegate

extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return iv
    }
}
