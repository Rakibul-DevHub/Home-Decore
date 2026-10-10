# Home Decore Codebase Architecture & Technical Review

> **Document Name:** `readmetoknow.md`  
> **Project:** Home Decore (Mobile Art Marketplace & Social Platform)  
> **Framework:** Flutter / Dart (SDK `^3.12.1`)  
> **State Management:** Flutter BLoC / Cubit  
> **Date of Review:** October 2026  

---

## 1. Executive Summary

**Home Decore** is a mobile art marketplace and social commerce application built with Flutter. The platform bridges contemporary visual artists, collectors, and art enthusiasts. It combines social discovery features (art feed, nested comments, likes, sharing) with an e-commerce marketplace (curated artwork discovery, detailed filters, product bidding, direct purchases, cart management, and multi-step seller product listings).

The codebase demonstrates clear modular structure, adopting a **feature-first** organization pattern where each screen encapsulates its own business logic (`bloc`), presentation layer (`view`), and mock/remote data models (`data`).

---

## 2. Directory & Folder Structure

```
Home Decore/
├── .cursor/                         # Cursor IDE configurations
├── .idea/                           # Android Studio / IntelliJ IDEA settings
├── android/                         # Android platform-specific native project
│   ├── app/
│   │   └── src/main/kotlin/.../     # Native MainActivity.kt (WindowInsets controller)
│   └── build.gradle                 # Android build configurations
├── ios/                             # iOS platform-specific project configuration
├── assets/                          # Static assets and media
│   ├── font/                        # Custom font binaries
│   │   ├── GeneralSans-*.otf        # General Sans font variants (Regular, Medium, Semibold)
│   │   └── IBMPlexMono-*.ttf        # IBM Plex Mono typography
│   ├── icons/                       # 35+ Vector icons (SVG format)
│   └── images/                      # High-resolution raster images (PNG mock artworks & avatars)
├── lib/                             # Core Flutter application source code
│   ├── core/                        # Shared application foundation
│   │   └── network/                 # Networking, storage, and file upload infrastructure
│   │       ├── image/               # Multi-part image upload Cubit & service
│   │       ├── auth_session.dart    # Session tokens & authentication state model
│   │       ├── network_caller_dio.dart # Dio client with interceptors & HTTP methods
│   │       ├── network_response_dio.dart # Standardized API response model
│   │       ├── secure_storage_service.dart # FlutterSecureStorage wrapper
│   │       └── network.dart         # Barrel export file for core network services
│   ├── routes/                      # Route management and navigation table
│   │   ├── app_route.dart           # Alias and export barrel
│   │   └── app_routes.dart          # Centralized named routes registry and builders
│   ├── screens/                     # Feature modules (32 distinct feature directories)
│   │   ├── about/                   # About app, version, and company details
│   │   ├── account_information/     # Sensitive user credentials & account settings
│   │   ├── appearance/              # Theme picker & active appearance configuration
│   │   ├── auth/                    # Authentication workflows
│   │   │   ├── create_account/      # User registration form & validation
│   │   │   ├── forgot_password/     # Password reset request
│   │   │   ├── new_password/        # Password renewal form
│   │   │   ├── otp_verification/    # One-Time Password verification
│   │   │   ├── set_password/        # Initial password setup
│   │   │   └── welcome/             # Sign-in screen & social authentication
│   │   ├── bids_menu/               # User bids, auction offers, and statuses
│   │   ├── blocked_accounts/        # Blocked users list and moderation
│   │   ├── cart/                    # Shopping cart & checkout staging
│   │   ├── create/                  # Create hub (Post vs. List Product)
│   │   ├── create_post/             # Social media post creation & device gallery picker
│   │   ├── deactivate_account/      # Account deactivation & deletion multi-step flow
│   │   ├── edit_profile/            # User profile editing (avatar, bio, display name)
│   │   ├── help_support/            # Help center, FAQs, and support channels
│   │   ├── home/                    # Discovery feed, comments bottom sheet, reactions
│   │   ├── invite_friends/          # Referral links and social sharing
│   │   ├── list_product/            # Multi-step artwork seller wizard
│   │   │   ├── bloc/                # Listing creation form state & validation
│   │   │   ├── data/                # Listing categories, pricing tiers, specifications
│   │   │   └── view/                # Step screens (photos, pricing, framing, shipping)
│   │   ├── logout/                  # Logout confirmation modal & session termination
│   │   ├── main_shell/              # Scaffold shell with custom auto-hiding bottom navigation
│   │   ├── messages/                # Direct messaging conversations and chat threads
│   │   ├── notification/            # In-app notifications feed
│   │   ├── notification_settings/   # Push/Email notification preferences
│   │   ├── onboarding/              # Multi-step animated onboarding carousel
│   │   ├── orders/                  # Customer order history and order tracking
│   │   ├── password_security/       # Password update and 2FA settings
│   │   ├── privacy/                 # Privacy settings and policy
│   │   ├── product_details/         # Artwork detail view, dimensions, pricing & buy
│   │   ├── profile/                 # User profile, artist stats, tabs, side drawer
│   │   ├── saved/                   # Bookmarked & saved artwork collections
│   │   ├── search/                  # Search with query suggestions, tags, and users
│   │   ├── selling/                 # Seller analytics and active listings dashboard
│   │   ├── settings/                # Main application settings index
│   │   ├── shop/                    # Staggered catalog feed and category filters
│   │   └── splash/                  # Launch splash screen with duration handling
│   ├── theme/                       # Design tokens and theme system
│   │   ├── Home Decore_colors.dart        # Hex color definitions & semantic palettes
│   │   └── Home Decore_scheme.dart        # Theme mode helper and dynamic typography styles
│   ├── utils/                       # Shared platform utilities
│   │   └── system_ui_channel.dart   # Method channel definition for native system bars
│   ├── widgets/                     # Reusable UI component library
│   │   ├── bottom_nav.dart          # Animated bottom navigation bar
│   │   ├── Home Decore_fade_divider.dart  # Gradient divider widget
│   │   ├── Home Decore_fit_layout.dart    # Responsive constrained layout helper
│   │   ├── Home Decore_widgets.dart       # Core buttons, input fields, scaffolds, and headers
│   │   ├── notification_line_mapper.dart # Indicator styling mapper
│   │   ├── screen_background.dart   # Themed background wrapper
│   │   └── themed_status_bar.dart   # Native-aligned status bar background painter
│   ├── app.dart                     # Home DecoreApp MaterialApp definition and theme modes
│   ├── app_bootstrap.dart           # Legacy bootstrap draft (superseded)
│   ├── bootstrap.dart               # Startup sequence, error traps, portrait lock
│   └── main.dart                    # Application entry point invoking bootstrap()
├── test/                            # Automated test suite
│   └── widget_test.dart             # Smoke and integration widget test cases
├── analysis_options.yaml            # Dart static analysis and lint rule configuration
├── devtools_options.yaml            # Flutter DevTools options
├── pubspec.yaml                     # Project manifest and package dependencies
└── pubspec.lock                     # Locked dependency version resolution
```

