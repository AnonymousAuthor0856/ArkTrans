class AppColors {
  static readonly primary: string = '#111827';
  static readonly secondary: string = '#374151';
  static readonly tertiary: string = '#6B7280';
  static readonly background: string = '#F9FAFB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#111827';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

class Medicine {
  id: number;
  name: string;
  time: string;

  constructor(id: number, name: string, time: string) {
    this.id = id;
    this.name = name;
    this.time = time;
  }
}

@Component
struct MedicineItem {
  medicine: Medicine = new Medicine(0, '', '');

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

      Stack()
        .width(16)
        .height(16)
        .borderRadius(8)
        .backgroundColor(AppColors.primary)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: 12
    })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MedicineList {
  medicines: Medicine[] = [];

  build() {
    Scroll() {
      Column({ space: AppSpacing.md }) {
        ForEach(this.medicines, (item: Medicine) => {
          MedicineItem({ medicine: item })
        }, (item: Medicine) => item.id.toString())
      }
      .width('100%')
      .padding({ bottom: AppSpacing.xxl })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      Text('Today')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .lineHeight(24)

      Text('History')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .lineHeight(24)

      Text('Profile')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .lineHeight(24)
    }
    .width('100%')
    .height(80)
    .padding({ left: AppSpacing.xl, right: AppSpacing.xl })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: 8,
      color: '#24000000',
      offsetX: 0,
      offsetY: -2
    })
  }
}

@Component
struct FloatingAddButton {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text('+')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .lineHeight(32)
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor(AppColors.primary)
    .shadow({
      radius: 12,
      color: '#33000000',
      offsetX: 0,
      offsetY: 6
    })
    .onClick(() => {
    })
  }
}

@Component
struct RootScreen {
  private medicines: Medicine[] = [
    new Medicine(1, 'Vitamin C', '08:00 AM'),
    new Medicine(2, 'Aspirin', '12:30 PM'),
    new Medicine(3, 'Insulin', '06:00 PM'),
    new Medicine(4, 'Melatonin', '10:00 PM')
  ];

  build() {
    Stack() {
      Column() {
        Column({ space: AppSpacing.md }) {
          Text('Medicine Reminder')
            .width('100%')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
            .lineHeight(34)
            .textAlign(TextAlign.Center)

          MedicineList({ medicines: this.medicines })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg,
          bottom: AppSpacing.lg
        })
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [AppColors.surfaceVariant, 0.0],
            [AppColors.surface, 1.0]
          ]
        })
        .clip(true)

        BottomNavigationBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      FloatingAddButton()
        .align(Alignment.BottomEnd)
        .margin({
          right: AppSpacing.lg,
          bottom: 96
        })
        .zIndex(2)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}