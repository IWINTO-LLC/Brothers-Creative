import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// The current language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// No description provided for @changedTo.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get changedTo;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @brotherCreative.
  ///
  /// In en, this message translates to:
  /// **'Brothers Creative'**
  String get brotherCreative;

  /// No description provided for @welcomeToBro.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Brothers Creative'**
  String get welcomeToBro;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'if you want to add orders or request for project you have to Register and join our family to injoy with our services , or if you hav an account you can simply login'**
  String get welcomeMessage;

  /// No description provided for @choose.
  ///
  /// In en, this message translates to:
  /// **'Qui mollit aliquip enim ex elit eu nulla nisi aliquip anim nisi.'**
  String get choose;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @offers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offers;

  /// No description provided for @viewCart.
  ///
  /// In en, this message translates to:
  /// **'View Cart'**
  String get viewCart;

  /// No description provided for @continuAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continu as guest'**
  String get continuAsGuest;

  /// No description provided for @reAuthenticate.
  ///
  /// In en, this message translates to:
  /// **'Reauthenticate account'**
  String get reAuthenticate;

  /// No description provided for @albumMessage.
  ///
  /// In en, this message translates to:
  /// **'From Here Explore our magic works'**
  String get albumMessage;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Ipsum cillum labore anim exercitation.'**
  String get onboardingTitle1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Select elegant decoration'**
  String get onboardingTitle2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'sunt occaecat cillum anim.'**
  String get onboardingTitle3;

  /// No description provided for @priceRequestMessage.
  ///
  /// In en, this message translates to:
  /// **'Here you can send a request for the price of any design you may want to do'**
  String get priceRequestMessage;

  /// No description provided for @workType.
  ///
  /// In en, this message translates to:
  /// **'Work Type /Project name'**
  String get workType;

  /// No description provided for @blogMessage.
  ///
  /// In en, this message translates to:
  /// **'From here, follow our news and latest completed projects  '**
  String get blogMessage;

  /// No description provided for @offersMessage.
  ///
  /// In en, this message translates to:
  /// **'From here, check the latest offers and discounts on the prices of our products'**
  String get offersMessage;

  /// No description provided for @onboardingSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'Nulla laborum nostrud aliqua ex enim aliqua esse nisi ex pariatur labore culpa sit est.'**
  String get onboardingSubtitle1;

  /// No description provided for @onboardingSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'Pariatur idNulla exercitation aliqua velit do eiusmod do ipsum ut nostrud dolor anim consequat excepteur. id sint non Lorem.'**
  String get onboardingSubtitle2;

  /// No description provided for @onboardingSubtitle3.
  ///
  /// In en, this message translates to:
  /// **'Aliqua irure voluptate consequat mollit id irure est consectetur aute duis qui velit occaecat.'**
  String get onboardingSubtitle3;

  /// No description provided for @priceRequestText.
  ///
  /// In en, this message translates to:
  /// **'Here you can send a request for the price of any design you may want to do for your home, office or garden. Just attach an illustration or pictures and wait for a response soon..'**
  String get priceRequestText;

  /// No description provided for @addPriceRequest.
  ///
  /// In en, this message translates to:
  /// **'Add New Price Request'**
  String get addPriceRequest;

  /// No description provided for @mainpage.
  ///
  /// In en, this message translates to:
  /// **'Main Page'**
  String get mainpage;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @someOfWork.
  ///
  /// In en, this message translates to:
  /// **'Some of our work for'**
  String get someOfWork;

  /// No description provided for @wellcomtoBrother.
  ///
  /// In en, this message translates to:
  /// **'Wellcom to Brother'**
  String get wellcomtoBrother;

  /// No description provided for @ifyouwanttoAddOrdersOrProjectMessage.
  ///
  /// In en, this message translates to:
  /// **'if you want to add orders or request for project you have to Register and join our family to injoy with our services , or if you hav an account you can simply login'**
  String get ifyouwanttoAddOrdersOrProjectMessage;

  /// No description provided for @store.
  ///
  /// In en, this message translates to:
  /// **'Store'**
  String get store;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @blog.
  ///
  /// In en, this message translates to:
  /// **'Blog'**
  String get blog;

  /// No description provided for @noNewsuntilNow.
  ///
  /// In en, this message translates to:
  /// **'No News until now'**
  String get noNewsuntilNow;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get account;

  /// No description provided for @priceRequest.
  ///
  /// In en, this message translates to:
  /// **'Request for Price'**
  String get priceRequest;

  /// No description provided for @priceRequests.
  ///
  /// In en, this message translates to:
  /// **'Price Request'**
  String get priceRequests;

  /// No description provided for @interviewRequest.
  ///
  /// In en, this message translates to:
  /// **'Request for interview'**
  String get interviewRequest;

  /// No description provided for @lookNews.
  ///
  /// In en, this message translates to:
  /// **'look at our news'**
  String get lookNews;

  /// No description provided for @offersChick.
  ///
  /// In en, this message translates to:
  /// **'check out our offers'**
  String get offersChick;

  /// No description provided for @goodDay.
  ///
  /// In en, this message translates to:
  /// **'Good day for shopping'**
  String get goodDay;

  /// No description provided for @addProject.
  ///
  /// In en, this message translates to:
  /// **'Add Project'**
  String get addProject;

  /// No description provided for @projectName.
  ///
  /// In en, this message translates to:
  /// **'Project Name'**
  String get projectName;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @yourCompany.
  ///
  /// In en, this message translates to:
  /// **'Your Company'**
  String get yourCompany;

  /// No description provided for @yourAddress.
  ///
  /// In en, this message translates to:
  /// **'Your Address'**
  String get yourAddress;

  /// No description provided for @projectInfo.
  ///
  /// In en, this message translates to:
  /// **'Project Information'**
  String get projectInfo;

  /// No description provided for @addPayAmount.
  ///
  /// In en, this message translates to:
  /// **'Add pay amount'**
  String get addPayAmount;

  /// No description provided for @addProjectMessage.
  ///
  /// In en, this message translates to:
  /// **'you can Request for new Project or decoration'**
  String get addProjectMessage;

  /// No description provided for @project.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get project;

  /// No description provided for @complationRate.
  ///
  /// In en, this message translates to:
  /// **'Completion Rate'**
  String get complationRate;

  /// No description provided for @paymentRate.
  ///
  /// In en, this message translates to:
  /// **'Payment Rate'**
  String get paymentRate;

  /// No description provided for @noProjectyet.
  ///
  /// In en, this message translates to:
  /// **'No Project yet'**
  String get noProjectyet;

  /// No description provided for @letusRequestForNewProject.
  ///
  /// In en, this message translates to:
  /// **'let us request for a new project ..'**
  String get letusRequestForNewProject;

  /// No description provided for @unComplete.
  ///
  /// In en, this message translates to:
  /// **'un complete'**
  String get unComplete;

  /// No description provided for @youAlmostWillFinishThePaymentAmounts.
  ///
  /// In en, this message translates to:
  /// **'You almost will finish the payment amounts'**
  String get youAlmostWillFinishThePaymentAmounts;

  /// No description provided for @deliveryLocationForOffFactorySite.
  ///
  /// In en, this message translates to:
  /// **'Delivery location for off factory site'**
  String get deliveryLocationForOffFactorySite;

  /// No description provided for @paymentForProject.
  ///
  /// In en, this message translates to:
  /// **'Payment For Project'**
  String get paymentForProject;

  /// No description provided for @projectLocation.
  ///
  /// In en, this message translates to:
  /// **'Project Location'**
  String get projectLocation;

  /// No description provided for @estimatedDate.
  ///
  /// In en, this message translates to:
  /// **'Estimated Date'**
  String get estimatedDate;

  /// No description provided for @workDetails.
  ///
  /// In en, this message translates to:
  /// **'Work Details'**
  String get workDetails;

  /// No description provided for @kindlySelectTheAppropriate.
  ///
  /// In en, this message translates to:
  /// **'Kindly select the appropriate option that best describes your work or project requirements'**
  String get kindlySelectTheAppropriate;

  /// No description provided for @descriptionOfProject.
  ///
  /// In en, this message translates to:
  /// **'Description of Project (Explaination), Shape, Dimensions, Color, Decoration, Structural Engineering, Your Vision.'**
  String get descriptionOfProject;

  /// No description provided for @provideUsWithProductionBlueprints.
  ///
  /// In en, this message translates to:
  /// **'Provide us with Production blueprints or genuine samples. Please choose one:'**
  String get provideUsWithProductionBlueprints;

  /// No description provided for @providedExample.
  ///
  /// In en, this message translates to:
  /// **'Provided example'**
  String get providedExample;

  /// No description provided for @fileViaEmail.
  ///
  /// In en, this message translates to:
  /// **'File via email'**
  String get fileViaEmail;

  /// No description provided for @notPresent.
  ///
  /// In en, this message translates to:
  /// **'Not present'**
  String get notPresent;

  /// No description provided for @workTypeOrProjectCategory.
  ///
  /// In en, this message translates to:
  /// **'Work Type or project category. Please choose one:'**
  String get workTypeOrProjectCategory;

  /// No description provided for @both.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get both;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @uploadImages.
  ///
  /// In en, this message translates to:
  /// **'upload Images'**
  String get uploadImages;

  /// No description provided for @addImages.
  ///
  /// In en, this message translates to:
  /// **'Add Images'**
  String get addImages;

  /// No description provided for @totalImages.
  ///
  /// In en, this message translates to:
  /// **' Total images : '**
  String get totalImages;

  /// No description provided for @totalFiles.
  ///
  /// In en, this message translates to:
  /// **'Total Files : '**
  String get totalFiles;

  /// No description provided for @requestForPriceSendSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Request for price send successfully'**
  String get requestForPriceSendSuccessfully;

  /// No description provided for @attachFile.
  ///
  /// In en, this message translates to:
  /// **'Attach file'**
  String get attachFile;

  /// No description provided for @conformationAcception.
  ///
  /// In en, this message translates to:
  /// **'I affirm my careful consideration of this Forms’ contents, and my complete understanding of attached Contract Terms and Rights by Brothers Creative.'**
  String get conformationAcception;

  /// No description provided for @uploadYourFilesEasily.
  ///
  /// In en, this message translates to:
  /// **'Upload your files easily: PDFs, JPGs, PNGs, AI, EPS, SVG, DXF, DWG, and more. Perfect for sharing designs, 3D models, illustrations, and technical drawings.'**
  String get uploadYourFilesEasily;

  /// No description provided for @kindlyLogistic.
  ///
  /// In en, this message translates to:
  /// **'Kindly indicate any additional requirements or services necessary for the work or on the project site, such asL Energu and Utilities, Technology Integrated, Living Elements, Logistic Operations etc.'**
  String get kindlyLogistic;

  /// No description provided for @additionalConsiderations.
  ///
  /// In en, this message translates to:
  /// **'ADDITIONAL CONSIDERATIONS'**
  String get additionalConsiderations;

  /// No description provided for @proposedPriceInclvat.
  ///
  /// In en, this message translates to:
  /// **'Proposed Price(incl. VAT):'**
  String get proposedPriceInclvat;

  /// No description provided for @uniteQuantity.
  ///
  /// In en, this message translates to:
  /// **'Unite/Quantity:'**
  String get uniteQuantity;

  /// No description provided for @notRequired.
  ///
  /// In en, this message translates to:
  /// **'Not required'**
  String get notRequired;

  /// No description provided for @dismantling.
  ///
  /// In en, this message translates to:
  /// **'Dismantling'**
  String get dismantling;

  /// No description provided for @installation.
  ///
  /// In en, this message translates to:
  /// **'Installation'**
  String get installation;

  /// No description provided for @dontknow.
  ///
  /// In en, this message translates to:
  /// **'Don’t know'**
  String get dontknow;

  /// No description provided for @interior.
  ///
  /// In en, this message translates to:
  /// **'Interior'**
  String get interior;

  /// No description provided for @exterior.
  ///
  /// In en, this message translates to:
  /// **'Exterior'**
  String get exterior;

  /// No description provided for @involvesAssemblyAndDismantling.
  ///
  /// In en, this message translates to:
  /// **'Involves Assembly and Dismantling? Please select one:'**
  String get involvesAssemblyAndDismantling;

  /// No description provided for @selectProjectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Project Category'**
  String get selectProjectCategory;

  /// No description provided for @projectTitle.
  ///
  /// In en, this message translates to:
  /// **'Project Title : '**
  String get projectTitle;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @planing.
  ///
  /// In en, this message translates to:
  /// **'Planing'**
  String get planing;

  /// No description provided for @process.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get process;

  /// No description provided for @delevering.
  ///
  /// In en, this message translates to:
  /// **'Finishing'**
  String get delevering;

  /// No description provided for @popularCategory.
  ///
  /// In en, this message translates to:
  /// **'Popular Categories'**
  String get popularCategory;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @popularProduct.
  ///
  /// In en, this message translates to:
  /// **'Popular Product'**
  String get popularProduct;

  /// No description provided for @woodChair.
  ///
  /// In en, this message translates to:
  /// **'Salon chair with wood legs'**
  String get woodChair;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add To Cart'**
  String get addToCart;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @myAddresses.
  ///
  /// In en, this message translates to:
  /// **'My Addresses'**
  String get myAddresses;

  /// No description provided for @myCart.
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get myCart;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @wishList.
  ///
  /// In en, this message translates to:
  /// **'Wish List'**
  String get wishList;

  /// No description provided for @wishlistIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Whoops! Wishlist is empty ...'**
  String get wishlistIsEmpty;

  /// No description provided for @myProjects.
  ///
  /// In en, this message translates to:
  /// **'My Projects'**
  String get myProjects;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @accountPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Account Privacy'**
  String get accountPrivacy;

  /// No description provided for @loadDate.
  ///
  /// In en, this message translates to:
  /// **'Load Data'**
  String get loadDate;

  /// No description provided for @languageSetting.
  ///
  /// In en, this message translates to:
  /// **'Language Setting'**
  String get languageSetting;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get chooseLanguage;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Setting'**
  String get appSettings;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mood'**
  String get darkMode;

  /// No description provided for @storeSearch.
  ///
  /// In en, this message translates to:
  /// **'Search in Store'**
  String get storeSearch;

  /// No description provided for @featureBrands.
  ///
  /// In en, this message translates to:
  /// **'Our Partners'**
  String get featureBrands;

  /// No description provided for @youMightLike.
  ///
  /// In en, this message translates to:
  /// **'You might like'**
  String get youMightLike;

  /// No description provided for @searchinGallery.
  ///
  /// In en, this message translates to:
  /// **'Search in Gallery'**
  String get searchinGallery;

  /// No description provided for @searchResults.
  ///
  /// In en, this message translates to:
  /// **'Search Results'**
  String get searchResults;

  /// No description provided for @searchProducts.
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get searchProducts;

  /// No description provided for @searching.
  ///
  /// In en, this message translates to:
  /// **'Searching...'**
  String get searching;

  /// No description provided for @searchForProducts.
  ///
  /// In en, this message translates to:
  /// **'Search for products'**
  String get searchForProducts;

  /// No description provided for @searchFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Type in the search field above to find products'**
  String get searchFieldHint;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get noProductsFound;

  /// No description provided for @tryDifferentKeywords.
  ///
  /// In en, this message translates to:
  /// **'Try different keywords'**
  String get tryDifferentKeywords;

  /// No description provided for @searchedFor.
  ///
  /// In en, this message translates to:
  /// **'Searched for: "{query}"'**
  String searchedFor(String query);

  /// No description provided for @foundProducts.
  ///
  /// In en, this message translates to:
  /// **'Found {count} products for "{query}"'**
  String foundProducts(int count, String query);

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @resultsFound.
  ///
  /// In en, this message translates to:
  /// **'{count} result{count, plural, =1 {} other {s}} found'**
  String resultsFound(int count);

  /// No description provided for @artPaces.
  ///
  /// In en, this message translates to:
  /// **'Pieces of Art'**
  String get artPaces;

  /// No description provided for @checkoutWithPrice.
  ///
  /// In en, this message translates to:
  /// **'Checkout {price}'**
  String checkoutWithPrice(String price);

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @reviewsWithNum.
  ///
  /// In en, this message translates to:
  /// **'Reviews {num}'**
  String reviewsWithNum(String num);

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @iHaveAcount.
  ///
  /// In en, this message translates to:
  /// **'I have an account'**
  String get iHaveAcount;

  /// No description provided for @iDontHaveAcount.
  ///
  /// In en, this message translates to:
  /// **'I don\'t have an account'**
  String get iDontHaveAcount;

  /// No description provided for @changeProfilePicture.
  ///
  /// In en, this message translates to:
  /// **'change profile picture'**
  String get changeProfilePicture;

  /// No description provided for @profileInformation.
  ///
  /// In en, this message translates to:
  /// **'Profile Information'**
  String get profileInformation;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userName;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @userId.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get userId;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @phoneNumbers.
  ///
  /// In en, this message translates to:
  /// **'Phone Numbers'**
  String get phoneNumbers;

  /// No description provided for @closeAccount.
  ///
  /// In en, this message translates to:
  /// **'Close Account'**
  String get closeAccount;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show More'**
  String get showMore;

  /// No description provided for @less.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get less;

  /// No description provided for @descriptions.
  ///
  /// In en, this message translates to:
  /// **'Descriptions'**
  String get descriptions;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get noData;

  /// No description provided for @brands.
  ///
  /// In en, this message translates to:
  /// **'Partners'**
  String get brands;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Partner'**
  String get brand;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something Went Wrong.'**
  String get somethingWentWrong;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @clients.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get clients;

  /// No description provided for @client.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get client;

  /// No description provided for @storingAddress.
  ///
  /// In en, this message translates to:
  /// **'Storing Address .....'**
  String get storingAddress;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get addNewAddress;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'phoneNumber is Required'**
  String get phoneRequired;

  /// No description provided for @street.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get street;

  /// No description provided for @buildNum.
  ///
  /// In en, this message translates to:
  /// **'Building Number'**
  String get buildNum;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @floor.
  ///
  /// In en, this message translates to:
  /// **'Floor'**
  String get floor;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @someOfOurWork.
  ///
  /// In en, this message translates to:
  /// **'Some of our works'**
  String get someOfOurWork;

  /// No description provided for @letsFillIt.
  ///
  /// In en, this message translates to:
  /// **'Let\'s fill it'**
  String get letsFillIt;

  /// No description provided for @cartIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Whoops! cart is empty'**
  String get cartIsEmpty;

  /// No description provided for @exitApp.
  ///
  /// In en, this message translates to:
  /// **'Exit app'**
  String get exitApp;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @doYouWantToExit.
  ///
  /// In en, this message translates to:
  /// **'Do you want to exit'**
  String get doYouWantToExit;

  /// No description provided for @changeName.
  ///
  /// In en, this message translates to:
  /// **'Change Name'**
  String get changeName;

  /// No description provided for @weAreUpdating.
  ///
  /// In en, this message translates to:
  /// **'We are updateing your information ...'**
  String get weAreUpdating;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @congratulation.
  ///
  /// In en, this message translates to:
  /// **'Congratulation'**
  String get congratulation;

  /// No description provided for @nameChange.
  ///
  /// In en, this message translates to:
  /// **'Your name has been updated'**
  String get nameChange;

  /// No description provided for @saveAddressMessage.
  ///
  /// In en, this message translates to:
  /// **'Your address has been saved successfully'**
  String get saveAddressMessage;

  /// No description provided for @saveProjectMessage.
  ///
  /// In en, this message translates to:
  /// **'Your project request has been send successfully'**
  String get saveProjectMessage;

  /// No description provided for @changeNameMessage.
  ///
  /// In en, this message translates to:
  /// **'Use real name for easy verification. this name will appear on several pages'**
  String get changeNameMessage;

  /// No description provided for @successfullyAddedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Successfully added to Favorites'**
  String get successfullyAddedToFavorites;

  /// No description provided for @successfullyAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'Successfully added to Cart'**
  String get successfullyAddedToCart;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @productHasBeenRemoved.
  ///
  /// In en, this message translates to:
  /// **'Product has been removed from the Wishlist.'**
  String get productHasBeenRemoved;

  /// No description provided for @productHasBeenRemovedFromCart.
  ///
  /// In en, this message translates to:
  /// **'Product has been removed from the Cart.'**
  String get productHasBeenRemovedFromCart;

  /// No description provided for @selectPaymentMethode.
  ///
  /// In en, this message translates to:
  /// **'Select Payment method'**
  String get selectPaymentMethode;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @shippingAddress.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shippingAddress;

  /// No description provided for @selectAddress.
  ///
  /// In en, this message translates to:
  /// **'Select Address'**
  String get selectAddress;

  /// No description provided for @deliverd.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get deliverd;

  /// No description provided for @shipmentInWay.
  ///
  /// In en, this message translates to:
  /// **'Shippment in way'**
  String get shipmentInWay;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing....'**
  String get processing;

  /// No description provided for @paymentSuccessfull.
  ///
  /// In en, this message translates to:
  /// **'Payment Successfull'**
  String get paymentSuccessfull;

  /// No description provided for @yourItemWillBeShippingSoon.
  ///
  /// In en, this message translates to:
  /// **'Your Item will be shipping soon!'**
  String get yourItemWillBeShippingSoon;

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Cart Empty'**
  String get cartEmpty;

  /// No description provided for @addItemTotheCartForOrderProcess.
  ///
  /// In en, this message translates to:
  /// **'Add items in the cart in order to proceed'**
  String get addItemTotheCartForOrderProcess;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @shippingDate.
  ///
  /// In en, this message translates to:
  /// **'Shipping Date'**
  String get shippingDate;

  /// No description provided for @termsCondition.
  ///
  /// In en, this message translates to:
  /// **'Terms Condition'**
  String get termsCondition;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @cancelPolicy.
  ///
  /// In en, this message translates to:
  /// **'Cancellation Policy'**
  String get cancelPolicy;

  /// No description provided for @returnPolicy.
  ///
  /// In en, this message translates to:
  /// **'Return Policy'**
  String get returnPolicy;

  /// No description provided for @chooseYourPrightness.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Brightness'**
  String get chooseYourPrightness;

  /// No description provided for @chooseYourLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Your Language'**
  String get chooseYourLanguage;

  /// No description provided for @wishlistSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Here you can find your favorite products'**
  String get wishlistSubTitle;

  /// No description provided for @laterList.
  ///
  /// In en, this message translates to:
  /// **'For Later List'**
  String get laterList;

  /// No description provided for @saveForLater.
  ///
  /// In en, this message translates to:
  /// **'Save For Later'**
  String get saveForLater;

  /// No description provided for @ordersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Here you can find all previose orders'**
  String get ordersSubtitle;

  /// No description provided for @cartSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add, remove products and move to chickout'**
  String get cartSubtitle;

  /// No description provided for @addressSubtile.
  ///
  /// In en, this message translates to:
  /// **'Set Delivery address'**
  String get addressSubtile;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @letsCompliteYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Let \'s complite your account'**
  String get letsCompliteYourAccount;

  /// No description provided for @iAgreeTo.
  ///
  /// In en, this message translates to:
  /// **'I agree to'**
  String get iAgreeTo;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @orSignUpWith.
  ///
  /// In en, this message translates to:
  /// **'Or Sign Up With'**
  String get orSignUpWith;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @acceptPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Accept Privacy Policy'**
  String get acceptPrivacyPolicy;

  /// No description provided for @policyMessage.
  ///
  /// In en, this message translates to:
  /// **'In Order to create account ,you must have to read and accept the Privacy Policy and terms of use'**
  String get policyMessage;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get noInternetConnection;

  /// No description provided for @pleaseSelectQuantity.
  ///
  /// In en, this message translates to:
  /// **'Please Select Quantity'**
  String get pleaseSelectQuantity;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @yourAccountCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'Your account created Successfully'**
  String get yourAccountCreateTitle;

  /// No description provided for @yourAccountCreateSubTitle.
  ///
  /// In en, this message translates to:
  /// **'Quis esse Lorem eiusmod excepteur ad aute sint.'**
  String get yourAccountCreateSubTitle;

  /// No description provided for @continu.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continu;

  /// No description provided for @resendEmail.
  ///
  /// In en, this message translates to:
  /// **'Resend Email'**
  String get resendEmail;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @loggingOut.
  ///
  /// In en, this message translates to:
  /// **'Logging out...'**
  String get loggingOut;

  /// No description provided for @seeYouLater.
  ///
  /// In en, this message translates to:
  /// **'See you later'**
  String get seeYouLater;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @wellcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Wellcome back'**
  String get wellcomeBack;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed premanently.'**
  String get deleteAccountWarning;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternet;

  /// No description provided for @pleaseCheckConnection.
  ///
  /// In en, this message translates to:
  /// **'Please check your network connection'**
  String get pleaseCheckConnection;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected to the internet'**
  String get connected;

  /// No description provided for @connectionRestored.
  ///
  /// In en, this message translates to:
  /// **'Connection restored successfully'**
  String get connectionRestored;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
