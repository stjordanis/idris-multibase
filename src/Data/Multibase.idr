
module Data.Multibase

import Data.Vect
import Data.Multibase.Lib
import Data.Multibase.Convert
import public Data.Multibase.Types

%access export
%default total

||| Encode an arbitrary string given a supported base.
encode : BaseSymbol n -> String -> String
encode base str {n=Z} impossible
encode base str {n=S k} = let inBase = unaryToBase k (stringToBase256 str)
                           in toString base inBase

||| Decode a multibase string. The base is the first character of the string and the rest is the digest
decode : String -> Either (MultibaseError Char) String
decode str = case decodeMulti str of
                  Left err => Left err
                  Right (x ** d) => Right $ decodeFromBase (digest d)
