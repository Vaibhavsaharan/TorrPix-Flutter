class Torrent {
  Torrent({
    this.url,
    this.hash,
    this.quality,
    this.type,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  String? url;
  String? hash;
  String? quality;
  String? type;
  int? seeds;
  int? peers;
  String? size;
  int? sizeBytes;
  DateTime? dateUploaded;
  int? dateUploadedUnix;

  factory Torrent.fromJson(Map<String, dynamic> json) =>
      Torrent(
        url: json["url"] ?? '',
        hash: json["hash"] ?? '',
        quality: json["quality"] ?? '',
        type: json["type"] ?? '',
        seeds: json["seeds"] ?? 0,
        peers: json["peers"] ?? 0,
        size: json["size"] ?? '',
        sizeBytes: json["size_bytes"] ?? 0,
        dateUploaded: DateTime.parse(json["date_uploaded"]),
        dateUploadedUnix: json["date_uploaded_unix"] ?? 0,
      );

  Map<String, dynamic> toJson() =>
      {
        "url": url,
        "hash": hash,
        "quality": quality,
        "type": type,
        "seeds": seeds,
        "peers": peers,
        "size": size,
        "size_bytes": sizeBytes,
        "date_uploaded": dateUploaded!.toIso8601String(),
        "date_uploaded_unix": dateUploadedUnix,
      };
}