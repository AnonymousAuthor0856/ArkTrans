class ColorTokens {
  readonly primary: string = '#FF111827'
  readonly secondary: string = '#FF374151'
  readonly background: string = '#FFF9FAFB'
  readonly surface: string = '#FFFFFFFF'
  readonly surfaceVariant: string = '#FFE5E7EB'
  readonly outline: string = '#FFD1D5DB'
  readonly onPrimary: string = '#FFFFFFFF'
  readonly onSecondary: string = '#FFFFFFFF'
  readonly onBackground: string = '#FF111827'
  readonly onSurface: string = '#FF1F2937'
}

class TextStyleToken {
  readonly size: number
  readonly weight: FontWeight

  constructor(size: number, weight: FontWeight) {
    this.size = size
    this.weight = weight
  }
}

class TypographyTokens {
  readonly displayLarge: TextStyleToken = new TextStyleToken(28, FontWeight.Bold)
  readonly titleMedium: TextStyleToken = new TextStyleToken(16, FontWeight.Medium)
  readonly bodyMedium: TextStyleToken = new TextStyleToken(14, FontWeight.Normal)
}

class ShapeTokens {
  readonly medium: number = 12
  readonly large: number = 16
}

class SpacingTokens {
  readonly xs: number = 4
  readonly md: number = 12
  readonly lg: number = 16
  readonly xxl: number = 36
}

class AppTokens {
  static readonly Colors: ColorTokens = new ColorTokens()
  static readonly Typography: TypographyTokens = new TypographyTokens()
  static readonly Shapes: ShapeTokens = new ShapeTokens()
  static readonly Spacing: SpacingTokens = new SpacingTokens()
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
          .width('100%')
          .textAlign(TextAlign.Center)
          .fontSize(AppTokens.Typography.displayLarge.size)
          .fontWeight(AppTokens.Typography.displayLarge.weight)
          .fontColor(AppTokens.Colors.onBackground)

        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.items, (medicine: Medicine) => {
              MedicineItem({ name: medicine.name, time: medicine.time })
            })
          }
          .width('100%')
          .padding({ bottom: AppTokens.Spacing.xxl })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')

        Row() {
          Button('Mark All Taken')
            .width('80%')
            .height(48)
            .fontSize(AppTokens.Typography.titleMedium.size)
            .fontWeight(AppTokens.Typography.titleMedium.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ bottom: 56 + AppTokens.Spacing.md })
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
        colors: [
          [AppTokens.Colors.surfaceVariant, 0.0],
          [AppTokens.Colors.surface, 1.0]
        ]
      })

      Column() {
        Blank()
        Row() {
          Text('Today')
            .width('33.33%')
            .textAlign(TextAlign.Center)
            .fontSize(AppTokens.Typography.titleMedium.size)
            .fontWeight(AppTokens.Typography.titleMedium.weight)
            .fontColor(AppTokens.Colors.primary)

          Text('History')
            .width('33.33%')
            .textAlign(TextAlign.Center)
            .fontSize(AppTokens.Typography.titleMedium.size)
            .fontWeight(AppTokens.Typography.titleMedium.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Text('Profile')
            .width('33.33%')
            .textAlign(TextAlign.Center)
            .fontSize(AppTokens.Typography.titleMedium.size)
            .fontWeight(AppTokens.Typography.titleMedium.weight)
            .fontColor(AppTokens.Colors.onSurface)
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
        .width(56)
        .height(56)
        .fontSize(AppTokens.Typography.displayLarge.size)
        .fontWeight(AppTokens.Typography.displayLarge.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(28)
        .margin({ right: AppTokens.Spacing.lg, bottom: 56 + AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
