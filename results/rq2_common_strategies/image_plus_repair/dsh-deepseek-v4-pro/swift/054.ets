// ArkTS translation of SwiftUI source (Kotlin Compose -> SwiftUI -> ArkUI).
// File ID: 054

// MARK: - Data Models

// Homework: single assignment item shown in the grid.
class Homework {
  id: number
  title: string
  status: string
  constructor(id: number, title: string, status: string) {
    this.id = id
    this.title = title
    this.status = status
  }
}

// ChartData: one progress bar entry. `progress` is a Float in Kotlin, number here.
class ChartData {
  id: number
  label: string
  progress: number
  constructor(id: number, label: string, progress: number) {
    this.id = id
    this.label = label
    this.progress = progress
  }
}

// MARK: - Color Helper (SwiftUI `Color(hex:)` extension equivalent)
// ArkUI accepts colors as '#AARRGGBB' strings, so this helper converts the
// 32-bit hex integers used in AppTokens into those strings.

function toHex2(value: number): string {
  const hex: string = value.toString(16)
  return hex.length === 1 ? '0' + hex : hex
}

function colorFromHex(hex: number): string {
  const a: number = (hex >> 24) & 0xFF
  const r: number = (hex >> 16) & 0xFF
  const g: number = (hex >> 8) & 0xFF
  const b: number = hex & 0xFF
  // If alpha is 0, the input was likely 0xRRGGBB; default to opaque (0xFF).
  const alpha: number = a === 0 ? 0xFF : a
  return '#' + toHex2(alpha) + toHex2(r) + toHex2(g) + toHex2(b)
}

// MARK: - AppTokens (Kotlin to Swift to ArkTS translation)
// Dp values in Kotlin Compose map 1:1 to vp units in ArkUI.

class AppColors {
  static readonly primary: string = colorFromHex(0xFF0EA5E9)
  static readonly secondary: string = colorFromHex(0xFF6366F1)
  static readonly tertiary: string = colorFromHex(0xFF06B6D4)
  static readonly background: string = colorFromHex(0xFFF1F5F9)
  static readonly surface: string = colorFromHex(0xFFFFFFFF)
  static readonly surfaceVariant: string = colorFromHex(0xFFE2E8F0)
  static readonly outline: string = colorFromHex(0xFFD1D5DB)
  static readonly success: string = colorFromHex(0xFF10B981)
  static readonly warning: string = colorFromHex(0xFFF59E0B)
  static readonly error: string = colorFromHex(0xFFEF4444)
  static readonly onPrimary: string = colorFromHex(0xFFFFFFFF)
  static readonly onSecondary: string = colorFromHex(0xFFFFFFFF)
  static readonly onTertiary: string = colorFromHex(0xFF0F172A)
  static readonly onBackground: string = colorFromHex(0xFF1E293B)
  static readonly onSurface: string = colorFromHex(0xFF1E293B)
}

class AppTypography {
  // ArkUI fonts are set via fontSize + fontWeight on each Text component.
  static readonly displaySize: number = 26
  static readonly displayWeight: FontWeight = FontWeight.Bold
  static readonly headlineSize: number = 18
  static readonly headlineWeight: FontWeight = FontWeight.Medium // .semibold has no direct enum; Medium is closest
  static readonly titleSize: number = 14
  static readonly titleWeight: FontWeight = FontWeight.Medium
  static readonly bodySize: number = 12
  static readonly bodyWeight: FontWeight = FontWeight.Regular
  static readonly labelSize: number = 11
  static readonly labelWeight: FontWeight = FontWeight.Medium
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

class AppSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 14
  static readonly xl: number = 20
  static readonly xxl: number = 28
}

// Kotlin's ShadowSpec maps to ArkUI's .shadow({ radius, color, offsetX, offsetY }).
class ShadowSpec {
  radius: number
  x: number
  y: number
  opacity: number
  constructor(radius: number, x: number, y: number, opacity: number) {
    this.radius = radius
    this.x = x
    this.y = y
    this.opacity = opacity
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 0, 1, 0.1)
  static readonly level2: ShadowSpec = new ShadowSpec(4, 0, 2, 0.14)
  static readonly level3: ShadowSpec = new ShadowSpec(6, 0, 3, 0.16)
}

// MARK: - AssignmentCard Component (Equivalent to Card in LazyVerticalGrid)

@Component
struct AssignmentCard {
  homework: Homework = new Homework(0, '', '')

