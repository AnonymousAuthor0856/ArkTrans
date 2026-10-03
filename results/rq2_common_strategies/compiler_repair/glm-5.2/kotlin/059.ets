// MedicineReminder - ArkTS implementation

interface MedicineData {
  id: number;
  name: string;
  time: string;
}

class AppColors {
  static readonly primary: string = '#FF111827';
  static readonly secondary: string = '#FF374151';
  static readonly tertiary: string = '#FF6B7280';
  static readonly background: string = '#FFF9FAFB';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFE5E7EB';
  static readonly outline: string = '#FFD1D5DB';
  static readonly success: string = '#FF16A34A';
  static readonly warning: string = '#FFF59E0B';
  static readonly error: string = '#FFEF4444';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FFFFFFFF';
  static readonly onTertiary: string = '#FF111827';
  static readonly onBackground: string = '#FF111827';
  static readonly onSurface: string = '#FF1F2937';
}

class Spacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

class MedicineItem extends View {
  private m: MedicineData;

  constructor(m: MedicineData) {
    super();
    this.m = m;
  }

  build() {
    Row() {
      Column() {
        Text(this.m.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(this.m.time)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
          .margin({ top: Spacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Circle({ width: 16, height: 16 })
        .fill(AppColors.primary)
    }
    .width('100%')
    .padding(Spacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline, radius: 12 })
    .alignItems(VerticalAlign.Center)
  }
}

class MedicineList extends View {
  private items: MedicineData[] = [
    { id: 1, name: 'Vitamin C', time: '08:00 AM' },
    { id: 2, name: 'Aspirin', time: '12:30 PM' },
    { id: 3, name: 'Insulin', time: '06:00 PM' },
    { id: 4, name: 'Melatonin', time: '10:00 PM' }
  ];

  build() {
    Column() {
      ForEach(this.items, (item: MedicineData) => {
        MedicineItem(item)
      }, (item: MedicineData) => item.id.toString())
    }
    .width('100%')
    .layoutWeight(1)
  }
}

class RootScreen extends View {
  build() {
    Column() {
      // Header
      Text('Medicine Reminder')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .width('100%')
        .margin({ bottom: Spacing.md })

      // List
      MedicineList()

      // Button
      Button('Mark All Taken')
        .width('80%')
        .height(48)
        .backgroundColor(AppColors.secondary)
        .fontColor(AppColors.onSecondary)
        .borderRadius(16)
        .margin({ top: Spacing.md, bottom: Spacing.lg })
    }
    .width('100%')
    .height('100%')
    .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.lg, bottom: Spacing.lg })
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      RootScreen()

      // Floating Action Button
      Button('+')
        .width(56)
        .height(56)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .borderRadius(28)
        .shadow({ radius: 8, color: '#33000000', offsetX: 0, offsetY: 4 })
        .margin({ right: Spacing.lg, bottom: 80 })
    }
    .width('100%')
    .height('100%')
  }
}