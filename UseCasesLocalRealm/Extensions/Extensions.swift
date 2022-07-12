//
//  Extensions.swift
//  UseCasesLocalRealm
//
//  Created by Ethan Kisiel on 7/11/22.
//

import Foundation
extension String
{
    func shorten(by: Int) -> String
    {
        // if the String is greater than "by"
        // characters, it returns the String shortened to the first "by"
        // characters and a "..." string is appended
        // if the String  is less than or Equal to "by" characters in
        // length, the String is returned
        
            return self.count <= by ? self : self[self.startIndex ..< (self.index( self.startIndex, offsetBy: by, limitedBy: self.endIndex) ?? self.endIndex)] + "..."
    }
}
