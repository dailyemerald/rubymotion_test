class StoryController < UIViewController
  def viewDidLoad
    super
    @data = [{'title' => ''}] # this should be in a model or somethin'
	  BW::HTTP.get("http://dailyemerald.com/section/news/json") do |response|
  		if response.ok?
    		@data = BW::JSON.parse(response.body.to_str)
    		puts "JSON loaded and parsed!"
        self.title = "Stories"
    		@table.reloadData
  		else
    		puts "ERROR!", response.error_message
  		end
	  end
    self.title = "Loading..."
    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.dataSource = self
    @table.delegate = self
    self.view.addSubview @table
    
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      tvcell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
      webview = UIWebView.alloc.initWithFrame(tvcell.bounds)
      webview.tag = 11 # no meaning to this number. gets used a few lines down to fish it back out of contentView
      webview.userInteractionEnabled = false
      tvcell.contentView.addSubview(webview)          
      puts "Created a cell! indexPath:#{indexPath.row}"
      tvcell
    end
    cell.contentView.viewWithTag(11).loadHTMLString("#{@data[indexPath.row]['title']}", baseURL:nil)

  	return cell
  end


  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

  def tableView(tableView, heightForRowAtIndexPath:indexPath)
    55
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
	 tableView.deselectRowAtIndexPath(indexPath, animated: false)
   self.navigationController.pushViewController(SingleController.alloc.initWithPost(@data[indexPath.row]), animated:true)
  end

end