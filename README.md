# SocialFrameworks
SocialFrameworks

 _ Last update on  Xcode 8.1 ,  Apple Swift version 3.0.1 (swiftlang-800.0.58.6 clang-800.0.42.1)_ 

This Module includes following work 
 - `SocialFacebookLogin`
 - `SocialGoogleLogin`
 
 ## Details 
 
 - `SocialFacebookLogin`
  
  How to use in  view controller class. 
    
    ```swift
    
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
    
     ```

    How to use in AppDelegate. 
      
     ```swift
    
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
            
     ```
      
 - `SocialGoogleLogin`
 
 
    How to use in  view controller class. 
    
       ```swift
    
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
             
       ```
       
       How to use in AppDelegate. 
       
       ```swift
         
            import GoogleSignIn
     
           func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
                // Override point for customization after application launch.
            google()
              }
           func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool
            {
            return   GIDSignIn.sharedInstance().handle(url,sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplicationOpenURLOptionsKey.annotation])
            }
            
       ```
     
