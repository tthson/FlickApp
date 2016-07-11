//
//  MoviesViewController.swift
//  FlickApp
//
//  Created by Son, Tran Thai on 7/5/16.
//  Copyright © 2016 Son, Tran Thai. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var movies = [NSDictionary]()
    var baseUrl = "http://image.tmdb.org/t/p/original"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
                                                                     completionHandler: { (dataOrNil, response, error) in
                                                                        if let data = dataOrNil {
                                                                            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                                                                                data, options:[]) as? NSDictionary {
                                                                                //print("response: \(responseDictionary)")
                                                                                self.movies = responseDictionary["results"] as! [NSDictionary]
                                             self.tableView.reloadData()                               }
                                                                        }
        })
        task.resume()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return movies.count
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //let cell = UITableViewCell()
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell") as! MovieCell
        cell.titleLabel.text = movies[indexPath.row]["title"] as! String
        cell.overviewLabel.text = movies[indexPath.row]["overview"] as! String
        let posterUrlString = baseUrl + (movies[indexPath.row]["poster_path"] as! String)
        cell.posterImage.setImageWithURL(NSURL(string: posterUrlString)!)
        //cell.textLabel?.text = movies[indexPath.row]["title"] as! String
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nextVC = segue.destinationViewController as! DetailViewController
        let ip = tableView.indexPathForSelectedRow
        let overview =  movies[ip!.row]["overview"] as! String
        let urlString = baseUrl + (movies[ip!.row]["poster_path"] as! String)
        nextVC.overviewText = overview
        nextVC.posterImageUrl =  urlString
        
    }
    

}
