import 'package:share_plus/share_plus.dart';

abstract class ShareService {
  Future<void> share(String text);
}

class ShareServiceImpl implements ShareService {
  @override
  Future<void> share(String text) => Share.share(text);
}
