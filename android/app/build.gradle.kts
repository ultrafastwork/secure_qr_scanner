import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android") version "2.1.0"
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Load keystore properties
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

// Load local properties (including Flutter properties)
val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localProperties.load(FileInputStream(localPropertiesFile))
}

// Helper function to get Flutter properties with fallback to default values
fun getFlutterProperty(name: String, defaultValue: String): String {
    return localProperties.getProperty("flutter.$name") ?: defaultValue
}

fun getFlutterProperty(name: String, defaultValue: Int): Int {
    return localProperties.getProperty("flutter.$name")?.toIntOrNull() ?: defaultValue
}

android {
    namespace = "com.example.secure_qr_scanner"
    compileSdk = getFlutterProperty("compileSdkVersion", 36)
    ndkVersion = getFlutterProperty("ndkVersion", "29.0.14033849")

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_21
        targetCompatibility = JavaVersion.VERSION_21
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_21.toString()
    }

    defaultConfig {
        applicationId = "one.verysecure.secure_qr_scanner"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = getFlutterProperty("minSdkVersion", 24)
        targetSdk = getFlutterProperty("targetSdkVersion", 36)
        versionCode = getFlutterProperty("versionCode", 1)
        versionName = getFlutterProperty("versionName", "1.0.0")
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}
