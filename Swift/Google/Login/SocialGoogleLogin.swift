//
//  SocialGoogleLogin.swift
//  MedicalApp
//
//  Created by Apple on 06/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseCore

class SocialGoogleLogin: NSObject , GIDSignInUIDelegate,GIDSignInDelegate
{

    
    // MARK: Outlets
    
    
    @IBOutlet weak var btnLogIn: GIDSignInButton!
    
    @IBOutlet weak var statusText: UILabel!
    
    @IBOutlet weak var btnSignOut: UIButton!
    
    @IBOutlet weak var btndisconnect: UIButton!
    
    // MARK: Variables
     let notificationNameToggleAuthUI = Notification.Name("ToggleAuthUINotification")
  
    
    // MARK: CLC
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                            name: notificationNameToggleAuthUI,
                                                            object: nil)
    }
    
    
    
    var isLogin : Bool = true
    
    var closureDidSignUP:  (( _ user: GIDGoogleUser ) -> ())?
    
    var closureDidLogin:  (( _ user: GIDGoogleUser ) -> ())?
    
    var closureDidLogOut:  (( _ logout  : Bool ) -> ())?
    
    // MARK: CLC
    
    func configure(islogin: Bool)
    {
        self.isLogin = islogin
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        // TODO(developer) Configure the sign-in button look/feel
        // [START_EXCLUDE]
        
        
        // Define identifier
       

        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(SocialGoogleLogin.receiveToggleAuthUINotification), name: notificationNameToggleAuthUI, object: nil)
        
   
        if statusText != nil
        {
              statusText.text = "Initialized Swift app..."
        }
      
        toggleAuthUI()
        
    }
    
    
  func receiveToggleAuthUINotification(notification: NSNotification)
  {
        if (notification.name == notificationNameToggleAuthUI)
        {
            self.toggleAuthUI()
            if notification.userInfo != nil {
                let userInfo:Dictionary<String,String?> =
                    notification.userInfo as! Dictionary<String,String?>
                if statusText != nil
                {
                    statusText.text = userInfo["statusText"]!
                }
                
            
            }
        }
    }

    
    // MARK: Actions
    @IBAction func didTapSignOut(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        // [START_EXCLUDE silent]
        
        if statusText != nil
        {
            statusText.text = "Signed out."
        }
        
        if ((closureDidLogOut) != nil)
        {
            closureDidLogOut?(true)
        }
        
        toggleAuthUI()
        // [END_EXCLUDE]
    }
    // [END signout_tapped]
    // [START disconnect_tapped]
    @IBAction func didTapDisconnect(sender: AnyObject) {
        GIDSignIn.sharedInstance().disconnect()
        // [START_EXCLUDE silent]
        statusText.text = "Disconnecting."
        // [END_EXCLUDE]
    }
    
     // MARK: Functions 
    
    func toggleAuthUI() {
        if (GIDSignIn.sharedInstance().hasAuthInKeychain())
        {
            // Signed in
        
            if btnLogIn != nil
            {
                 btnLogIn.isHidden = true
            }
            
            if btnSignOut != nil
            {
                btnSignOut.isHidden = false
            }
            
            if btndisconnect != nil
            {
                   btndisconnect.isHidden = false
            }
           
         
        } else {
            
            
            if btnLogIn != nil
            {
                   btnLogIn.isHidden = false
            }
            
            if btnSignOut != nil
            {
                 btnSignOut.isHidden = true
            }
            
            if btndisconnect != nil
            {
                   btndisconnect.isHidden = true
            }
            
            
            
            if statusText != nil
            {
               statusText.text = "Google Sign in\niOS Demo"
            }
           
        
            
        }
    }
    
    
    
    
    
    
    //MARK: GIDSignInDelegate
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
    {
        if (error == nil)
        {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            NotificationCenter.default.post(
                name: notificationNameToggleAuthUI,
                object: nil,
                userInfo: ["statusText": "Signed in user:\n\(idToken)"])
            
            if ((closureDidLogin) != nil)
            {
                closureDidLogin?(user)
                
            }
            
            
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    // Finished disconnecting |user| from the app successfully if |error| is |nil|.
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!)
    {
        
    }
    
    
    
    
    // MARK: GIDSignInUIDelegate
    
    //______________________For non Viewcontroller class
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController
        {
            while let presentedViewController = topController.presentedViewController
            {
                topController = presentedViewController
            }
        
        topController.present(viewController, animated: true, completion: nil)
        }
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        
        
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController
        {
            while let presentedViewController = topController.presentedViewController
            {
                topController = presentedViewController
            }
             topController.dismiss(animated: true, completion: nil)
        }
        
       
    }


    
}

extension AppDelegate
{
    // new functionality to add to SomeType goes here
    
    func google()
    {
       
//                var configureError: NSError?
//                GGLContext.sharedInstance().configureWithError(&configureError)
//                assert(configureError == nil, "Error configuring Google services: \(configureError)")
        
        GIDSignIn.sharedInstance().clientID = "1019504602008-k8kufkf883m1tqause05fsh329fo3f50.apps.googleusercontent.com"
        
    }
    
   
    
}





// FIXME:  HOW TO USE IN view controller
/*       ___________________ HOW TO USE IN viewController CLASS ________________________
 
import GoogleSignIn
 
  @IBOutlet var googleO: SocialGoogleLogin!
 
 func google()
 {
 googleO.configure(islogin: true)
 
 
 googleO.closureDidLogin =
 { [unowned self](user: GIDGoogleUser  ) -> () in
 
 print("userID  \(user.userID!)")
 
 }
 
 googleO.closureDidLogOut =
 { (  logout  : Bool ) -> () in
 
 
 print("\(logout)")
 
 }
 
 
 }
 
 // FIXME:  HOW TO USE IN AppDelegate
 
 import CoreData
 import FacebookCore
 import FBSDKCoreKit
 
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
 // Override point for customization after application launch.
 
 
 
   google()
 
 }
 
 
 func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
 {

 return   GIDSignIn.sharedInstance().handle(url,
 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
 
 }
 
 
 */




