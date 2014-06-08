//
//  ViewController.swift
//  SwfitRSSSample
//
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MWFeedParserDelegate
{
    
    @IBOutlet var tableView : UITableView
    var items : Array<MWFeedItem> = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear (animated:Bool)
    {
        super.viewWillAppear(animated)
        request()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func request()
    {
        let URL : NSURL = NSURL(string : "http://feeds.feedburner.com/blogspot/hsDu?format=xml")
        let feedParser : MWFeedParser = MWFeedParser(feedURL : URL)
        feedParser.delegate = self
        feedParser.parse()
    }
    
    func feedParserDidStart(parser: MWFeedParser) {
        SVProgressHUD.show()
        items = []
    }
    
    func feedParserDidFinish(parser: MWFeedParser) {
        SVProgressHUD.dismiss()
        tableView.reloadData()
    }
    
    
    func feedParser(parser: MWFeedParser, didParseFeedInfo info: MWFeedInfo) {
        title = info.title
    }
    
    func feedParser(parser: MWFeedParser, didParseFeedItem item: MWFeedItem) {
        items.append(item)
    }
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath:NSIndexPath!) -> UITableViewCell!
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default,  reuseIdentifier: "Cell")
        
        var item : MWFeedItem = items[indexPath.row]
        cell.textLabel.text = item.title
        return cell;
    }
    
    func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath!)
    {
        let item = items[indexPath.row] as MWFeedItem
        println(item.link)
        let URL = NSURL(string : item.link)
        println(URL)
        
        let con  = KINWebBrowserViewController()
        con.loadURL(URL)
        navigationController.pushViewController(con, animated : true)
    }
    
}