---

## 3. Architecture & Design Patterns

### 3.1 Feature-First Modular Structure
The application adopts a feature-first architecture under `lib/screens/`. Each feature module contains three dedicated folders:
1. **`bloc/` (or `cubit/`):** Contains the state management classes (`*_bloc.dart`, `*_event.dart`, `*_state.dart` or `*_cubit.dart`). States utilize `Equatable` for value equality and deterministic rebuilds.
2. **`data/`:** Defines models, mock records, configuration enums, and static options specific to that feature (e.g. `home_data.dart`, `shop_data.dart`).
3. **`view/`:** Holds the Flutter widgets and views for the screen, broken down into manageable sub-widgets or part files.

### 3.2 State Management
The project standardizes on **`flutter_bloc` (v9.1.1)** and **`equatable` (v2.1.0)**:
- High-complexity features with user interactions (feed, multi-step forms, search, onboarding) use full `Bloc` implementations with event dispatching.
- Straightforward features (shell tab switching, simple cart toggles, image upload state) utilize lightweight `Cubit` controllers.
- Route-level dependency injection is handled cleanly in `AppRoutes.routes` using `BlocProvider` and `MultiBlocProvider`.

### 3.3 Core Network & Data Layer
- **Client:** Powered by `dio: ^5.11.0` encapsulated inside `NetworkCallerDio`.
- **Session Management:** Secure token persistence via `flutter_secure_storage: ^11.0.0` inside `SecureStorageService`.
- **Media Uploads:** Multi-part file upload support in `ImageUploadService` and `ImageUploadCubit` with mime type resolution via `mime: ^2.0.0`.
- **Timeouts & Safety:** Preconfigured 30-second connection and receive timeouts with structured `NetworkResponseDio` result wrappers.

