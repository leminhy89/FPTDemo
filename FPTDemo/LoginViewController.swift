//
//  LoginViewController.swift
//  FPTDemo
//
//  Created by Minh Y Le on 8/26/16.
//  Copyright © 2016 Minh Y Le. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let fm = NSFileManager.defaultManager();
        let dd = fm.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fp = dd.URLByAppendingPathComponent("demo.db")
        let dbPath = fp.path!
        
        if !fm.fileExistsAtPath(dbPath as String) {
            let db = FMDatabase(path: dbPath as String)
            
            if db == nil {
                print("Error !!! \(db.lastErrorMessage())")
            }
            
            if db.open() {
                let sql = "CREATE TABLE USERS(ID INTEGER PRIMARY KEY AUTOINCREMENT,USERNAME TEXT NOT NULL,PASSWORD TEXT,EMAIL TEXT);"
                
                if !db.executeStatements(sql) {
                    print("Lỗi tạo bảng: \(db.lastErrorMessage())")
                }
                db.close()
            } else {
                print("Lỗi mở kết nối: \(db.lastErrorMessage())")
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginClicked(sender: AnyObject) {
        let fm = NSFileManager.defaultManager();
        let dd = fm.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fp = dd.URLByAppendingPathComponent("demo.db")
        let dbPath = fp.path!
        
        let db = FMDatabase(path: dbPath as String)
        db.open()
        
        let uName = txtUsername.text
        let pass = txtPassword.text
        
        let rs: FMResultSet! = db.executeQuery("SELECT * FROM USERS WHERE USERNAME=? AND PASSWORD= ?", withArgumentsInArray: [uName!, pass!])
        
        if rs != nil {
            
            if rs.next() {
                performSegueWithIdentifier("login", sender: nil)
            } else {
                let alert = UIAlertController(title: "Login Error !!!", message: "Please check again your Username, Password", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
    
        } else {
            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "login"
        {
            if let destinationVC = segue.destinationViewController as? ListUsersViewController {
                destinationVC.userName = txtUsername.text!
            }
        }
    }
    

}
