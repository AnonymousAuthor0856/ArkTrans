class AppColors {
  static readonly primary: string = '#111827'
  static readonly secondary: string = '#374151'
  static readonly tertiary: string = '#6B7280'
  static readonly background: string = '#F9FAFB'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E5E7EB'
  static readonly outline: string = '#D1D5DB'
  static readonly success: string = '#16A34A'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#111827'
  static readonly onBackground: string = '#111827'
  static readonly onSurface: string = '#1F2937'
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

class AppElevation {
  static readonly level2Radius: number = 8
  static readonly level2Dy: number = -4
  static readonly level2Color: string = '#24000000'
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
  medicine: Medicine = new Medicine(0, '', '')

  build() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text(this.medicine.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(20)

        Text(this.medicine.time)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .lineHeight(18)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('')
        .width(16)
        .height(16)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: AppShapes.medium
    })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MedicineList {
  items: Medicine[] = [
    new Medicine(1, 'Vitamin C', '08:00 AM'),
    new Medicine(2, 'Aspirin', '12:30 PM'),
    new Medicine(3, 'Insulin', '06:00 PM'),
    new Medicine(4, 'Melatonin', '10:00 PM')
  ]

  build() {
    Scroll() {
      Column({ space: AppSpacing.md }) {
        ForEach(this.items, (item: Medicine) => {
          MedicineItem({ medicine: item })
        }, (item: Medicine) => item.id.toString())
      }
      .width('100%')
      .padding({ bottom: AppSpacing.xxl })
    }
    .width('100%')
    .layoutWeight(1)
    .scrollBar(BarState.Off)
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column({ space: 0 }) {
        Column({ space: AppSpacing.md }) {
          Text('Medicine Reminder')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
            .textAlign(TextAlign.Center)
            .width('100%')

          MedicineList()

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('Mark All Taken')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
          }
          .width('80%')
          .height(48)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppShapes.large)
          .alignSelf(ItemAlign.Center)
          .margin({ bottom: AppSpacing.md })
          .onClick(() => {
          })
        }
        .width('100%')
        .height('100%')
        .padding({
          top: AppSpacing.lg,
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          bottom: 56
        })
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [AppColors.surfaceVariant, 0.0],
            [AppColors.surface, 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Row() {
        Text('Today')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)

        Blank()

        Text('History')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Blank()

        Text('Profile')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .backgroundColor(AppColors.surface)
      .alignItems(VerticalAlign.Center)
      .shadow({
        radius: AppElevation.level2Radius,
        color: AppElevation.level2Color,
        offsetX: 0,
        offsetY: AppElevation.level2Dy
      })

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('+')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onPrimary)
          .textAlign(TextAlign.Center)
      }
      .width(56)
      .height(56)
      .backgroundColor(AppColors.primary)
      .borderRadius(28)
      .margin({
        right: AppSpacing.lg,
        bottom: AppSpacing.lg
      })
      .onClick(() => {
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}