### 3.4 Theming & Typography
- **Design Tokens:** Strict neutral scale (`neutral50` to `neutral950`) and accent colors (`blue600`, `green600`, `red600`, `orange600`) located in `Home DecoreColors`.
- **Typography:** Bundled brand fonts:
  - `GeneralSans` (Regular, Medium, Semibold) for modern UI and readable body copy.
  - `IBMPlexMono` (Regular, Medium, Semibold) for distinctive header and technical numeral typography.
- **Dynamic Theming:** Supported through `Home DecoreScheme` and `AppearancePage.themeModeNotifier` (`ThemeMode.light` and `ThemeMode.dark`).

### 3.5 System UI & Native Inset Integration
- **Flutter Layer:** In `bootstrap.dart`, edge-to-edge mode is explicitly initialized (`SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge)`).
- **Native Android Layer (`MainActivity.kt`):** Native Android code handles modern Android 15/16 layout insets:
  - Layout frame drawn edge-to-edge with `WindowCompat.setDecorFitsSystemWindows(window, false)`.
  - Status bar permanently pinned visible.
  - Navigation bar auto-hidden after 2 seconds with `BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE`.
  - Window insets animation callbacks intercept soft keyboard (IME) animations.

---

## 4. Complete Screen & Feature Breakdown

| Feature / Route | Route Name | State Management | Primary Role |
| :--- | :--- | :--- | :--- |
| **Splash** | `/` | `SplashBloc` | Displays brand logo with configurable timer (`splashDuration`), transitions to onboarding. |
| **Onboarding** | `/onboarding` | `OnboardingBloc` | 5-step interactive onboarding slides with swipe gestures, page counter, and "Get Started" CTA. |
| **Sign In / Welcome** | `/sign-in` | `WelcomeBloc` | Email/password login, Google/Apple third-party login buttons, navigation to registration. |
| **Create Account** | `/create-account` | `CreateAccountBloc` | New user registration flow with input fields and validation. |
| **Forgot Password** | `/forgot-password` | `ForgotPasswordBloc` | Password recovery initiation via email. |
| **OTP Verification** | `/otp-verification` | `OtpVerificationBloc` | One-time PIN verification screen with resend timer. |
| **New Password** | `/new-password` | `NewPasswordBloc` | Password reset confirmation with validation rules. |
| **Set Password** | `/set-password` | `SetPasswordBloc` | Post-registration initial password creation. |
| **Main Shell** | `/main` | `MainShellCubit` | Host layout with `PageView` and custom animated bottom navigation bar. Auto-hides on scroll. |
| **Home (Feed)** | *Tab 0* | `HomeBloc` | Art discovery stream, post likes, bookmarks, 2-level nested comment thread drawer, share sheets. |
| **Shop** | *Tab 1 / `/shop`* | `ShopBloc` | Staggered grid catalog of available artworks, price filters, shopping cart counter badge. |
| **Filter** | `/filter` | `FilterBloc` | Multi-category artwork filtering (Digital art, Sculpture, Photography, Painting, Price). |
| **Create** | *Tab 2 / `/create`* | `CreateBloc` | Modal hub to choose between publishing a social art post or listing a marketplace product. |
| **New Post** | `/new-post` | `NewPostBloc` | Device media browser, photo selection via `photo_manager`, caption, tags, and posting. |
| **Messages / Inbox** | *Tab 3 / `/inbox`* | `MessagesBloc`, `InboxBloc` | Conversations list and live messaging thread interface with collectors and artists. |
| **Profile** | *Tab 4* | `ProfileBloc`, `MenuBloc` | Artist profile header, collection tabs, follower statistics, and side drawer menu. |
| **Product Details** | `/product-details` | `ProductDetailsCubit` | High-res art preview, provenance, dimensions, make an offer / bid, and direct checkout. |
| **Cart** | `/cart` | `CartCubit` | Shopping cart with order summary, subtotal calculation, and checkout trigger. |
| **List Product** | `/list-product` | `ListProductBloc` | Multi-screen seller listing workflow (Photos, artwork specs, framing, shipping, returns, review). |
| **Saved** | `/saved` | `SavedBloc` | User's bookmarked artwork collection and favorites. |
| **Orders** | `/orders` | `OrdersBloc` | Purchase history, order statuses, tracking numbers. |
| **Selling** | `/selling` | `SellingBloc` | Seller operations dashboard, active listings, order fulfillment. |
| **Bids** | `/bids` | `BidsMenuBloc` | Overview of active auctions, submitted offers, and received collector bids. |
| **Invite Friends** | `/invite-friends` | `InviteFriendsBloc` | Referral code generation and social invite sharing. |
| **Appearance** | `/appearance` | `AppearanceBloc` | Theme selection (Light, Dark, System default). |
| **Account Information**| `/account-information` | `AccountInformationBloc`| Email, phone number, and verified identity settings. |
| **Password & Security**| `/password-security` | `PasswordSecurityBloc` | Password changes, two-factor authentication, security history. |
| **Notification Settings**| `/notification-settings`| `NotificationSettingsBloc`| Toggle push, email, and marketplace notification channels. |
| **Privacy** | `/privacy` | `PrivacyBloc` | Visibility settings, privacy policies, data download options. |
| **Blocked Accounts** | `/blocked-accounts` | `BlockedAccountsBloc` | List of blocked accounts with unblock actions. |
| **Deactivate Account** | `/deactivate-account` | `DeactivateAccountBloc` | Safety warnings, password confirmation, account deactivation & deletion. |
| **Logout** | `/logout` | `LogoutBloc` | Session exit dialog, cache clearing, and return to auth. |

