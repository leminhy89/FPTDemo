//
//  ListUsersViewController.swift
//  FPTDemo
//
//  Created by Minh Y Le on 8/26/16.
//  Copyright © 2016 Minh Y Le. All rights reserved.
//

import UIKit

class ListUsersViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblExample: UILabel!
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    
    var userName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblUserName.text = userName
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
    @IBAction func onBackClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }

}
