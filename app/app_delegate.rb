class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    

    @story_controller = StoryController.alloc.initWithNibName(nil, bundle: nil)
    @single_controller = SingleController.alloc.initWithNibName(nil, bundle: nil)
    @navigation_controller = UINavigationController.alloc.initWithRootViewController(@story_controller)

    #@tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
    #@tab_controller.viewControllers = [story_controller]
    @window.rootViewController = @navigation_controller
    @window.makeKeyAndVisible
    true
  end
end