---

## 5. Static Code Analysis & Lint Audit

Running static code inspection (`flutter analyze`) reveals **75 diagnostic notices** (3 warnings and 72 lint messages).

### 5.1 Compiler Warnings (Must Fix)
1. **Unused Import in Logout Screen:**  
   - File: `lib/screens/logout/view/logout_screen.dart:7:8`  
   - Warning: `Unused import: '../../../theme/Home Decore_colors.dart'`.
2. **Unused Element Parameter in Messaging:**  
   - File: `lib/screens/messages/view/inbox_screen.dart:890:10`  
   - Warning: `A value for optional parameter 'bottom' isn't ever given`.
3. **Unused Import in Profile Menu BLoC:**  
   - File: `lib/screens/profile/bloc/menu_bloc.dart:3:8`  
   - Warning: `Unused import: '../data/menu_data.dart'`.

### 5.2 Lint Anomalies & Code Style Issues
1. **HTML Bracket Formatting in Doc Comments (`unintended_html_in_doc_comment`):**  
   - Prevalent across `lib/screens/list_product/bloc/list_product_event.dart`, `list_product_state.dart`, and `list_product_screen.dart`.  
   - Dart analyzer interprets bare `<Type>` annotations in doc comments as HTML tags. They should be wrapped in backticks (e.g. `` `<ListProductStep>` ``).
2. **Double Underscore Unused Parameter Names (`unnecessary_underscores`):**  
   - In `framing_screen.dart`, `list_product_photos.dart`, and `list_product_review_screen.dart`, parameters use `__` instead of standard `_`.
3. **Dangling Library Doc Comments (`dangling_library_doc_comments` & `slash_for_doc_comments`):**  
   - `list_product_state.dart:1:1`, `list_product_screen.dart:1:1`, and `notification_screen.dart:384:1` contain doc comment blocks without a subsequent `library` declaration.
4. **Parameter Initializer in Splash BLoC (`prefer_initializing_formals`):**  
   - `lib/screens/splash/bloc/splash_bloc.dart:14:9` manually assigns a parameter inside the constructor body instead of using `this._bootstrap`.

---

## 6. Testing & Quality Assurance Audit

Running the automated test suite (`flutter test`) reveals that **both existing widget tests currently fail**:

### 6.1 Diagnostic of Test Failures (`test/widget_test.dart`)
1. **Failure 1: `splash advances to onboarding and auth flow`**
   - **Error:** `Expected: exactly one matching candidate, Actual: Found 0 widgets with text "Welcome\nback"`.
   - **Root Cause:** In `widget_test.dart`, the test taps the `Skip` button on the onboarding screen expecting it to route directly to `WelcomeScreen`. However, according to `OnboardingBloc._onSkipPressed`:
     ```dart
     void _onSkipPressed(OnboardingSkipPressed event, Emitter<OnboardingState> emit) {
       final lastIndex = OnboardingData.pages.length - 1;
       if (state.pageIndex >= lastIndex) return;
       emit(state.copyWith(pageIndex: lastIndex, finished: false, isForward: true));
     }
     ```
     Pressing `Skip` actually navigates the user to the **last onboarding card** (page index 4), where the **"Get Started"** button is displayed. Only tapping "Get Started" triggers the navigation callback `_openSignIn(context)`.
