import { LengthMetrics } from '@kit.ArkUI'

// MARK: - AppTokens
class AppColors {
  static readonly primary: ResourceColor = '#FF111827'
  static readonly secondary: ResourceColor = '#FF374151'
  static readonly tertiary: ResourceColor = '#FF6B7280'
  static readonly background: ResourceColor = '#FFF9FAFB'
  static readonly surface: ResourceColor = '#FFFFFFFF'
  static readonly surfaceVariant: ResourceColor = '#FFE5E7EB'
  static readonly outline: ResourceColor = '#FFD1D5DB'
  static readonly success: ResourceColor = '#FF16A34A'
  static readonly warning: ResourceColor = '#FFF59E0B'
  static readonly error: ResourceColor = '#FFEF4444'
  static readonly onPrimary: ResourceColor = '#FFFFFFFF'
  static readonly onSecondary: ResourceColor = '#FFFFFFFF'
  static readonly onTertiary: ResourceColor = '#FF111827'
  static readonly onBackground: ResourceColor = '#FF111827'
  static readonly onSurface: ResourceColor = '#FF1F2937'
}

class AppTypography {
  static readonly displayLarge: number = 28
  static readonly headlineMedium: number = 20
  static readonly titleMedium: number = 16
  static readonly bodyMedium: number = 14
  static readonly labelMedium: number = 12
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.14)
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.16)
}

// MARK: - Data Model
class Medicine {
  id: number
  name: string
  time: string

  constructor(id: number, name: string, time: string) {
    this.id = id
    this.name = name
    this.time = time
  }
}

// MARK: - MedicineItem Component
@Component
struct MedicineItem {
  medicine: Medicine = new Medicine(0, '', '')

  build() {
    Row() {
      Column() {
        Text(this.medicine.name)
          .fontSize(AppTypography.titleMedium)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(this.medicine.time)
          .fontSize(AppTypography.bodyMedium)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
      .space(AppSpacing.xs)
      .layoutWeight(1)

      Circle()
        .fill(AppColors.primary)
        .width(16)
        .height(16)
    }
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: AppShapes.medium
    })
    .width('100%')
  }
}

// MARK: - MedicineList Component
@Component
struct MedicineList {
  private items: Medicine[] = [
    new Medicine(1, 'Vitamin C', '08:00 AM'),
    new Medicine(2, 'Aspirin', '12:30 PM'),
    new Medicine(3, 'Insulin', '06:00 PM'),
    new Medicine(4, 'Melatonin', '10:00 PM')
  ]

  build() {
    Scroll() {
      Column({ space: AppSpacing.md }) {
        ForEach(this.items, (m: Medicine) => {
          MedicineItem({ medicine: m })
        }, (m: Medicine) => m.id.toString())
      }
      .width('100%')
      .padding({ bottom: AppSpacing.xxl })
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .layoutWeight(1)
  }
}

// MARK: - RootScreen Component
@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // Main content
      Column() {
        // Top content area with gradient background
        Column({ space: AppSpacing.md }) {
          Text('Medicine Reminder')
            .fontSize(AppTypography.displayLarge)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)

          MedicineList()

          Blank()

          Button('Mark All Taken')
            .fontSize(AppTypography.titleMedium)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .height(48)
            .width('80%')
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.large)
            .margin({ bottom: AppSpacing.md })
        }
        .padding({
          top: AppSpacing.lg,
          left: AppSpacing.lg,
          right: AppSpacing.lg
        })
        .width('100%')
        .layoutWeight(1)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [[0xFFE5E7EB, 0.0], [0xFFFFFFFF, 1.0]]
        })
        .padding({ bottom: 56 })

        // BottomAppBar
        Row() {
          Text('Today')
            .fontSize(AppTypography.titleMedium)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
          Blank()
          Text('History')
            .fontSize(AppTypography.titleMedium)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Blank()
          Text('Profile')
            .fontSize(AppTypography.titleMedium)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .width('100%')
        .height(56)
        .backgroundColor(AppColors.surface)
        .shadow({
          color: `rgba(0,0,0,${AppElevation.level2.opacity})`,
          radius: AppElevation.level2.radius,
          offsetX: 0,
          offsetY: AppElevation.level2.dy
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      // FloatingActionButton
      Button('+')
        .fontSize(AppTypography.displayLarge)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .width(56)
        .height(56)
        .backgroundColor(AppColors.primary)
        .borderRadius(28)
        .margin(AppSpacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}