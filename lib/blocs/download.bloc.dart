import 'package:ace_player/blocs/base.bloc.dart';
import 'package:ace_player/models/dl_status.enum.dart';
import 'package:al_downloader/al_downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DownloadBloc extends BlocBase {
  var downloadProgress = 0.obs;
  Rx<DownloadStatus> downloadStatus = DownloadStatus.downloading.obs;
  bool sentToPreviousPage = false;
  String? downloadedFile;
  String? downloadedFilename;

  void download(String link) async {
    downloadProgress.value = 0;
    downloadStatus.value = DownloadStatus.downloading;
    try {
      await ALDownloader.download(link,
          downloaderHandlerInterface:
              ALDownloaderHandlerInterface(progressHandler: (progress) {
            downloadProgress.value = (progress * 100).toInt();
          }, succeededHandler: () async {
            downloadStatus.value = DownloadStatus.successed;
            final path = await ALDownloaderPersistentFileManager
                .getAbsolutePhysicalPathOfFileForUrl(link);
            final fileName =
                ALDownloaderPersistentFileManager.getFileNameForUrl(link);
            if (path != null) {
              downloadedFile = path;
              downloadedFilename = fileName;
            }
          }, failedHandler: () {
            downloadStatus.value = DownloadStatus.failed;
          }));
    } catch (er) {
      showError(er.toString());
      downloadStatus.value = DownloadStatus.failed;
      downloadProgress.value = 0;
    }
  }

  _getDataFromClipboard() async {
    final linkInstance = await Clipboard.getData(Clipboard.kTextPlain);
    final linkStr = linkInstance?.text ?? '';
    if (Uri.tryParse(linkStr)?.hasAbsolutePath ?? false) {
      download(linkStr);
    } else {
      showError('There is not any link in your Clipboard!');
      downloadStatus.value = DownloadStatus.failed;
      downloadProgress.value = 0;
    }
  }

  @override
  void onInit() {
    _getDataFromClipboard();
    super.onInit();
  }
}
