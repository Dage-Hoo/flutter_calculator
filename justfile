default: gen lint

gen:
    flutter pub get
    flutter_rust_bridge_codegen

lint:
    cd native && cargo fmt
    dart format .

clean:
    flutter clean
    cd native && cargo clean

build:
    flutter build apk
    flutter build ios

sign:
    $ANDROID_HOME/build-tools/30.0.3/zipalign -v 4 /Users/dagehoo/Desktop/flutter_rust_bridge_template/build/app/outputs/apk/release/app-release.apk  /Users/dagehoo/Desktop/flutter_rust_bridge_template/build/app/outputs/apk/release/app_release_aligned.apk
    $ANDROID_HOME/build-tools/30.0.3/apksigner sign --ks ~/dagehoo.keystore --ks-key-alias dagehoo --out /Users/dagehoo/Desktop/flutter_rust_bridge_template/build/app/outputs/apk/release/app_release_signed.apk /Users/dagehoo/Desktop/flutter_rust_bridge_template/build/app/outputs/apk/release/app_release_aligned.apk

serve *args='':
    flutter pub run flutter_rust_bridge:serve {{args}}

# vim:expandtab:sw=4:ts=4
