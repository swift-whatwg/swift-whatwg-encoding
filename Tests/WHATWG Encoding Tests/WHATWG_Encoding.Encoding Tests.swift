import Byte
import Testing
import WHATWG_Encoding

extension WHATWG_Encoding.Encoding {

    @Suite
    struct Test {

        @Suite
        struct Unit {}

        @Suite
        struct `Edge Case` {}

        static func bytes(_ octets: [UInt8]) -> [Byte] {
            octets.map(Byte.init(bitPattern:))
        }
    }
}

extension WHATWG_Encoding.Encoding.Test.Unit {

    @Test
    func `labels resolve case insensitively after trimming`() {
        #expect(WHATWG_Encoding.Encoding(label: " UTF-8\t") == .utf8)
        #expect(WHATWG_Encoding.Encoding(label: "utf8") == .utf8)
        #expect(WHATWG_Encoding.Encoding(label: "Windows-1252") == .windows1252)
    }

    @Test
    func `latin1 and ascii labels mean windows 1252`() {
        #expect(WHATWG_Encoding.Encoding(label: "iso-8859-1") == .windows1252)
        #expect(WHATWG_Encoding.Encoding(label: "latin1") == .windows1252)
        #expect(WHATWG_Encoding.Encoding(label: "us-ascii") == .windows1252)
    }

    @Test
    func `windows 1252 decodes the euro sign and accents`() {
        let decoded = WHATWG_Encoding.Encoding.windows1252.decode(WHATWG_Encoding.Encoding.Test.bytes([0x80, 0x20, 0x63, 0x61, 0x66, 0xE9]))

        #expect(decoded == "€ café")
    }

    @Test
    func `iso 8859 15 differs from windows 1252 at A4`() {
        #expect(WHATWG_Encoding.Encoding.iso8859_15.decode(WHATWG_Encoding.Encoding.Test.bytes([0xA4])) == "€")
        #expect(WHATWG_Encoding.Encoding.windows1252.decode(WHATWG_Encoding.Encoding.Test.bytes([0xA4])) == "¤")
    }

    @Test
    func `UTF-8 decodes`() {
        #expect(WHATWG_Encoding.Encoding.utf8.decode([Byte](utf8: "Factuur – café")) == "Factuur – café")
    }

    @Test
    func `UTF-16 decodes in both byte orders`() {
        #expect(WHATWG_Encoding.Encoding.utf16le.decode(WHATWG_Encoding.Encoding.Test.bytes([0x41, 0x00, 0xAC, 0x20])) == "A€")
        #expect(WHATWG_Encoding.Encoding.utf16be.decode(WHATWG_Encoding.Encoding.Test.bytes([0x00, 0x41, 0x20, 0xAC])) == "A€")
    }

    @Test
    func `a byte order mark overrides the encoding`() {
        #expect(WHATWG_Encoding.Encoding.windows1252.decode(WHATWG_Encoding.Encoding.Test.bytes([0xEF, 0xBB, 0xBF, 0xC3, 0xA9])) == "é")
        #expect(WHATWG_Encoding.Encoding.windows1252.decode(WHATWG_Encoding.Encoding.Test.bytes([0xFF, 0xFE, 0xE9, 0x00])) == "é")
    }

    @Test
    func `every single byte encoding decodes ASCII unchanged`() {
        let ascii = [Byte](utf8: "Invoice 42")
        for encoding in WHATWG_Encoding.Encoding.allCases where encoding != .replacement && encoding != .utf16be && encoding != .utf16le {
            #expect(encoding.decode(ascii) == "Invoice 42", "\(encoding.name)")
        }
    }

    @Test
    func `names follow the specification`() {
        #expect(WHATWG_Encoding.Encoding.iso8859_8_i.name == "ISO-8859-8-I")
        #expect(WHATWG_Encoding.Encoding.xMacCyrillic.name == "x-mac-cyrillic")
    }
}

extension WHATWG_Encoding.Encoding.Test.`Edge Case` {

    @Test
    func `an unknown or unsupported label has no encoding`() {
        #expect(WHATWG_Encoding.Encoding(label: "no-such-charset") == nil)
        #expect(WHATWG_Encoding.Encoding(label: "shift_jis") == nil)
    }

    @Test
    func `invalid UTF-8 becomes replacement characters`() {
        #expect(WHATWG_Encoding.Encoding.utf8.decode(WHATWG_Encoding.Encoding.Test.bytes([0x61, 0xFF, 0x62])) == "a\u{FFFD}b")
    }

    @Test
    func `an unmapped single byte becomes a replacement character`() {
        #expect(WHATWG_Encoding.Encoding.windows874.decode(WHATWG_Encoding.Encoding.Test.bytes([0xDB])) == "\u{FFFD}")
    }

    @Test
    func `an odd trailing UTF-16 byte becomes a replacement character`() {
        #expect(WHATWG_Encoding.Encoding.utf16le.decode(WHATWG_Encoding.Encoding.Test.bytes([0x41, 0x00, 0x42])) == "A\u{FFFD}")
    }

    @Test
    func `the replacement encoding yields one replacement character`() {
        #expect(WHATWG_Encoding.Encoding.replacement.decode(WHATWG_Encoding.Encoding.Test.bytes([0x1B, 0x24])) == "\u{FFFD}")
        #expect(WHATWG_Encoding.Encoding.replacement.decode([Byte]()) == "")
    }

    @Test
    func `x user defined maps high bytes to the private use area`() {
        #expect(WHATWG_Encoding.Encoding.xUserDefined.decode(WHATWG_Encoding.Encoding.Test.bytes([0x80])) == "\u{F780}")
    }
}
