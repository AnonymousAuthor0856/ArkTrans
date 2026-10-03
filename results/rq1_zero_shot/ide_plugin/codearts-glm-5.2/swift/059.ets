class AppTokens {
  static readonly Colors = {
    primary: '#FF111827',
    secondary: '#FF374151',
    tertiary: '#FF6B7280',
    background: '#FFF9FAFB',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE5E7EB',
    outline: '#FFD1D5DB',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF111827',
    onBackground: '#FF111827',
    onSurface: '#FF1F2937',
  }
  static readonly Typography = {
    displayLarge: { size: 28, weight: FontWeight.Bold },
    headlineMedium: { size: 20, weight: FontWeight.Medium },
    titleMedium: { size: 16, weight: FontWeight.Medium },
    bodyMedium: { size: 14, weight: FontWeight.Normal },
    labelMedium: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  }
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  }
}

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

@Component
struct MedicineItem {
  @Prop name: string
  @Prop time: string

  build() {
    Row() {
      Column({ space: AppTokens.Spacing.xs }) {
        Text(this.name)
          .fontSize(AppTokens.Typography.titleMedium.size)
          .fontWeight(AppTokens.Typography.titleMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.time)
          .fontSize(AppTokens.Typography.bodyMedium.size)
          .fontWeight(AppTokens.Typography.bodyMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Circle({ width: 16, height: 16 })
        .fill(AppTokens.Colors.primary)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

@Entry
@Component
struct RootScreen {
  private items: Medicine[] = [
    new Medicine(1, 'Vitamin C', '08:00 AM'),
    new Medicine(2, 'Aspirin', '12:30 PM'),
    new Medicine(3, 'Insulin', '06:00 PM'),
    new Medicine(4, 'Melatonin', '10:00 PM'),
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column({ space: AppTokens.Spacing.md }) {
        Text('Medicine Reminder')
          .fontSize(AppTokens.Typography.displayLarge.size)
          .fontWeight(AppTokens.Typography.displayLarge.weight)
          .fontColor(AppTokens.Colors.onBackground)

        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.items, (m: Medicine) => {
              MedicineItem({ name: m.name, time: m.time })
            })
          }
          .padding({ bottom: AppTokens.Spacing.xxl })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')

        Row() {
          Button('Mark All Taken')
            .fontSize(AppTokens.Typography.titleMedium.size)
            .fontWeight(AppTokens.Typography.titleMedium.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .width('80%')
            .height(48)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: 56 + AppTokens.Spacing.md })
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.surfaceVariant, 0.0], [AppTokens.Colors.surface, 1.0]]
      })

      Column() {
        Blank()
        Row() {
          Text('Today')
            .fontSize(AppTokens.Typography.titleMedium.size)
            .fontWeight(AppTokens.Typography.titleMedium.weight)
            .fontColor(AppTokens.Colors.primary)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('History')
            .fontSize(AppTokens.Typography.titleMedium.size)
            .fontWeight(AppTokens.Typography.titleMedium.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('Profile')
            .fontSize(AppTokens.Typography.titleMedium.size)
            .fontWeight(AppTokens.Typography.titleMedium.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 8, color: '#24000000', offsetY: 4 })
      }
      .width('100%')
      .height('100%')

      Button('+')
        .fontSize(AppTokens.Typography.displayLarge.size)
        .fontWeight(AppTokens.Typography.displayLarge.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .width(56)
        .height(56)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(28)
        .margin({ right: AppTokens.Spacing.lg, bottom: 56 + AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}