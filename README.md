---
title: 'First project on flutter framework'
disqus: hackmd
---

Closet_Flutter
===

## Table of Contents

[TOC]

What is Flutter?
---

Flutter是一種能建立原生跨平台的框架，用一種程式語言(dart)寫一個project能同時讓iOS和Android平台使用，也支援Web以及桌面應用程式。Flutter因擁有豐富且方便的元件(widget)以及優秀的性能，目前正在快速發展。

What is Dart?
---

Dart是Google開發的程式語言，主要針對前端介面開發所使用的程式語言(mobile apps, web)

Dart屬於物件導向語言，語法結合了javascript、java、c#的特性，基本上只要有程式基礎要上手是非常容易的。

Relation between Flutter and Dart
---

Flutter是一種框架(內含許多專用的Library、widget)，而Dart則是程式語言，有點像Python與Django的關係。

How to download Flutter SDK
---

### 方法1

1. [Install Git for your OS](https://git-scm.com/download/win)
2. 於C槽點擊右鍵並選擇"Git bash here"
3. 輸入`git clone -b stable https://github.com/flutter/flutter.git`

### 方法2

1. [下載最新版本的Flutter](https://flutter.dev/docs/development/tools/sdk/releases)
2. 解壓縮至C槽

Flutter 專案架構
---

* `android`: 用來建立 Android App。而且，如果你需要添加 Android 特定的功能時，就會在這裡進行實作。
* `assets`: 用來儲存圖形、資料檔案等。
* `ios`: 用來建立 iOS App。而且，如果你需要添加 iOS 特定的功能時，就會在這裡進行實作。
* `lib`: 包含了 App 的主程式碼。稍後，你會看到我們在這裡建立所有程式碼檔案。
* `test`: 用來做 Unit Testing，不過我們不會在這篇教學詳述這部分。
* `pubspec.yaml`: 專案設定檔，包含引用其他套件的設定是寫在這個檔案內

Hot Reload
---
意旨不須重新啟動模擬器即可更動。

VScode: 進入`lib/main.dart`按`F5`即可以執行程式
更改程式後儲存，即可在模擬器上看到改變。

Q&A
---

* Q1: Normalize正規化mean std數值。
* A1: mean=(0.485, 0.456, 0.406), std=(0.229, 0.224, 0.225)，若使用0.5會使MAGAN訓練產出模糊圖像。
* Q2: 資料集正負比例差距過大。
* A2: 訓練失敗，網絡會太過專注於例子較多的case。
* Q3: 如何得到Crop_size。
* A3: 經過測試輸出圖像，使crop center能夠刪除最多背景圖。
* Q4: Image_siez大小如何決定。
* A4: 根據[Pytorch finetuning](https://pytorch.org/tutorials/beginner/finetuning_torchvision_models_tutorial.html)實驗結果決定使用224。

###### tags: `Attribute discriminator` `Image classification`
