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

  static readonly TypographyTokens = {
    displayLarge: { size: 28, weight: FontWeight.Bold },
    headlineMedium: { size: 20, weight: FontWeight.Medium },
    titleMedium: { size: 16, weight: FontWeight.Medium },
    bodyMedium: { size: 14, weight: FontWeight.Regular },
    labelMedium: { size: 12, weight: FontWeight.Medium }
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

  static readonly ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12, color: '#1F000000' },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14, color: '#24000000' },
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16, color: '#29000000' }
  }
}

interface Medicine {
  id: number
  name: string
  time: string
}

@Component
struct MedicineItem {
  medicine: Medicine = {
    id: 0,
    name: '',
    time: ''
  }

  build() {
    Row() {
      Column({ space: AppTokens.Spacing.xs }) {
        Text(this.medicine.name)
          .fontSize(AppTokens.TypographyTokens.titleMedium.size)
          .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Text(this.medicine.time)
          .fontSize(AppTokens.TypographyTokens.bodyMedium.size)
          .fontWeight(AppTokens.TypographyTokens.bodyMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Circle()
        .width(16)
        .height(16)
        .fill(AppTokens.Colors.primary)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.medium
    })
  }
}

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
      .padding({
        bottom: AppTokens.Spacing.xxl
      })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column({ space: AppTokens.Spacing.md }) {
          Text('Medicine Reminder')
            .fontSize(AppTokens.TypographyTokens.displayLarge.size)
            .fontWeight(AppTokens.TypographyTokens.displayLarge.weight)
            .fontColor(AppTokens.Colors.onBackground)

          MedicineList()
            .layoutWeight(1)

          Button() {
            Text('Mark All Taken')
              .width('100%')
              .height(48)
              .textAlign(TextAlign.Center)
              .fontSize(AppTokens.TypographyTokens.titleMedium.size)
              .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
              .fontColor(AppTokens.Colors.onSecondary)
          }
          .width('80%')
          .height(48)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .margin({
            bottom: AppTokens.Spacing.md
          })
        }
        .width('100%')
        .height('100%')
        .padding({
          top: AppTokens.Spacing.lg,
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          bottom: 56
        })
        .linearGradient({
          angle: 180,
          colors: [
            [AppTokens.Colors.surfaceVariant, 0.0],
            [AppTokens.Colors.surface, 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      Row() {
        Text('Today')
          .fontSize(AppTokens.TypographyTokens.titleMedium.size)
          .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
          .fontColor(AppTokens.Colors.primary)

        Blank()

        Text('History')
          .fontSize(AppTokens.TypographyTokens.titleMedium.size)
          .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Text('Profile')
          .fontSize(AppTokens.TypographyTokens.titleMedium.size)
          .fontWeight(AppTokens.TypographyTokens.titleMedium.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .padding({
        left: AppTokens.Spacing.lg,
        right: AppTokens.Spacing.lg
      })
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: AppTokens.ElevationMapping.level2.color,
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level2.dy
      })

      Button() {
        Text('+')
          .width(56)
          .height(56)
          .textAlign(TextAlign.Center)
          .fontSize(AppTokens.TypographyTokens.displayLarge.size)
          .fontWeight(AppTokens.TypographyTokens.displayLarge.weight)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .width(56)
      .height(56)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(28)
      .margin(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}