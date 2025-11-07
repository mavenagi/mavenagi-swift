import Foundation

extension Requests {
    public struct SimulationImportRequest {
        /// A CSV containing one question per row
        public let file: FormFile
        /// The response config to use for all of the created simulations.
        public let responseConfig: ResponseConfig?

        public init(
            file: FormFile,
            responseConfig: ResponseConfig? = nil
        ) {
            self.file = file
            self.responseConfig = responseConfig
        }
    }
}

extension Requests.SimulationImportRequest: MultipartFormDataConvertible {
    var multipartFormFields: [MultipartFormField] {
        [
            .file(file, fieldName: "file"),
            .field(responseConfig, fieldName: "responseConfig")
        ]
    }
}