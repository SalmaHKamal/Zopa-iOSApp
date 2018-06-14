//
//  WebViewController.swift
//  MyCarVersionTwo
//
//  Created by mac on 5/30/18.
//  Copyright © 2018 Sayed Abdo. All rights reserved.
//

import UIKit
import WebKit
import Reachability
class WebViewController: UIViewController {

    @IBOutlet weak var webview: WKWebView!
   
    var siteID:Int = 0
    var urld:URL?
    var reachability : Reachability?
    override func viewDidLoad() {
    super.viewDidLoad()
    self.reachability=Reachability.init()
        if self.reachability!.connection != .none {
            
            switch siteID{
            case 0:
                urld = URL(string:"http://www.asfaalt.com")
            case 1:
                urld = URL(string:"https://www.CarParts.com")
            case 2:
                urld = URL(string:"https://www.jumia.com")
            default:
                urld = URL(string:"https://www.google.com")
            }
            
            let request=URLRequest(url:urld!)
            webview.load(request)
        
        }
        else{
            let Alert = UIAlertController(title: "No Connection", message:"Check internet connection" , preferredStyle: .actionSheet)
            let cancle = UIAlertAction(title: "got it", style: .default, handler: nil)
            Alert.addAction(cancle)
            
            present(Alert, animated: true, completion: nil)
        }
        
    
    
       
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
}

