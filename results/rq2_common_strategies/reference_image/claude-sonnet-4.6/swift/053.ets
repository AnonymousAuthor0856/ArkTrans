// ============================================================================
// File: entry/src/main/ets/pages/RootScreen.ets
// (register it in entry/src/main/resources/base/profile/main_pages.json)
// SwiftUI → ArkTS (ArkUI declarative) port of the CodeIDE Terminal screen.
// ============================================================================

// ─────────────────────────────────────────────────────────────────────────────
// 1. Design tokens  (SwiftUI `AppTokens` → plain static token classes)
//    Dp/sp → vp/fp: ArkUI numbers are density-independent, so 1:1 mapping.
// ─────────────────────────────────────────────────────────────────────────────

export class AppColors {
  static readonly primary: string = '#1E293B';
  static readonly secondary: string = '#0EA5E9';
  static readonly tertiary: string = '#FACC15';
  static readonly background: string = '#1E293B';
  static readonly surface: string = '#1E293B';
  static readonly surfaceVariant: string = '#334155';
  static readonly outline: string = '#475569';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#0B1220';
  static readonly onBackground: string = '#E2E8F0';
  static readonly onSurface: string = '#E2E8F0';
}

export class AppTypography {
  // SwiftUI Font.system(size:weight:) → fontSize() + fontWeight()
  static readonly displaySize: number = 26;
  static readonly displayWeight: FontWeight = FontWeight.Bold;      // .bold
  static readonly headlineSize: number = 20;
  static readonly headlineWeight: FontWeight = FontWeight.Bold;    // .semibold ≙ Bold/Medium
  static readonly titleSize: number = 16;
  static readonly titleWeight: FontWeight = FontWeight.Medium;     // .medium
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;      // .regular
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;     // .medium
}

export class AppShapes {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 12;
}

export class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

export class ShadowSpec {
  radius: number;
  offsetY: number;
  color: string;

  constructor(radius: number, offsetY: number, opacity: number) {
    this.radius = radius;
    this.offsetY = offsetY;
    // ArkUI ShadowOptions.color takes ResourceColor → rgba() string carries the opacity.
    this.color = `rgba(0, 0, 0, ${opacity})`;
  }
}

export const SHADOW_LEVEL_1: ShadowSpec = new ShadowSpec(2, 1, 0.10);
export const SHADOW_LEVEL_2: ShadowSpec = new ShadowSpec(4, 2, 0.14);
export const SHADOW_LEVEL_3: ShadowSpec = new ShadowSpec(6, 3, 0.16);

// ─────────────────────────────────────────────────────────────────────────────
// 2. Data model  (SwiftUI `CodeMarker: Identifiable` → plain ArkTS class)
// ─────────────────────────────────────────────────────────────────────────────

export class CodeMarker {
  id: number;
  name: string;
  desc: string;

  constructor(id: number, name: string, desc: string) {
    this.id = id;
    this.name = name;
    this.desc = desc;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. Components
//    SwiftUI `View` → ArkTS `@Component struct` (build() == body)
// ─────────────────────────────────────────────────────────────────────────────

/** SwiftUI `CustomTopAppBar` (Android CenterAlignedTopAppBar). */
@Component
export struct CustomTopAppBar {
  @Prop title: string = '';

  build() {
    Row() {
      Text(this.title)
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onBackground)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)                       // CenterAligned
    .padding({ top: AppSpacing.md, bottom: AppSpacing.md })  // .padding(.vertical, md)
    .backgroundColor(AppColors.background)
  }
}

/** SwiftUI `CodeMarkerCard` — HStack + rounded badge + two-line column. */
@Component
export struct CodeMarkerCard {
  marker: CodeMarker = new CodeMarker(0, '', '');

  build() {
    Row({ space: AppSpacing.md }) {                          // Arrangement.spacedBy(md)
      Stack() {                                              // Box
        Text(this.marker.id.toString())
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onSecondary)
      }
      .width(32)
      .height(32)
      .backgroundColor(AppColors.secondary)
      .borderRadius(AppShapes.small)

      Column({ space: 2 }) {                                 // Column
        Text(this.marker.name)
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onSurface)
        Text(this.marker.desc)
          .fontSize(AppTypography.bodySize)
          .fontWeight(AppTypography.bodyWeight)
          .fontColor(AppColors.onSurface)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)                                       // fills remaining width
    }
    .width('100%')                                           // fillMaxWidth()
    .alignItems(VerticalAlign.Center)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surfaceVariant)               // containerColor = surfaceVariant
    .borderRadius(AppShapes.medium)                          // shape = medium
    .shadow({
      radius: SHADOW_LEVEL_1.radius,
      color: SHADOW_LEVEL_1.color,
      offsetX: 0,
      offsetY: SHADOW_LEVEL_1.offsetY
    })
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. RootScreen  (Scaffold + LazyColumn → Column + ScrollView + ForEach)
// ─────────────────────────────────────────────────────────────────────────────

