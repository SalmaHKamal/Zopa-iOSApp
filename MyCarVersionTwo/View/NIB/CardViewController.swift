//
//  CardViewController.swift
//  MyCarVersionTwo
//
//  Created by Sayed Abdo on 5/22/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit


class CardViewController: UIView {
    
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    
    //var
    var cornerRaduis : CGFloat = 0
    var shadowColor : UIColor? = UIColor.black
    
    let shadowOffsetSetWidth : Int = 0
    let shadowOffsetSetHeight : Int = 1
    
    var shadowOpacity : Float = 0.2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("CardViewController", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight , .flexibleWidth]
        
    }
    
    override func layoutSubviews() {
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width : shadowOffsetSetWidth , height: shadowOffsetSetHeight)
        let shadowPath = UIBezierPath(roundedRect : bounds , cornerRadius : cornerRaduis)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacity
    }

}


