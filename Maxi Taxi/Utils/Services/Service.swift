//
//  Service.swift
//  Maxi Taxi
//
//  Created by Gerardo Jacobo Luna on 30/01/25.
//

import Foundation
import Alamofire

public class Services{
    public func request<ResponseType: Codable, ParamsObject: Decodable & Encodable>(_ url:String, complemet:String, method: HTTPMethod, params: ParamsObject, token: String, model: ResponseType.Type, handler: @escaping (_ request: ResponseType?, _ error: String?) -> Void){
        let completURL = "\(url)\(complemet)"
        let headers:HTTPHeaders = [
//            HTTPHeader(name: "x-plataforma", value: "iOS")
//            HTTPHeader(name: "x-version-plataforma", value: UIDevice.current.systemVersion),
//            HTTPHeader(name: "x-version-aplicacion", value: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String),
//            HTTPHeader(name: "x-id-dispositivo", value: UUID().uuidString),
//            HTTPHeader(name: "x-nombre-dispositivo", value: UIDevice.current.name),
//            //HTTPHeader(name: "x-idAcceso", value: idAcceso!),
        HTTPHeader(name: "Content-Type", value: "application/json"),
            .authorization(bearerToken:  token)
        ]
            /*(name: "Content-Type", value: "application/x-www-form-urlencoded")
        ]*/
        print("-------------------Conectandose a API-------------------")
        print("URL---------->\(completURL)")
        print("Metodo------->\(method)")
        print("Parametros--->\(params)")
        print("Modelo------->\(model)")
        print("Cabeceras---->\(headers)")
        print("--------------------------------------------------------")
        
        AF.request(completURL, method: method, parameters: params as! Parameters, encoding: JSONEncoding.default, headers: headers).responseJSON{response in
            //print(response.response?.statusCode)
            let codeError = response.response?.statusCode ?? 0
            if codeError >= 200 && codeError <= 299{
                let decoder = JSONDecoder()
                do{
                    //TokenResponse
                    let responseModel = try decoder.decode(model, from: response.data!)
                    handler(responseModel, nil)
                }catch{
                    handler(nil,response.error?.errorDescription)
                }
            }else{
                //ErrorResponse
                let decoder = JSONDecoder()
                do{
                    //let responseModel = try decoder.decode(ErrorResponse.self, from: response.data!)
                    //handler(nil,responseModel.detail)
                }catch{
                    handler(nil,response.error?.errorDescription)
                }
            }
        }
    }
}
