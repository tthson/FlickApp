//
//  DetailViewController.swift
//  FlickApp
//
//  Created by Son, Tran Thai on 7/11/16.
//  Copyright © 2016 Son, Tran Thai. All rights reserved.
//

import UIKit
import AFNetworking

class DetailViewController: UIViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var overview: UILabel!
    var posterImageUrl: String = ""
    var overviewText: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        posterImage.setImageWithURL(NSURL(string: posterImageUrl)!)
        overview.text =  overviewText

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
