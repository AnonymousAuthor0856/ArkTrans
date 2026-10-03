class AppColors {
  static primary: string = '#111827';
  static secondary: string = '#374151';
  static tertiary: string = '#6B7280';
  static background: string = '#F9FAFB';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E5E7EB';
  static outline: string = '#D1D5DB';
  static success: string = '#16A34A';
  static warning: string = '#F59E0B';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#FFFFFF';
  static onTertiary: string = '#111827';
  static onBackground: string = '#111827';
  static onSurface: string = '#1F2937';
}

class AppSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 36;
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

@Entry
@Component
struct RootScreen {
  private items: Medicine[] = [
    new Medicine(1, 'Vitamin C', '08:00 AM'),
    new Medicine(2, 'Aspirin', '12:30 PM'),
    new Medicine(3, 'Insulin', '06:00 PM'),
    new Medicine(4, 'Melatonin', '10:00 PM')
  ];

  @Builder
  private MedicineItem(medicine: Medicine) {
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
      Circle()
        .width(16)
        .height(16)
        .fill(AppColors.primary)
    }
    .padding(AppSpacing.md)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  private MedicineList() {
    Scroll() {
      Column({ space: AppSpacing.md }) {
        ForEach(this.items, (item: Medicine) => {
          this.MedicineItem(item)
        })
      }
      .padding({ bottom: AppSpacing.xxl })
      .width('100%')
    }
    .layoutWeight(1)
    .scrollBar(BarState.Off)
  }

  @Builder
  private BottomBar() {
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
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .width('100%')
    .height(56)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#00000024', offsetX: 0, offsetY: 4 })
  }

  @Builder
  private FloatingActionButton() {
    Button('+')
      .width(56)
      .height(56)
      .fontSize(28)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onPrimary)
      .backgroundColor(AppColors.primary)
      .borderRadius(28)
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        Column({ space: AppSpacing.md }) {
          Text('Medicine Reminder')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)

          this.MedicineList()

          Button('Mark All Taken')
            .width('80%')
            .height(48)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(16)
            .margin({ bottom: AppSpacing.md })
        }
        .padding({ top: AppSpacing.lg, left: AppSpacing.lg, right: AppSpacing.lg, bottom: 56 })
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.surfaceVariant)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Column() {
        Blank()
        this.BottomBar()
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        Row() {
          Blank()
          this.FloatingActionButton()
            .margin(AppSpacing.lg)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
