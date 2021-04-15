// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// # James DEV
///
///
/// ## C interop using dart:ffi
/// (Dart Doc : https://dart.dev/guides/libraries/c-interop)
///
/// ## MacOS / 경로는 dart 파일 위치부터
///
///
/// - cmake 설치(make 는 내장)
///   > brew install cmake
///
/// - 빌드
///   > cd ./hello_library
///   > cmake .
///   > make
///
/// - 실행
///   > cd ..
///    * 경로 : hello.dart 파일 위치한 폴더
///   > dart pub get
///    * pub get 동작했지만 패키지 오류가 지속적으로 발생하는 경우 IDE 재시작
///   > dart run hello.dart
///
/// - 출력
/// Hello World

import 'dart:ffi' as ffi;
import 'dart:io' show Platform, Directory;
import 'package:path/path.dart' as path;

typedef hello_world_func = ffi.Void Function();
typedef HelloWorld = void Function();

main() {
  var libraryPath = path.join(Directory.current.path, 'hello_library', 'libhello.so');
  if (Platform.isMacOS) libraryPath = path.join(Directory.current.path, 'hello_library', 'libhello.dylib');
  if (Platform.isWindows) libraryPath = path.join(Directory.current.path, 'hello_library', 'Debug', 'hello.dll');

  final dylib = ffi.DynamicLibrary.open(libraryPath);
  final HelloWorld hello = dylib.lookup<ffi.NativeFunction<hello_world_func>>('hello_world').asFunction();
  hello();
}
