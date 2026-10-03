// AppTokens - design tokens
class AppColors {
  static readonly primary: string = '#111827';
  static readonly secondary: string = '#374151';
  static readonly tertiary: string = '#6B7280';
  static readonly background: string = '#F9FAFB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

// Data model
interface Medicine {
  id: number;
  name: string;
  time: string;
}

// MedicineItem component
@Component
struct MedicineItem {
  @Prop medicine: Medicine;

  build() {
    Row() {
      Column() {
        Text(this.medicine.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(this.medicine.time)
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .margin({ top: AppSpacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Circle({ width: 16, height: 16 })
        .fill(AppColors.primary)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({ width: 1, color: AppColors.outline, radius: AppShapes.medium })
  }
}

// MedicineList component
@Component
struct MedicineList {
  private items: Medicine[] = [
    { id: 1, name: 'Vitamin C', time: '08:00 AM' },
    { id: 2, name: 'Aspirin', time: '12:30 PM' },
    { id: 3, name: 'Insulin', time: '06:00 PM' },
    { id: 4, name: 'Melatonin', time: '10:00 PM' }
  ];

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
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
  }
}

// RootScreen
@Entry
@Component
struct RootScreen {
  build() {
    Stack() {
      Column() {
        Column({ space: AppSpacing.md }) {
          Text('Medicine Reminder')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)

          MedicineList()
            .layoutWeight(1)

          Button('Mark All Taken')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .height(48)
            .width('80%')
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.large)
            .margin({ bottom: AppSpacing.md })
        }
        .width('100%')
        .height('100%')
        .padding({ top: AppSpacing.lg, left: AppSpacing.lg, right: AppSpacing.lg })
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [[AppColors.surfaceVariant, 0], [AppColors.surface, 1]]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      // BottomAppBar
      Column() {
        Blank()
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
      }
      .width('100%')
      .height('100%')

      // FloatingActionButton
      Column() {
        Blank()
        Row() {
          Blank()
          Button('+')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onPrimary)
            .width(56)
            .height(56)
            .backgroundColor(AppColors.primary)
            .borderRadius(28)
            .margin({ right: AppSpacing.lg, bottom: 28 })
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
