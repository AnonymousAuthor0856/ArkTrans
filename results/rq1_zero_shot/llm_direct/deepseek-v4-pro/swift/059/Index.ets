@Entry
@Component
struct MedicineReminderApp {
  build() {
    RootScreen()
  }
}

// MARK: - AppTokens
class AppTokens {
  static readonly Colors = {
    primary: '#111827',
    secondary: '#374151',
    tertiary: '#6B7280',
    background: '#F9FAFB',
    surface: '#FFFFFF',
    surfaceVariant: '#E5E7EB',
    outline: '#D1D5DB',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#111827',
    onBackground: '#111827',
    onSurface: '#1F2937'
  }

  static readonly Typography = {
    displayLarge: { fontSize: 28, fontWeight: FontWeight.Bold },
    headlineMedium: { fontSize: 20, fontWeight: FontWeight.Medium },
    titleMedium: { fontSize: 16, fontWeight: FontWeight.Medium },
    bodyMedium: { fontSize: 14, fontWeight: FontWeight.Regular },
    labelMedium: { fontSize: 12, fontWeight: FontWeight.Medium }
  }

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  }

  static readonly Elevation = {
    level1: { radius: 4, offsetY: 2, opacity: 0.12 },
    level2: { radius: 8, offsetY: 4, opacity: 0.14 },
    level3: { radius: 12, offsetY: 6, opacity: 0.16 }
  }
}

// MARK: - Data Model
interface Medicine {
  id: number
  name: string
  time: string
}

// MARK: - MedicineItem Component
@Component
struct MedicineItem {
  @Prop medicine: Medicine

  build() {
    Row() {
      Column({ space: AppTokens.Spacing.xs }) {
        Text(this.medicine.name)
          .fontSize(AppTokens.Typography.titleMedium.fontSize)
          .fontWeight(AppTokens.Typography.titleMedium.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.medicine.time)
          .fontSize(AppTokens.Typography.bodyMedium.fontSize)
          .fontWeight(AppTokens.Typography.bodyMedium.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Circle()
        .fill(AppTokens.Colors.primary)
        .width(16)
        .height(16)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.medium
    })
  }
}

// MARK: - MedicineList Component
@Component
struct MedicineList {
  private items: Medicine[] = [
    { id: 1, name: 'Vitamin C', time: '08:00 AM' },
    { id: 2, name: 'Aspirin', time: '12:30 PM' },
    { id: 3, name: 'Insulin', time: '06:00 PM' },
    { id: 4, name: 'Melatonin', time: '10:00 PM' }
  ]

  build() {
    Scroll() {
      Column({ space: AppTokens.Spacing.md }) {
        ForEach(this.items, (item: Medicine) => {
          MedicineItem({ medicine: item })
        }, (item: Medicine) => item.id.toString())
      }
      .width('100%')
      .padding({ bottom: AppTokens.Spacing.xxl })
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
  }
}

// MARK: - RootScreen Component
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // Main content area
      Column() {
        Column({ space: AppTokens.Spacing.md }) {
          Text('Medicine Reminder')
            .fontSize(AppTokens.Typography.displayLarge.fontSize)
            .fontWeight(AppTokens.Typography.displayLarge.fontWeight)
            .fontColor(AppTokens.Colors.onBackground)

          MedicineList()

          Blank()

          Button('Mark All Taken')
            .fontSize(AppTokens.Typography.titleMedium.fontSize)
            .fontWeight(AppTokens.Typography.titleMedium.fontWeight)
            .fontColor(AppTokens.Colors.onSecondary)
            .height(48)
            .width('80%')
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .margin({ bottom: AppTokens.Spacing.md })
        }
        .width('100%')
        .height('100%')
        .padding({
          top: AppTokens.Spacing.lg,
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg
        })
        .linearGradient({
          angle: 180,
          colors: [[AppTokens.Colors.surfaceVariant, 0], [AppTokens.Colors.surface, 1]]
        })
        .padding({ bottom: 56 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // BottomAppBar
      Column() {
        Blank()
        Row() {
          Text('Today')
            .fontSize(AppTokens.Typography.titleMedium.fontSize)
            .fontWeight(AppTokens.Typography.titleMedium.fontWeight)
            .fontColor(AppTokens.Colors.primary)
          Blank()
          Text('History')
            .fontSize(AppTokens.Typography.titleMedium.fontSize)
            .fontWeight(AppTokens.Typography.titleMedium.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text('Profile')
            .fontSize(AppTokens.Typography.titleMedium.fontSize)
            .fontWeight(AppTokens.Typography.titleMedium.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          color: `rgba(0, 0, 0, ${AppTokens.Elevation.level2.opacity})`,
          offsetY: AppTokens.Elevation.level2.offsetY
        })
      }
      .width('100%')
      .height('100%')

      // FloatingActionButton
      Button('+')
        .fontSize(AppTokens.Typography.displayLarge.fontSize)
        .fontWeight(AppTokens.Typography.displayLarge.fontWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .width(56)
        .height(56)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(28)
        .margin(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}