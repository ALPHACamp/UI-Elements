//
//  ImagesTableViewController.swift
//  XcodeDemo
//
//  Created by Brian Hu on 6/1/16.
//  Copyright © 2016 AlphaCamp. All rights reserved.
//

import UIKit

class ImagesTableViewController: UITableViewController, ClickableTableViewCellDelegate {
    
    @IBAction func editTableView(sender: AnyObject) {
        self.tableView.setEditing(!self.tableView.editing, animated: true)
    }

    @IBAction func switchToFirstTab(sender: AnyObject) {
        self.tabBarController?.selectedIndex = 0
    }
    
    let imageCellIdentifier = "ImageTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension

        tableView.registerNib(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
//
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows: Int!
        switch section {
        case 0:
            numberOfRows = 1
        default:
            numberOfRows = Image.images.count
        }
        return numberOfRows
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let image: Image = Image.images[indexPath.row]
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("ClickableCell", forIndexPath: indexPath) as! ClickableTableViewCell
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath)
            cell.textLabel?.text = image.name
            cell.imageView?.image = UIImage(named: image.name)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("ImageTableViewCell", forIndexPath: indexPath) as! ImageTableViewCell
            
            cell.nameLabel.text = image.name
            cell.myImageView.image = UIImage(named: image.name)
            cell.descriptionLabel.text = image.description
            
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        switch section {
        case 0:
            title = "Clickable Cell"
        case 1:
            title = "Standard Cell"
        case 2:
            title = "Custom Cell"
        default:
            break
        }
        return title
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section != 0 {
            self.performSegueWithIdentifier("ShowImageSegue", sender: Image.images[indexPath.row])
        }
    }
    // MARK: - Navigation 
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowImageSegue" {
            let destinationViewController = segue.destinationViewController as! ImageViewController

            let image = sender as! Image
            destinationViewController.imageName = image.name
        }
    }

     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
         return true
     }

    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
         if editingStyle == .Delete {
            Image.images.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
         } else if editingStyle == .Insert {
         // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
     }
 
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        print("\(toIndexPath)")
        let imageName = Image.images.removeAtIndex(fromIndexPath.row)
        Image.images.insert(imageName, atIndex: toIndexPath.row)
    }
    
    func sayGoodBye() {
        self.tabBarController?.selectedIndex = 0
    }
    
    func sayHi() {
        print("hi from controller")
    }
}