@Entry
@Component
struct RootScreen {
  private markers: CodeMarker[] = [
    new CodeMarker(1, 'Main.kt', 'Entry point for Compose app'),
    new CodeMarker(2, 'Utils.kt', 'Helper functions'),
    new CodeMarker(3, 'Theme.kt', 'Color & Typography setup'),
    new CodeMarker(4, 'Data.kt', 'Repository and model classes')
  ];

  build() {
    Column() {
      // ── top app bar ────────────────────────────────────────────────────────
      CustomTopAppBar({ title: 'CodeIDE Terminal' })

      // ── scrollable body ────────────────────────────────────────────────────
      ScrollView() {
        Column({ space: AppSpacing.lg }) {
          Text('Project Files')
            .fontSize(AppTypography.headlineSize)
            .fontWeight(AppTypography.headlineWeight)
            .fontColor(AppColors.onBackground)

          Column({ space: AppSpacing.sm }) {                 // LazyVStack(spacing: sm)
            ForEach(
              this.markers,
              (marker: CodeMarker) => {
                CodeMarkerCard({ marker: marker })
              },
              (marker: CodeMarker) => marker.id.toString()   // stable key
            )
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          Text('Live Terminal')
            .fontSize(AppTypography.headlineSize)
            .fontWeight(AppTypography.headlineWeight)
            .fontColor(AppColors.onBackground)
            .margin({ top: AppSpacing.sm })

          // Box(surfaceVariant) + 1.dp outline border, 240.dp tall
          Stack({ alignContent: Alignment.TopStart }) {
            Text('> println("Hello, Kotlin!")')
              .fontSize(AppTypography.bodySize)
              .fontWeight(AppTypography.bodyWeight)
              .fontColor(AppColors.onSurface)
              .padding(AppSpacing.md)
          }
          .width('100%')
          .height(240)
          .backgroundColor(AppColors.surfaceVariant)
          .border({
            width: 1,
            color: AppColors.outline,
            radius: AppShapes.medium
          })

          // Button fillMaxWidth(0.6f) centered inside the column
          Row() {
            Button() {
              Text('Run Code')
                .fontSize(AppTypography.titleSize)
                .fontWeight(AppTypography.titleWeight)
                .fontColor(AppColors.onSecondary)
            }
            .type(ButtonType.Normal)                         // so borderRadius is honored
            .width('60%')                                    // fillMaxWidth(0.6f)
            .height(48)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.large)
            .shadow({
              radius: SHADOW_LEVEL_1.radius,
              color: SHADOW_LEVEL_1.color,
              offsetX: 0,
              offsetY: SHADOW_LEVEL_1.offsetY
            })
            .onClick(() => {
              // Button(action: {}) — no-op in the reference screen
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(AppSpacing.lg)
      }
      .layoutWeight(1)                                       // body takes the rest
      .width('100%')
      .scrollBar(BarState.Off)                               // showsIndicators: false
      .align(Alignment.TopStart)
      // background(Brush.verticalGradient(...)) — 180° == top → bottom
      .linearGradient({
        angle: 180,
        colors: [
          ['rgba(30, 41, 59, 0.80)', 0.0],
          ['rgba(30, 41, 59, 0.90)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')                                          // full screen
    .backgroundColor(AppColors.background)
    // .ignoresSafeArea(.all, edges: .all)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 5. Full-screen / status-bar equivalent — put this in EntryAbility.onWindowStageCreate
//    (ArkUI hides the status bar at the window level, not via a view modifier):
//
//    onWindowStageCreate(windowStage: window.WindowStage): void {
//      windowStage.loadContent('pages/RootScreen', (err) => { /* ... */ });
//      const win = windowStage.getMainWindowSync();
//      win.setWindowLayoutFullScreen(true);      // ignore safe areas
//      win.setWindowSystemBarEnable([]);         // statusBarHidden(true)
//    }
// ─────────────────────────────────────────────────────────────────────────────