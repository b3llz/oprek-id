name: Build Android Release

on:
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Setup Java
        uses: actions/setup-java@v4
        with:
          distribution: 'zulu'
          java-version: '17'

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.22.2'
          channel: 'stable'

      - name: Generate Android Chassis (Aman)
        run: |
          # Amankan file asli kita
          cp pubspec.yaml pubspec_aman.yaml
          cp lib/main.dart main_aman.dart
          # Bikin folder android
          flutter create --org id.oprek --project-name oprek_id --platforms=android .
          # Kembalikan file asli kita
          mv pubspec_aman.yaml pubspec.yaml
          mv main_aman.dart lib/main.dart

      - name: Get Dependencies
        run: flutter pub get

      - name: Build APK
        run: flutter build apk --release

      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: oprek-id-release-apk
          path: build/app/outputs/flutter-apk/app-release.apk


