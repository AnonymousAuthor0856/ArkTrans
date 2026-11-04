class AppColors {
  static primary: string = '#111827'
  static secondary: string = '#374151'
  static tertiary: string = '#6B7280'
  static background: string = '#F9FAFB'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#E5E7EB'
  static outline: string = '#D1D5DB'
  static success: string = '#16A34A'
  static warning: string = '#F59E0B'
  static error: string = '#EF4444'
  static onPrimary: string = '#FFFFFF'
  static onSecondary: string = '#FFFFFF'
  static onTertiary: string = '#111827'
  static onBackground: string = '#111827'
  static onSurface: string = '#1F2937'
}

class AppSpacing {
  static xs: number = 4
  static sm: number = 8
  static md: number = 12
  static lg: number = 16
  static xl: number = 24
  static xxl: number = 36
}

class AppShape {
  static small: number = 8
  static medium: number = 12
  static large: number = 16
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

@Entry
@Component
struct Index {
  private medicines: Medicine[] = [
    new Medicine(1, 'Vitamin C', '08:00 AM'),
    new Medicine(2, 'Aspirin', '12:30 PM'),
    new Medicine(3, 'Insulin', '06:00 PM'),
    new Medicine(4, 'Melatonin', '10:00 PM')
  ]

  @Builder
  MedicineItem(medicine: Medicine) {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text(medicine.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(medicine.time)
          .fontSize(14)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Circle()
        .width(16)
        .height(16)
        .fill(AppColors.primary)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: AppShape.medium })
  }

  @Builder
  MedicineList() {
    Scroll() {
      Column({ space: AppSpacing.md }) {
        ForEach(this.medicines, (item: Medicine) => {
          this.MedicineItem(item)
        })
        Blank()
          .height(AppSpacing.xxl)
      }
      .width('100%')
    }
    .width('100%')
    .layoutWeight(1)
    .scrollBar(BarState.Off)
  }

  @Builder
  BottomBar() {
    Row() {
      Text('Today')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('History')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Profile')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#24111827', offsetY: -4 })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column({ space: AppSpacing.md }) {
        Text('Medicine Reminder')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)

        this.MedicineList()

        Button('Mark All Taken')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .width('80%')
          .height(48)
          .backgroundColor(AppColors.secondary)
          .borderRadius(AppShape.large)
          .margin({ bottom: AppSpacing.md })
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.lg, bottom: 56 })
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        angle: 180,
        colors: [[AppColors.surfaceVariant, 0.0], [AppColors.surface, 1.0]]
      })

      Column() {
        Blank()
          .layoutWeight(1)
        this.BottomBar()
      }
      .width('100%')
      .height('100%')

      Button('+')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(AppColors.primary)
        .margin(AppSpacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
