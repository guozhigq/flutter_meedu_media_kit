import 'dart:io';

/// The way in which the video was originally loaded.
///
/// This has nothing to do with the video's file type. It's just the place
/// from which the video is fetched from.
enum DataSourceType {
  /// The video was included in the app's asset files.
  asset,

  /// The video was downloaded from the internet.
  network,

  /// The video was loaded off of the local filesystem.
  file,

  /// The video is available via contentUri. Android only.
  contentUri,
}

class DataSource {
  File? file;
  String? source, audioSource, subFiles, package;
  DataSourceType type;
  Map<String, String>? httpHeaders; // for headers
  DataSource({
    this.file,
    this.source,
    this.audioSource,
    this.subFiles,
    required this.type,
    this.package,
    this.httpHeaders,
  }) : assert((type == DataSourceType.file && file != null) || source != null);

  DataSource copyWith({
    File? file,
    String? source,
    String? audioSource,
    String? package,
    DataSourceType? type,
    Map<String, String>? httpHeaders,
  }) {
    return DataSource(
      file: file ?? this.file,
      source: source ?? this.source,
      audioSource: audioSource ?? '',
      subFiles: subFiles ?? '',
      type: type ?? this.type,
      package: package ?? this.package,
      httpHeaders: httpHeaders ?? this.httpHeaders,
    );
  }
}
