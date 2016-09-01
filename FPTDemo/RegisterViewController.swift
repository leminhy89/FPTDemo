//
//  RegisterViewController.swift
//  FPTDemo
//
//  Created by Minh Y Le on 8/26/16.
//  Copyright © 2016 Minh Y Le. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblRegistration: UILabel!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var txtMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtMessage.hidden = true
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

    @IBAction func onRegisterClicked(sender: AnyObject) {
        let fm = NSFileManager.defaultManager();
        let dd = fm.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fp = dd.URLByAppendingPathComponent("demo.db")
        let dbPath = fp.path!
        
        let db = FMDatabase(path: dbPath as String)
        
        if db.open() {
            let userName = txtUsername.text
            let password = txtPassword.text
            let email = txtEmail.text
            
            let sql = "INSERT INTO USERS (USERNAME,PASSWORD,EMAIL) VALUES (?,?,?);"
            
            let ret = db.executeUpdate(sql, withArgumentsInArray: [userName!, password!, email!])
            
            if !ret {
                print("Lỗi thêm dữ liệu: \(db.lastErrorMessage())")
            } else {
                txtUsername.text = ""
                txtPassword.text = ""
                txtEmail.text = ""
                txtMessage.hidden = false
                print("Thêm dữ liệu thành công")
            }
            // Đóng cơ sở dữ liệu
            db.close()
        } else {
            print("Lỗi mở cơ sở dữ liệu: \(db.lastErrorMessage())")
        }
        
        
    }
}
