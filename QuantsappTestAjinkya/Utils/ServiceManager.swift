import Foundation
import Alamofire

class ServiceManager {
    static let instance = ServiceManager()
    
    lazy var connectivityManager = NetworkReachabilityManager()
    lazy var serviceManager = URLSessionConfiguration.default
    
    func getWebServiceDataWith <T: Codable> (url: String, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding, headers: HTTPHeaders? = nil, requestInterceptor: RequestInterceptor? = nil, completion: @escaping(Result<T, ServiceErrorMessages>) -> Void) {
        
        if connectivityManager?.isReachable ?? false {
            
            serviceManager.timeoutIntervalForResource = 10
            
            AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers, interceptor: requestInterceptor)
                .responseData(completionHandler: { response in
                    
                    if response.error != nil {
                        completion(.failure(.no_internet_available))
                    }
                    else {
                        let decoder = JSONDecoder()
                        guard let data = response.data else {
                            completion(.failure(.unable_to_retrive_data))
                            return
                        }
                        
                        do{
                            let returnedResponse = try decoder.decode(T.self, from: data)
                            completion(.success(returnedResponse))
                        }
                        catch{
                            debugPrint(error)
                            completion(.failure(.unable_to_retrive_data))
                        }
                        
                    }
                    
                })
            
        }
        else {
            //No Internet Available
            completion(.failure(.no_internet_available))
        }
        
    }
    
}