2. **Failure 2: `mock sign in opens home and shop tab`**
   - **Error:** `Bad state: No element at ensureVisible(find.text('Sign In'))`.
   - **Root Cause:** Stemming from the same issue: because the onboarding carousel did not exit upon tapping `Skip`, the test remains on the onboarding screen and the "Sign In" button is never rendered.

---

## 7. Technical Debt & Code Hygiene Findings

### 7.1 Orphaned & Commented-Out Legacy Code
Several core files contain large duplicate blocks of commented-out legacy code above their active implementations:
- **`lib/main.dart`:** Lines 1–85 contain the previous `Home DecoreApp` and `main()` implementation, while lines 90–95 contain the active bootstrap invocation.
- **`lib/widgets/bottom_nav.dart`:** Lines 1–237 contain an older revision of the navigation bar component.
- **`lib/screens/shop/view/shop_screen.dart`:** Lines 1–463 contain hundreds of lines of commented-out prior implementations.
- **`lib/screens/appearance/appearance_page.dart`:** Lines 1–84 contain commented-out static methods.
- **`lib/app_bootstrap.dart`:** Entire file (28 lines) is commented out, replaced by `bootstrap.dart`.
- **`android/.../MainActivity.kt`:** Lines 1–8 contain commented-out boilerplate.

*Impact:* Adds visual clutter, inflates line counts, and confuses engineers on what code is authoritative.

### 7.2 Theme Management Dualism
The project has two distinct theme sources:
- **`AppearancePage`:** Functions as a static utility with a `ValueNotifier<ThemeMode>` listened to by `Home DecoreApp`.
- **`AppearanceBloc`:** Exists in `lib/screens/appearance/bloc/` as a full BLoC.
*Recommendation:* Unify theme state into `AppearanceBloc` and inject it at the top of the widget tree so all widgets react predictably without static mutable state.

### 7.3 Orphaned MethodChannel (`SystemUiChannel`)
- `lib/utils/system_ui_channel.dart` defines a Flutter `MethodChannel('Home Decore/system_ui')` with methods `enterStickyNav`, `enterFullscreen`, and `showAllBars`.
- However:
  1. The channel is never invoked by any Flutter widget.
  2. The native Android implementation in `MainActivity.kt` does not implement `MethodChannel.MethodCallHandler` or listen to `'Home Decore/system_ui'`.
*Impact:* This is dead code that can either be wired up or removed.

---

## 8. Prioritized Recommendations & Action Plan

### Phase 1: Immediate Maintenance (Quick Wins)
- [ ] **Fix `test/widget_test.dart`:** Update the widget tests to tap "Skip", then tap "Get Started" to advance to `WelcomeScreen`, ensuring the test suite passes green in CI.
- [ ] **Clean Compiler Warnings:** Remove the unused imports in `logout_screen.dart` and `menu_bloc.dart`, and remove the unused `bottom` parameter in `inbox_screen.dart`.
- [ ] **Purge Dead Commented Blocks:** Remove legacy commented code in `main.dart`, `shop_screen.dart`, `bottom_nav.dart`, `appearance_page.dart`, and delete `app_bootstrap.dart`.

### Phase 2: Architecture & Quality Enhancements
- [ ] **Unify Appearance & Theming:** Replace static `ValueNotifier` in `AppearancePage` with the already constructed `AppearanceBloc`, providing `ThemeMode` via `BlocBuilder` in `Home DecoreApp`.
- [ ] **Doc Comments & Linter Fixes:** Wrap generic angle brackets in backticks across `list_product` files to resolve the 72 Dart analyzer lints.
- [ ] **Connect or Prune `SystemUiChannel`:** Either implement the MethodChannel handlers in `MainActivity.kt` for programmatic full-screen switching, or remove `system_ui_channel.dart` if native Android lifecycle insets are sufficient.

### Phase 3: Backend & Feature Readiness
- [ ] **Repository Layer Implementation:** Transition from hardcoded mock records in `*_data.dart` to abstract Repository classes backed by `NetworkCallerDio`.
- [ ] **Expanded Test Coverage:** Add BLoC unit tests for core state workflows (`HomeBloc`, `ShopBloc`, `CreateAccountBloc`, `ListProductBloc`) using `bloc_test`.
