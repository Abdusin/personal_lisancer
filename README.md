<!-- DO NOT REMOVE - contributor_list:data:start:["Matt-Gleich", "lig", "bartekpacia", "ImgBotApp", "jlnrrg", "vHanda"]:end -->

### Personal Lisancer

π― Dart package to automatically add lisance detail to your dart files. Any dart project supported!

Below is an example:

### Before

```dart
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:example_app/anotherFile2.dart';
```

### After

```dart
//! @Lisanced
//! ************************************
//! Project Name : example
//! Author : Abdus Δ°nanΓ§
//! Email : abdusinanc@gmail.com
//! Author Note: Flutter Best
//! Lisance At 26-7-2021
//! ************************************

import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:example_app/anotherFile2.dart';
```

## π Installing

Simply add `personal_lisancer: ^0.0.1` to your `pubspec.yaml`'s `dev_dependencies`.

## πββοΈ Running

Once you've installed it simply run `flutter pub run personal_lisancer:main` (`pub run personal_lisancer:main` if normal dart application) to format every file dart file in your lib, bin, test, and tests folder! Don't worry if these folders don't exist.

## π» Command Line

- Maybe Later π.

## ποΈ Config


```yaml
personal_lisancer:
  name: 'Abdus Inanc'
  email: 'abdusinanc@gmail.com'
  note: 'Flutter π' #Default is null
  title: 'Author' #Default is 'Developer'
```

## πββοΈπββοΈ Contributing

All contributions are welcome! Just make sure that it's not an already existing issue or pull request.

<!-- DO NOT REMOVE - contributor_list:start -->

## π₯ Contributors

- **[@Abdusin](https://github.com/abdusin)**

<!-- DO NOT REMOVE - contributor_list:end -->
