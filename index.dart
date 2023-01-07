import 'dart:async';
import 'dart:convert';
import 'dart:io';

final MAX_WIDTH = 20;

main() {
  var currentPosition = [1, 1];
  var image = [
    '＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃　　　　　　　　　　　　　　　　　　＃',
    '＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃＃',
  ];
  stdin.echoMode = false;
  stdin.lineMode = false;

  stdin.listen((data) {
    String input = utf8.decode(data);
    print(input);
    // if (input == '\u001B[A') {
    final x = currentPosition[0];
    final y = currentPosition[1];

    // 用戶按下了上鍵
    if (input == 'w') {
      if (y - 1 > 0) {
        currentPosition = [x, y - 1];
      }
    }
    // 用戶按下了下鍵
    if (input == 's') {
      if (y + 1 < MAX_WIDTH - 1) {
        currentPosition = [x, y + 1];
      }
    }
    // 用戶按下了右鍵
    if (input == 'd') {
      if (x + 1 < MAX_WIDTH - 1) {
        currentPosition = [x + 1, y];
      }
    }
    // 用戶按下了左鍵
    if (input == 'a') {
      if (x - 1 > 0) {
        currentPosition = [x - 1, y];
      }
    }
  });

  runtime((count) {
    var str = '';
    for (var a = 0; a < image.length; a++) {
      for (var b = 0; b < image[a].length; b++) {
        if (currentPosition[1] == a && currentPosition[0] == b) {
          str += '\u001b[31mＰ\u001b[0m';
          // str += 'Ｐ';
        } else {
          str += image[a][b];
        }
      }
      str += '\n';
    }
    print(str);
  });
}

void runtime(void callback(int number)) async {
  var count = 0;
  while (true) {
    stdout.write("\u001b[2J\u001b[H"); // 清除命令提示字元內所有文字，並將光標移回第一行第一列
    callback(count);
    await Future.delayed(Duration(milliseconds: 10)); // 延遲 1 秒
    count++;
  }
}
