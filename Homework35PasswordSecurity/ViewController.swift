//
//  ViewController.swift
//  Homework35PasswordSecurity
//
//  Created by 黃柏嘉 on 2021/12/8.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var securityLevelProgressView: UIProgressView!

    var securityLevel = 7
    var problem = ""
    let commonPassword = ["123456","password","12345678","qwerty","12345","123456789","letmein", "1234567","football","iloveyou"]
    let punctuation = "!@#$%^&*(),.<>;'`~[]{}\\|/?_-+="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func checkPasswordSecurity(_ sender: UIButton) {
        view.endEditing(true)
        if passwordTextField.text != "" && usernameTextField.text != ""{
            checkPassword()
            switch securityLevel{
            case 0...1:
                securityLevelProgressView.progress = 0.2
                securityLevelProgressView.progressTintColor = .systemRed
                alert(message: "密碼安全度過低,等級\(securityLevel)")
            case 2...3:
                securityLevelProgressView.progress = 0.4
                securityLevelProgressView.progressTintColor = .systemRed
                alert(message: "密碼安全度偏低,等級\(securityLevel)")
            case 4...5:
                securityLevelProgressView.progress = 0.6
                securityLevelProgressView.progressTintColor = .systemYellow
                alert(message:"密碼安全度普通,等級\(securityLevel)")
            case 6:
                securityLevelProgressView.progress = 0.8
                securityLevelProgressView.progressTintColor = .green
                alert(message: "密碼安全度OK,等級\(securityLevel)")
            case 7:
                securityLevelProgressView.progress = 1
                securityLevelProgressView.progressTintColor = .green
                alert(message: "密碼安全度高,等級\(securityLevel)")
            default:
                return
            }
            usernameTextField.text = ""
            passwordTextField.text = ""
            securityLevel = 7
        }else{
            alert(message: "輸入框請勿留白")
        }
        
    }
    //檢查密碼
    func checkPassword(){
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        //條件1
        if password.count < 16{
            securityLevel -= 1
        }
        //條件2
        for i in commonPassword{
            if password.contains(i) == true{
                securityLevel -= 1
                break
            }
        }
        //條件3
        var numberOfDigits = 0
        for i in 0...9{
            if password.contains("\(i)") == true{
                numberOfDigits += 1
            }
        }
        if numberOfDigits == 0{
            securityLevel -= 1
        }
        //條件4
        var numberOfPunctuation = 0
        for i in punctuation{
            if password.contains(i) == true{
                numberOfPunctuation += 1
            }
        }
        if numberOfPunctuation == 0{
            securityLevel -= 1
        }
        //條件5
        if password.contains(username) == true{
            securityLevel -= 1
        }
        //條件6
        var numberOfUppercase = 0
        var numberOfLowercase = 0
        for i in password{
            if i.isUppercase == true{
                numberOfUppercase += 1
            }else if i.isLowercase == true{
                numberOfLowercase += 1
            }
        }
        if numberOfUppercase == 0 && numberOfLowercase == 0{
            securityLevel -= 2
        }else if numberOfUppercase == 0{
            securityLevel -= 1
        }else if numberOfLowercase == 0{
            securityLevel -= 1
        }
    }
    //告知使用者強度
    func alert(message:String){
        let alert = UIAlertController(title: "檢查結果", message:message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { okAction in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

