//import UIKit
//
//class FrontPageViewController: UIViewController {
//
//    var jobData2 = [TestData2]()
//
//    //    var jobData3 = TestData3()
//
//    func test2() {
//
//        print("test")
//
//        guard let testURL = URL(string: "https://vend.mobilicard.com/external/rs/public/ping") else { return }
//
//        var request = URLRequest(url: testURL)
//
//        request.httpMethod = "GET"
//        //                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let session = URLSession.shared
//
//        print("test1")
//
//        let task = session.dataTask(with: request) { (data, response, error) in
//
//            guard error == nil else {
//                print("error 1")
//                print(error!)
//                return
//            }
//            guard let responseData = data else {
//                print("testtest")
//                return
//
//            }
//
//            //            print("test2")
//            //            print(data)
//            //            print(responseData)
//
//            do {
//                let decoder = JSONDecoder()
//                let jobData3 = try decoder.decode(TestData3.self, from: data!)
//
//                DispatchQueue.main.async {
//
//                    //                   completed()
//
//                    print(jobData3.ret_code!)
//
//                }
//
//                return
//
//            } catch let err {
//                print("Err", err)
//            }
//
//        }
//        task.resume()
//
//    }
//
//    //    func test() {
//    //
//    //        print("test")
//    //
//    //        let parameters: [String: Any] = [
//    //            "secret": "!dneviliboM@",
//    //            "username": "0542323420"
//    //        ]
//    //
//    //        //        guard let testURL = URL(string: "https://vend.mobilicard.com/external/rs/public/do_print_request") else { return }
//    //
//    //        guard let testURL = URL(string: "https://gvs.mobilicard.com/scopos/external/rs/public/user_get_info.php") else { return }
//    //
//    //        var request = URLRequest(url: testURL)
//    //
//    //        request.httpMethod = "PUT"
//    ////                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    //
//    //        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
//    //        request.httpBody = httpBody
//    //
//    //        let session = URLSession.shared
//    //
//    //        print("test1")
//    //
//    //        let task = session.dataTask(with: request) { (data, response, error) in
//    //
//    //            guard error == nil else {
//    //                print("error 1")
//    //                print(error!)
//    //                return
//    //            }
//    //            guard let responseData = data else {
//    //                print("testtest")
//    //                return
//    //
//    //            }
//    //
//    //            print("test2")
//    //            print(data)
//    //            print(responseData)
//    //
//    //            do {
//    //
//    //                let decoder = JSONDecoder()
//    //                self.jobData2 = try decoder.decode([TestData2].self, from: data!)
//    //
//    //                DispatchQueue.main.async {
//    //
//    //                    //                    completed()
//    //
//    //                    print(self.jobData2)
//    //
//    //                }
//    //
//    //                return
//    //
//    //            } catch let err {
//    //                print("Err", err)
//    //            }
//    //
//    //        }
//    //        task.resume()
//    //
//    //    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//
//        //        test()
//        test2()
//
//    }
//
//    var printOrCopy = "test"
//
//    @IBAction func printDocuments(_ sender: UIButton) {
//        //        printOrCopy = "print"
//        //        print(printOrCopy)
//
//        let vc = ListViewController(nibName: "ListViewController", bundle: nil)
//        vc.printOrCopy = "print"
//        print(vc.printOrCopy)
//        //
//        //        navigationController?.pushViewController(vc, animated: true)
//    }
//
//    @IBAction func copyDocuments(_ sender: UIButton) {
//        //        printOrCopy = "copy"
//    }
//
//    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//    //    {
//    //        if segue.destination is ListViewController
//    //        {
//    //            let vc = segue.destination as? ListViewController
//    //            vc?.printOrCopyTest = printOrCopy
//    //        }
//    //    }
//
//    //    http://gvs.mobilicard.com/scopos/pages/do_print_request.php
//
//    //    http://gvs.mobilicard.com/scopos/pages/do_print.php
//
//    //    gvs.mobilicard.com/scopos/external/rs/public/ping
//
//    //    put request
//    //    gvs.mobilicard.com/scopos/external/rs/public/user_get_info
//    //    json params:
//
//    //    gvs.mobilicard.com/scopos/external/rs/public/user_get_info.php
//}
//
//
