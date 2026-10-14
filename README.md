# swift-whatwg-encoding

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Foundation-free Swift implementation of the WHATWG Encoding Standard: encoding labels and decoders.

The package resolves an encoding label as the standard does (so `iso-8859-1`, `latin1` and `us-ascii` mean windows-1252) and decodes octets to text with the standard's decode algorithm, including byte order mark sniffing and replacement characters for errors. It covers UTF-8, UTF-16BE and UTF-16LE, every legacy single-byte encoding, `replacement` and `x-user-defined`; the index tables are generated from the standard's own index files. The legacy multi-byte encodings (GBK, gb18030, Big5, EUC-JP, ISO-2022-JP, Shift_JIS, EUC-KR) are not implemented yet, and their labels resolve to no encoding.

```swift
import WHATWG_Encoding

let encoding = WHATWG_Encoding.Encoding(label: "ISO-8859-1")  // .windows1252
encoding?.decode(bytes)
```

## License

Apache 2.0. See [LICENSE.md](LICENSE.md). The index tables are derived from the WHATWG Encoding Standard (https://encoding.spec.whatwg.org/), licensed under CC BY 4.0.
