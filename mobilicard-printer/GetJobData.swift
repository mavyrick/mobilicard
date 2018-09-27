//import Foundation
//
//class GetJobData {
//
//    var jobData: JobModel?
//
//    func getJobData() {
//        
//        let parameters = [
//            "password": Constants.PrintRequestURL,
//            "mobile_number": "11223355",
//            "machine_id": "0000"
//        ]
//
//        guard let testURL = URL(string: Constants.PrintRequestURL) else { return }
//
//        var request = URLRequest(url: testURL)
//
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
//
//        print(httpBody)
//
//        request.httpBody = httpBody
//
//        let session = URLSession.shared
//
//        let task = session.dataTask(with: request) { (data, response, error) in
//
//            guard error == nil else {
//                print("error 1")
//                print(error!)
//                return
//            }
//            guard let data = data else { return }
//
//            do {
//
//                let decoder = JSONDecoder()
//                let jobDataTest = try decoder.decode(JobModel.self, from: data)
//                //                self.jobData = [jobDataTest]
//                //                print(self.jobData)
//                self.jobData = jobDataTest
//                print(self.jobData?.jobs?[0].title)
//                //                print(self.jobData[0].jobs?[0].title)
//                print(Int((jobDataTest.jobs?.count)!))
//                print(jobDataTest.jobs?[0].checkbox)
//                //                self.jobData = jobDataTest.jobs
//                //                print(jobDataTest.jobs?[0].title)
//                //                print(self.jobData)
//                //                print(self.jobData)
//
////                self.totalCost.text = "$\(self.jobData?.total_cost)"
//
//                DispatchQueue.main.async {
//
////                    self.listTableView.reloadData()
//
//                    //                    print(self.jobData)
//
//                }
//                //
//                return
//
//            } catch let err {
//                print("Err", err)
//            }
//
//
//        }
//        task.resume()
//
//    }
//
//    private struct Constants {
//        static let PrintRequestURL = "https://vend.mobilicard.com/external/rs/public/do_print_request"
//        static let PrintRequestPassword = "!dneviliboM@"
//    }
//
//}
