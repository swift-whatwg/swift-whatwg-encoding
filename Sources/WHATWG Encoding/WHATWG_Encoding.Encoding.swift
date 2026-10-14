extension WHATWG_Encoding {

    public enum Encoding: Sendable, Hashable, CaseIterable {

        case utf8

        case ibm866

        case iso8859_2

        case iso8859_3

        case iso8859_4

        case iso8859_5

        case iso8859_6

        case iso8859_7

        case iso8859_8

        case iso8859_8_i

        case iso8859_10

        case iso8859_13

        case iso8859_14

        case iso8859_15

        case iso8859_16

        case koi8_r

        case koi8_u

        case macintosh

        case windows874

        case windows1250

        case windows1251

        case windows1252

        case windows1253

        case windows1254

        case windows1255

        case windows1256

        case windows1257

        case windows1258

        case xMacCyrillic

        case replacement

        case utf16be

        case utf16le

        case xUserDefined
    }
}
