public import Byte

extension WHATWG_Encoding.Encoding {

    public func decode(_ bytes: some Swift.Collection<Byte>) -> String {
        let octets = bytes.map(\.bitPattern)
        switch Array(octets.prefix(3)) {
        case [0xEF, 0xBB, 0xBF]:
            return WHATWG_Encoding.Encoding.utf8.decode(withoutMark: octets.dropFirst(3))
        case let prefix where prefix.starts(with: [0xFE, 0xFF]):
            return WHATWG_Encoding.Encoding.utf16be.decode(withoutMark: octets.dropFirst(2))
        case let prefix where prefix.starts(with: [0xFF, 0xFE]):
            return WHATWG_Encoding.Encoding.utf16le.decode(withoutMark: octets.dropFirst(2))
        default:
            return decode(withoutMark: octets[...])
        }
    }

    func decode(withoutMark octets: ArraySlice<UInt8>) -> String {
        switch self {
        case .utf8:
            return String(decoding: octets, as: UTF8.self)
        case .utf16be, .utf16le:
            return Self.utf16(octets, bigEndian: self == .utf16be)
        case .replacement:
            return octets.isEmpty ? "" : "\u{FFFD}"
        case .xUserDefined:
            return String(String.UnicodeScalarView(octets.map(Self.userDefined)))
        default:
            return String(String.UnicodeScalarView(octets.map { Self.single($0, index: index ?? []) }))
        }
    }

    static func single(_ octet: UInt8, index: [Unicode.Scalar?]) -> Unicode.Scalar {
        octet < 0x80 ? Unicode.Scalar(octet) : index[Int(octet - 0x80)] ?? "\u{FFFD}"
    }

    static func userDefined(_ octet: UInt8) -> Unicode.Scalar {
        octet < 0x80 ? Unicode.Scalar(octet) : Unicode.Scalar(0xF780 + UInt32(octet - 0x80)) ?? "\u{FFFD}"
    }

    static func utf16(_ octets: ArraySlice<UInt8>, bigEndian: Bool) -> String {
        let pairs = stride(from: octets.startIndex, to: octets.endIndex - 1, by: 2).map { position in
            bigEndian
                ? UInt16(octets[position]) << 8 | UInt16(octets[position + 1])
                : UInt16(octets[position + 1]) << 8 | UInt16(octets[position])
        }
        return String(decoding: pairs, as: UTF16.self) + (octets.count % 2 == 1 ? "\u{FFFD}" : "")
    }
}
