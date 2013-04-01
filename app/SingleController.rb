class SingleController < UIViewController
  attr_accessor :post

  def initWithPost(post)
    initWithNibName(nil, bundle:nil)
    self.post = post
    self
  end

  def viewDidLoad
    super
    self.title = "#{post['title']}"
    body = "<style type='text/css'>*{font-family: 'Helvetica'; font-size:16px; color:#333; line-height:24px;}body{padding-bottom:40px}</style>#{post['content']}"
    webview = UIWebView.alloc.initWithFrame(self.view.bounds)
    webview.loadHTMLString(body, baseURL:nil)
    self.view.addSubview(webview) 
  end

end