  build() {
    Column({ space: AppSpacing.sm }) {
      // Box: 40x40, tertiary fill, small corner radius
      Row()
        .width(40)
        .height(40)
        .backgroundColor(AppColors.tertiary)
        .borderRadius(AppShapes.small)

      // Spacer (flexible; original also used VStack spacing, reproduced via Column space)
      Blank()

      Text(this.homework.title)
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.onSurface)
      Text(this.homework.status)
        .fontSize(AppTypography.labelSize)
        .fontWeight(AppTypography.labelWeight)
        .fontColor(AppColors.onSurface)
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({ width: 1, color: AppColors.outline, radius: AppShapes.medium })
    .aspectRatio(1.0)
  }
}

// MARK: - ChartProgressBar Component (Equivalent to Row in LazyColumn)

@Component
struct ChartProgressBar {
  chartData: ChartData = new ChartData(0, '', 0)

  build() {
    Column({ space: 0 }) {
      // Bar: filled portion (primary) over a surfaceVariant track, small radius
      Row() {
        Row()
          .width(`${Math.floor(this.chartData.progress * 100)}%`)
          .height(24)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small)
        Blank()
      }
      .width('100%')
      .height(24)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)

      Text(`${this.chartData.label}: ${Math.floor(this.chartData.progress * 100)}%`)
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.onSurface)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// MARK: - RootScreen (Main UI View)

@Entry
@Component
struct RootScreen {
  // Assignments, equivalent to `remember { listOf(...) }`
  private works: Homework[] = [
    new Homework(1, 'Linear Algebra HW1', 'Submitted'),
    new Homework(2, 'Data Structures HW2', 'Pending'),
    new Homework(3, 'Algorithm HW3', 'Graded'),
    new Homework(4, 'Probability HW4', 'Pending')
  ]

  // Chart data, equivalent to `remember { mutableStateListOf(...) }`
  @State charts: ChartData[] = [
    new ChartData(1, 'Week 1', 0.7),
    new ChartData(2, 'Week 2', 0.9),
    new ChartData(3, 'Week 3', 0.5),
    new ChartData(4, 'Week 4', 0.8)
  ]

  build() {
    Column() {
      // TopAppBar equivalent
      Row() {
        Text('Homework Submit')
          .fontSize(AppTypography.displaySize)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
      .backgroundColor(AppColors.surface)

      // Main content area
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Assignments')
            .fontSize(AppTypography.headlineSize)
            .fontWeight(AppTypography.headlineWeight)
            .fontColor(AppColors.onBackground)

          // LazyVerticalGrid equivalent: 2 flexible columns
          Grid() {
            ForEach(this.works, (w: Homework) => {
              GridItem() {
                AssignmentCard({ homework: w })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppSpacing.md)
          .rowsGap(AppSpacing.md)
          .width('100%')

          Text('Progress Chart')
            .fontSize(AppTypography.headlineSize)
            .fontWeight(AppTypography.headlineWeight)
            .fontColor(AppColors.onBackground)

          // LazyColumn equivalent
          Column({ space: AppSpacing.sm }) {
            ForEach(this.charts, (c: ChartData) => {
              ChartProgressBar({ chartData: c })
            })
          }
          .width('100%')

          // Submit button
          Button() {
            Text('Submit New HW')
              .fontSize(AppTypography.titleSize)
              .fontWeight(AppTypography.titleWeight)
              .fontColor(AppColors.onSecondary)
              .width('100%')
              .textAlign(TextAlign.Center)
          }
          .width('60%')
          .height(40)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppShapes.large)
          .margin({ top: AppSpacing.lg })
          .alignSelf(ItemAlign.Center)
          .onClick(() => {
            console.log('Submit New HW Tapped')
          })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(AppSpacing.lg)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      // Brush.verticalGradient: primary at 0.15 opacity -> #260EA5E9, secondary at 0.1 -> #1A6366F1
      .linearGradient({
        angle: 180,
        colors: [['#260EA5E9', 0.0], ['#1A6366F1', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    // Content goes under the status bar and home indicator (ignoresSafeArea(.all))
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// MARK: - App Entry Point
// In ArkUI the @Entry RootScreen above is the page entry (equivalent to MainActivity).
// Hiding the status bar (prefersStatusBarHidden / CustomHostingController) has no
// in-page declarative equivalent; it is handled in the ability's onWindowStageCreate
// via setWindowSystemBarProperties (e.g. hide status bar / full screen).

// MARK: - Preview
// SwiftUI's RootScreen_Previews (PreviewProvider) maps to ArkUI's @Preview, which is
// only used by the DevEco previewer and omitted here so the page still builds a .hap.
