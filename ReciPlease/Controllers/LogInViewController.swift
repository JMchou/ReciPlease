//
//  ViewController.swift
//  ReciPlease
//
//  Created by Jiaming Zhou on 9/23/20.
//

import UIKit
import Firebase
import IHKeyboardAvoiding

class LogInViewController: UIViewController {
   
   let loginToHomePageIdentifier = "LogInToHomePage"
   var backButtonOriginCenter: CGPoint = CGPoint.zero
   var registerButtonOriginCenter: CGPoint = CGPoint.zero
   
   @IBOutlet weak var LogInButton: UIButton!
   @IBOutlet weak var SignUpButton: UIButton!
   @IBOutlet weak var registerButton: UIButton!
   @IBOutlet weak var backButton: UIButton!
   
   @IBOutlet weak var emailField: TextFieldWithPadding!
   @IBOutlet weak var passwordField: TextFieldWithPadding!
   
   @IBOutlet weak var midView: UIView!
   @IBOutlet weak var topView: UIView!
   @IBOutlet weak var stackView: UIStackView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      
      let tab = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
      
      view.addGestureRecognizer(tab)
      
      //Add notification to know when keyboard shows up
      KeyboardAvoiding.avoidingView = self.midView
      //      NotificationCenter.default.addObserver(self, selector: #selector(moveViewUp(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
      //      NotificationCenter.default.addObserver(self, selector: #selector(moveViewBack(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
      
      configureUI()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      prepareForAnimation()
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      
      initalAniamtion()
   }
   
   
   //MARK: - IBActions
   
   @IBAction func signUpButtonPressed(_ sender: UIButton) {
      
      
      //save back and register buttons original positions
      backButtonOriginCenter = backButton.center
      registerButtonOriginCenter = registerButton.center
      
      //Hide login and signup button, and present register button
      passwordField.text = ""
      passwordField.isSecureTextEntry = false
      
      let signButtonCenterPosition = SignUpButton.convert(SignUpButton.center, to: self.midView)
      
      //perform animation
      UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
         self.LogInButton.alpha = 0
         self.SignUpButton.alpha = 0
      }) { (completed) in
         UIView.animate(withDuration: 0.5) {
            self.backButton.alpha = 1
            self.registerButton.alpha = 1
            self.registerButton.center.y = signButtonCenterPosition.y
         }
      }
   }
   
   @IBAction func backButtonPressed(_ sender: UIButton) {
      
      //Revert buttson back to their original positions
      UIView.animate(withDuration: 0.5, delay: 0.1, options: [.curveEaseIn]) {
         self.backButton.center.x -= 100
         self.registerButton.center.x += self.view.bounds.width
      } completion: { (completed) in
         UIView.animate(withDuration: 0.5) {
            self.LogInButton.alpha = 1
            self.SignUpButton.alpha = 1
         }
         
         //Revert the back and register buttson back to their
         //original positions
         self.backButton.alpha = 0
         self.backButton.center = self.backButtonOriginCenter
         self.registerButton.alpha = 0
         self.registerButton.center = self.registerButtonOriginCenter
      }
      
      //Hide password input again
      passwordField.isSecureTextEntry = true
   }
   
   @IBAction func logInButtonPressed(_ sender: UIButton) {
      guard let email = emailField.text, let password = passwordField.text else { return }
      
      Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
         
         guard error == nil else {
            print(error!.localizedDescription)
            return
         }
         
         self.performSegue(withIdentifier: self.loginToHomePageIdentifier, sender: self)
         
         
      }
      
   }
   
   @IBAction func registerButtonPressed(_ sender: UIButton) {
      
      guard let email = emailField.text, let password = passwordField.text else { return }
      
      Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
         
         guard error == nil else {
            var errorMessage = error!.localizedDescription
            
            if errorMessage == "The email address is badly formatted." {
               errorMessage = "Enter a valid email."
            }
            
            let alert = UIAlertController(title: "Wrong format", message: errorMessage, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(ok)
            
            self.present(alert, animated: true, completion: nil)
         
            return
         }
         
         self.performSegue(withIdentifier: self.loginToHomePageIdentifier, sender: self)
         
      }
      
   }
   
   
   //MARK: - Helper functions
   //
   //   @objc private func moveViewUp(notification: Notification) {
   //      guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
   //         return
   //      }
   //
   //      self.stackView.frame.origin.y = 0 - keyboardSize.height
   //   }
   //
   //
   //   @objc private func moveViewBack(notification: Notification) {
   //      self.stackView.frame.origin.y = 0
   //   }
}

//MARK: - Configure UI

extension LogInViewController {
   
   private func configureUI() {
      
      //Hide register and back buttons initially
      registerButton.alpha = 0
      backButton.alpha = 0
      
      //setting it light to prevent placeholder text from disappearing
      //in the case of user's device is set to dark mode
      emailField.overrideUserInterfaceStyle = .light
      passwordField.overrideUserInterfaceStyle = .light
      passwordField.isSecureTextEntry = true
      
      //Create rounded corner buttons
      let buttonHeight = LogInButton.frame.height
      LogInButton.layer.cornerRadius = buttonHeight / 2
      SignUpButton.layer.cornerRadius = buttonHeight / 2
      registerButton.layer.cornerRadius = buttonHeight / 2
      
      //create rounded corner textfield with outlines
      let textFieldHeight = emailField.frame.height
      emailField.layer.cornerRadius = textFieldHeight / 2
      passwordField.layer.cornerRadius = textFieldHeight / 2
      
      emailField.layer.borderWidth = 0.5
      passwordField.layer.borderWidth = 0.5
      
   }
   
   private func prepareForAnimation() {
      
      //Set up inital stage of the buttons
      LogInButton.alpha = 0
      SignUpButton.alpha = 0
      LogInButton.bounds.size.width = 20
   }
   
   private func initalAniamtion() {
      
      //Perform the following animations when the view is presented
      UIView.animate(withDuration: 0.5, delay: 0.2, options: [], animations: {
         self.LogInButton.alpha = 1
         self.SignUpButton.alpha = 1
      }, completion: nil)
   }
}

