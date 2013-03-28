class StoryController < UIViewController
  def viewDidLoad
    super

    @data = [{'title' => 'Loading stories...'}]
	BW::HTTP.get("http://dailyemerald.com/json") do |response|
  		if response.ok?
    		@data = BW::JSON.parse(response.body.to_str)
    		puts @data
    		@table.reloadData
  		else
    		puts response.error_message
  		end
	end

    self.title = "Stories"
    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.dataSource = self
    @table.delegate = self
    self.view.addSubview @table
    
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:@reuseIdentifier)
    end
    cell.textLabel.text = @data[indexPath.row]['title']

  	return cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
	tableView.deselectRowAtIndexPath(indexPath, animated: true)

	alert = UIAlertView.alloc.init
	alert.message = "#{@data[indexPath.row]['content']}"
	alert.addButtonWithTitle "OK"
	alert.show
  end

end