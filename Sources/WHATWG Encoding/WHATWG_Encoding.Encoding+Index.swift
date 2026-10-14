extension WHATWG_Encoding.Encoding {

    var index: [Unicode.Scalar?]? {
        switch self {
        case .ibm866: WHATWG_Encoding.Index.ibm866
        case .iso8859_2: WHATWG_Encoding.Index.iso8859_2
        case .iso8859_3: WHATWG_Encoding.Index.iso8859_3
        case .iso8859_4: WHATWG_Encoding.Index.iso8859_4
        case .iso8859_5: WHATWG_Encoding.Index.iso8859_5
        case .iso8859_6: WHATWG_Encoding.Index.iso8859_6
        case .iso8859_7: WHATWG_Encoding.Index.iso8859_7
        case .iso8859_8: WHATWG_Encoding.Index.iso8859_8
        case .iso8859_8_i: WHATWG_Encoding.Index.iso8859_8
        case .iso8859_10: WHATWG_Encoding.Index.iso8859_10
        case .iso8859_13: WHATWG_Encoding.Index.iso8859_13
        case .iso8859_14: WHATWG_Encoding.Index.iso8859_14
        case .iso8859_15: WHATWG_Encoding.Index.iso8859_15
        case .iso8859_16: WHATWG_Encoding.Index.iso8859_16
        case .koi8_r: WHATWG_Encoding.Index.koi8_r
        case .koi8_u: WHATWG_Encoding.Index.koi8_u
        case .macintosh: WHATWG_Encoding.Index.macintosh
        case .windows874: WHATWG_Encoding.Index.windows874
        case .windows1250: WHATWG_Encoding.Index.windows1250
        case .windows1251: WHATWG_Encoding.Index.windows1251
        case .windows1252: WHATWG_Encoding.Index.windows1252
        case .windows1253: WHATWG_Encoding.Index.windows1253
        case .windows1254: WHATWG_Encoding.Index.windows1254
        case .windows1255: WHATWG_Encoding.Index.windows1255
        case .windows1256: WHATWG_Encoding.Index.windows1256
        case .windows1257: WHATWG_Encoding.Index.windows1257
        case .windows1258: WHATWG_Encoding.Index.windows1258
        case .xMacCyrillic: WHATWG_Encoding.Index.xMacCyrillic
        case .utf8, .replacement, .utf16be, .utf16le, .xUserDefined: nil
        }
    }
}
