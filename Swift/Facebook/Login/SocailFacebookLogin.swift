//
//  SocailFacebookLogin.swift
//  MedicalApp
//
//  Created by Apple on 05/12/16.
//  Copyright © 2016 vijayvirSingh. All rights reserved.
//
/* For more help  Defination :-

   http://blog.robkerr.com/facebook-integration-with-swift/

 
 */

import UIKit

import FacebookLogin

import FacebookCore

import FBSDKLoginKit

class SocailFacebookLogin: NSObject , FBSDKLoginButtonDelegate
{
    // MARK: Outlets
    
   
    @IBOutlet weak var btnLogin: FBSDKLoginButton!
    
    @IBOutlet weak var lblUserId: UILabel!
    
    @IBOutlet weak var lblUserName: UILabel!
   
    @IBOutlet weak var viewProfileimage: FBSDKProfilePictureView!
    
    // MARK: Variables
    
    var isLogin : Bool = true
    
    var closureDidSignUP:  (( _ accessToken  : FBSDKAccessToken , _ profile : FBSDKProfile ) -> ())?
    
    var closureDidLogin:  (( _ accessToken  : FBSDKAccessToken ) -> ())?
    
    var closureDidLogOut:  (( _ logout  : Bool ) -> ())?
    
    // MARK: CLC

    func configure(islogin: Bool)
    {
        self.isLogin = islogin
        
        let permissions : [String] = [FBPermission.public_profile.rawValue, FBPermission.email.rawValue ]

         btnLogin.readPermissions = permissions;
        
         FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        
        NotificationCenter.default.addObserver(
            
            forName: NSNotification.Name.FBSDKProfileDidChange,
            object: nil, queue: nil) { (Notification) in
                
                if let profile = FBSDKProfile.current(),
                    let firstName = profile.firstName,
                    let lastName = profile.lastName,
                     let userID = profile.userID
                {
                    if (self.lblUserName != nil)
                    {
                         self.lblUserName.text = "\(firstName) \(lastName)"
                    }
                    
                    if (self.lblUserId != nil)
                    {
                        self.lblUserId.text = "\(userID) "
                    }
                   
                } else
                {
                    if (self.lblUserName != nil)
                    {
                       self.lblUserName.text = "Unknown"
                    }
                    
                    if (self.lblUserId != nil)
                    {
                        self.lblUserId.text = "Unknown"
                    }
                    
                   
                }
        }
        
        
        
        if let accessToken = AccessToken.current {
            print("\(accessToken)")
            // User is logged in, use 'accessToken' here.
        }
        
        
        
    }
  
     //MARK:  FBSDKLoginButtonDelegate
    
     func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!)
     {
        if let result = result {
          //
            if (result.isCancelled)
            {
                return
                
            }
            if (self.lblUserName != nil)
            {
                self.lblUserName.text = result.token.userID
                
                if (isLogin)
                {
                    if ((closureDidLogin) != nil)
                    {
                        closureDidLogin?(result.token )
                    }
                }
               else
                {
                    if ((closureDidSignUP) != nil)
                    {
                        closureDidSignUP?(result.token , FBSDKProfile.current())
                    }
                    
                }
                
                
            }
            
            
            // Notify our web API that this user has logged in with Facebook
        }
    }
    
    /**
     Sent to the delegate when the button was used to logout.
     - Parameter loginButton: The button that was clicked.
     */
     func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
     {
         print("Logging out")
        
        
        if let accessToken = AccessToken.current
        {
            print("\(accessToken)")
            // User is logged in, use 'accessToken' here.
        }
        
        
        if ((closureDidLogOut) != nil)
        {
            closureDidLogOut?(true)
        }
        
    }
    
    /**
     Sent to the delegate when the button is about to login.
     - Parameter loginButton: the sender
     - Returns: YES if the login should be allowed to proceed, NO otherwise
     */
  func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool
    
   {
    return true
    }
}

extension AppDelegate
{
    func facebook(application: UIApplication , launchOptions: [UIApplicationLaunchOptionsKey: Any]?)
    {
        FBSDKApplicationDelegate.sharedInstance().application(application,
                                                              didFinishLaunchingWithOptions: launchOptions)
        AppEventsLogger.activate(application)
        
    }
}


enum  FBPermission: String
{
    /// Provides access to a subset of items that are part of a person's public profile.
    
    case  public_profile = "public_profile"
    
    case user_friends = "user_friends"
    
    case email = "email"
    
    case user_about_me = "user_about_me"
    
    case user_birthday = "user_birthday"
    
    /*
     user_actions.books = "" ,
     user_actions.fitness = "" ,
     user_actions.music = "" ,
     user_actions.news = "" ,
     user_actions.video = "" ,
     //user_actions:{app_namespace}
     
     user_education_history = "" ,
     user_events = "" ,
     user_games_activity = "" ,
     user_hometown = "" ,
     user_likes = "" ,
     user_location = "" ,
     user_managed_groups = "" ,
     user_photos = "" ,
     user_posts = "" ,
     user_relationships = "" ,
     user_relationship_details = "" ,
     user_religion_politics = "" ,
     user_tagged_places = "" ,
     user_videos = "" ,
     user_website = "" ,
     user_work_history = "" ,
     read_custom_friendlists = "" ,
     read_insights = "" ,
     read_audience_network_insights = "" ,
     read_page_mailboxes = "" ,
     manage_pages = "" ,
     publish_pages = "" ,
     publish_actions = "" ,
     rsvp_event = "" ,
     pages_show_list = "" ,
     pages_manage_cta = "" ,
     pages_manage_instant_articles = "" ,
     ads_read = "" ,
     ads_management = "" ,
     business_management = "" ,
     pages_messaging = "" ,
     pages_messaging_subscriptions = "" ,
     pages_messaging_payments = "" ,
     pages_messaging_phone_number = "" ,
     
     */
}

// FIXME:  HOW TO USE IN view controller
/*       ___________________ HOW TO USE IN viewController CLASS ________________________
 
 import FacebookCore
 import FBSDKLoginKit
 
  @IBOutlet var facebookO: SocailFacebookLogin!

 func facebook()
 {
 facebookO.configure(islogin: true)
 
 facebookO.closureDidLogin =
 { [unowned self](accessToken  : FBSDKAccessToken   ) -> () in
 
 print("tokenString  \(accessToken.tokenString!)")
 print("userID \(accessToken.userID!)")
 }
 
 facebookO.closureDidLogOut =
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
 

 
 facebook(application: application , launchOptions: launchOptions)
 }
 
 
 func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
 {
 let sourceApplication: String? = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
 return    FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: sourceApplication, annotation: nil)
 
 }
 
 
 */







