import 'dart:io';

dynamic main() {
  final rootDir = Directory.current;
  final commitFile = File(rootDir.path + '/.git/COMMIT_EDITMSG');
  final commitMessage = commitFile.readAsStringSync().trimRight();
  print('Message -> $commitMessage');

  final RegExp regExp = RegExp(
      r'^(feat|fix|test|docs|style|refactor|perf|build|ci)\((no-ref|us-\d{2})\): .*$');

  if (commitMessage.length > 72) {
    print('Aborting commit. Your commit message is too long.');
    exit(1);
  }

  if (!regExp.hasMatch(commitMessage)) {
    print(
        "Aborting commit. Please use 'type(us-xx): message' format. Allowed types: feat, fix, test, docs, style, refactor, perf, build, ci.\n");
    exit(1);
  }
}
