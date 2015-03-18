//
//  ViewController.swift
//  MyCoreData
//
//  Created by Tracy Fisher on 3/6/15.
//  Copyright (c) 2015 rock Valley College. All rights reserved.
//

import UIKit

//0) Add import for CoreData
import CoreData

class ViewController: UIViewController {
    
    //1) Add ManagedObject Data Context
    
    
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as AppDelegate).managedObjectContext
    
    //2) Add variable mycoredatdb (used from UITableView
    
    var mycoredatadb:NSManagedObject!

    @IBOutlet weak var artist: UITextField!
    
    @IBOutlet weak var songtitle: UITextField!
    
    @IBOutlet weak var album: UITextField!
    
    
    @IBOutlet weak var status: UILabel!
    
    
    @IBOutlet weak var genere: UITextField!
    
    
    @IBOutlet weak var btnSave: UIButton!
    
    
    @IBAction func btnBack(sender: UIBarButtonItem) {
        
        //3) Dismiss ViewController
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    @IBAction func btnSave(sender: UIButton) {
        
        //4 Add Save Logic
        if (mycoredatadb != nil)
        {
            
            mycoredatadb.setValue(artist.text, forKey: "artist")
            mycoredatadb.setValue(songtitle.text, forKey: "songtitle")
            mycoredatadb.setValue(album.text, forKey: "album")
            mycoredatadb.setValue(genere.text, forKey: "genere")
            
        }
        else
        {
            let entityDescription =
            NSEntityDescription.entityForName("MyCoreData",
                inManagedObjectContext: managedObjectContext!)
            
            let mycoredata = MyCoreData(entity: entityDescription!,
                insertIntoManagedObjectContext: managedObjectContext)
            
            mycoredata.artist = artist.text
            mycoredata.songtitle = songtitle.text
            mycoredata.album = album.text
            mycoredata.genere = genere.text
        }
        var error: NSError?
        managedObjectContext?.save(&error)
        
        if let err = error {
            status.text = err.localizedFailureReason
        } else {
            self.dismissViewControllerAnimated(false, completion: nil)
            
        }

    }
    
    
    @IBAction func btnFind(sender: UIButton) {
        
        //5 Add Find Logic
        let entityDescription =
        NSEntityDescription.entityForName("MyCoreData",
            inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        let pred = NSPredicate(format: "(artist = %@)", artist.text)
        request.predicate = pred
        
        var error: NSError?
        
        var objects = managedObjectContext?.executeFetchRequest(request,
            error: &error)
        
        if let results = objects {
            
            if results.count > 0 {
                let match = results[0] as NSManagedObject
                
                artist.text = match.valueForKey("artist") as String
                songtitle.text = match.valueForKey("songtitle") as String
                album.text = match.valueForKey("album") as String
                genere.text = match.valueForKey("genere") as String
                status.text = "Matches found: \(results.count)"
            } else {
                status.text = "No Match"
            }
        }

    }
    
    //6 Add to hide keyboard
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        //forces resign first responder and hides keyboard
        DismissKeyboard()
    }
    
    //7 Add to hide keyboard
    func DismissKeyboard(){
        //forces resign first responder and hides keyboard
        artist.endEditing(true)
        songtitle.endEditing(true)
        album.endEditing(true)
        genere.endEditing(true)
        
    }
    //8 Add to hide keyboard
    func textFieldShouldReturn(textField: UITextField!) -> Bool     {
        textField.resignFirstResponder()
        return true;
    }

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //9 Add logic to load db. If contactdb has content that means a row was tapped on UiTableView
        if (mycoredatadb != nil)
        {
            artist.text = mycoredatadb.valueForKey("artist") as String
            songtitle.text = mycoredatadb.valueForKey("songtitle") as String
            album.text = mycoredatadb.valueForKey("album") as String
            genere.text = mycoredatadb.valueForKey("genere") as String
            btnSave.setTitle("Update", forState: UIControlState.Normal)
        }
        artist.becomeFirstResponder()
        // Do any additional setup after loading the view.
        //Looks for single or multiple taps
        var tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        //Adds tap gesture to view
        view.addGestureRecognizer(tap)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

