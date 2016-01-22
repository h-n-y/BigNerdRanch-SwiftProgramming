import Cocoa

var coloradoZipCodes = [
    
    "Larimer": [ 80511, 80521, 80522, 80524, 80525 ],
    "Boulder": [ 80301, 80302, 80501, 80502, 80503 ],
    "Denver":  [ 80123, 80201, 80202, 80203, 80204 ],
]

// Collect zip codes into a single array
var zipCodes: [Int] = []
for countyZipCodes in coloradoZipCodes.values {
    zipCodes += countyZipCodes
}

print("Colorado has the following zip codes: \(zipCodes)")

