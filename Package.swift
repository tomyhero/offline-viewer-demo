import PackageDescription

let package = Package(
    name: "OffViewer",
    targets: [
        Target(name: "App"),
        Target(name: "Run", dependencies: ["App"]),
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
        .Package(url: "https://github.com/vapor/fluent-provider.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/leaf-provider.git", majorVersion: 1),
        //.Package(url: "https://github.com/vapor/mysql-provider.git", majorVersion: 2),
        //.Package(url: "https://github.com/vapor-community/forms.git", majorVersion: 1), // vapor2対応版が現在未完成なので利用できない beta...
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
    ]
)

