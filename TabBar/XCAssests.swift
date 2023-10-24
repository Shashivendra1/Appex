//
//  XCAssests.swift
//  LTY_Partner
//
//  Created by Chawtech on 03/05/23.

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
    
//    internal enum Assets {
//        internal static let appLogoImage = ImageAsset(name: "Ity")
//        internal static let backArrow = ImageAsset(name: "back")
//        internal static let splashImage = ImageAsset(name: "splash_bg")
//        internal static let splashTitleImage = ImageAsset(name: "logo_white")
//        internal static let downArrow = ImageAsset(name: "down_arrow_black")
//        internal static let eyeOpen = ImageAsset(name: "eyeOpen")
//        internal static let eyeClose = ImageAsset(name: "eyeClose")
//        internal static let customer = ImageAsset(name: "customer")
//        internal static let contract = ImageAsset(name: "contract")
//        internal static let arrowUp = ImageAsset(name: "up")
//        internal static let menu = ImageAsset(name: "menu")
//
//        internal static let dashboard = ImageAsset(name: "dashboard")
//        internal static let category = ImageAsset(name: "category")
//        internal static let agents = ImageAsset(name: "agents")
//        internal static let customers = ImageAsset(name: "customer")
//        internal static let manage_Proposal = ImageAsset(name: "proposal")
//        internal static let financial_Statements = ImageAsset(name: "statement1x")
//        internal static let Select_Language = ImageAsset(name: "language")
//        internal static let letter_Managements = ImageAsset(name: "management")
//        internal static let leads = ImageAsset(name: "leads")
//        internal static let submissions = ImageAsset(name: "submission")
//        internal static let company_info = ImageAsset(name: "company_info")
//        internal static let rules_Access = ImageAsset(name: "rules")
//        internal static let search_Cover = ImageAsset(name: "search_cover")
//        internal static let message = ImageAsset(name: "message")
//        internal static let agenda = ImageAsset(name: "agenda")
//        internal static let logout = ImageAsset(name: "logout")
//        internal static let uncheckRadioImage = ImageAsset(name: "process_green")
//        internal static let checkRadioImage = ImageAsset(name: "process_active")
//
//
//        // internal static let emailImage = ImageAsset(name: "EmailImage")
//
//    }
    /*
     F3F4F6 = grayColor
     #374151 = darkGray
     #1F2937 = gray1
     6B7180 = gray2
     #111727 = lightBlack
     4A5462 = lightGray
     5FB899 = lightGreen
     #FF8063 = lightOrange
     #C1C5E4 = lightSkyBlue
     6AB3FF = skyBlue
     #E4F2FF = lightSkyBlue
     #3A86FF = blueColor
     BEDEFF = mediumSkybluColor
     EFE8FF =  lightPurple
     #D3C6FE = meduimPurpleColor
     E11900 = redColor
     #05A357 = greenColor
     #F9FAFB = medimWhite
     #f5f5f5f = backGroundColor
     */
    internal enum Colors {
    internal static let appColor2 = ColorAsset(name: "AppColor2")
//        internal static let gray1 = ColorAsset(name: "gray1")
//        internal static let skyBlue = ColorAsset(name: "skyBlue")
//        internal static let whiteColor = ColorAsset(name: "white")
//        internal static let grayColor = ColorAsset(name: "grayColor")
//        internal static let lightGray = ColorAsset(name: "lightGray")
//        internal static let lightBlue = ColorAsset(name: "lightBlue")
//        internal static let lightGreen = ColorAsset(name: "lightGreen")
//        internal static let darkGrayColor = ColorAsset(name: "darkGray")
//        internal static let lightOrange = ColorAsset(name: "lightOrange")
//        internal static let lightBlack = ColorAsset(name: "lightBlack")
//        internal static let lightSkyBlue = ColorAsset(name: "lightSkyBlue")
//        internal static let blueColor = ColorAsset(name: "blueColor")
//        internal static let mediumSkybluColor = ColorAsset(name: "mediumSkybluColor")
//        internal static let lightPurple = ColorAsset(name: "lightPurple")
//        internal static let meduimPurpleColor = ColorAsset(name: "meduimPurpleColor")
//        internal static let redColor = ColorAsset(name: "redColor")
//        internal static let greenColor = ColorAsset(name: "greenColor")
//        internal static let mediumWhite = ColorAsset(name: "mediumWhite")
//        internal static let blackColor = ColorAsset(name: "blackColor")
//        internal static let backGroundColor = ColorAsset(name: "backGroundColor")

    }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
