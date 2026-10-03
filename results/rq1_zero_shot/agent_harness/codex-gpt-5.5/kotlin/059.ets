const NAME: string = "088_MedicineReminder_en";
const UI_TYPE: string = "Health ListDetail";
const STYLE_THEME: string = "Monochrome";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#111827';
  static readonly secondary: string = '#374151';
  static readonly background: string = '#F9FAFB';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E5E7EB';
  static readonly outline: string = '#D1D5DB';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onBackground: string = '#111827';
  static readonly onSurface: string = '#1F2937';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly md: number = 12;
  static readonly lg: number = 16;
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

@Entry
@Component
struct MainActivity {
  private items: Medicine[] = [
    new Medicine(1, 'Vitamin C', '08:00 AM'),
    new Medicine(2, 'Aspirin', '12:30 PM'),
    new Medicine(3, 'Insulin', '06:00 PM'),
    new Medicine(4, 'Melatonin', '10:00 PM')
  ];

  @Builder
  MedicineItem(item: Medicine) {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text(item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(item.time)
          .fontSize(14)
          .fontColor(AppColors.onSurface)
          .opacity(0.78)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Blank()
        .width(16)
        .height(16)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  BottomBar() {
    Row() {
      Text('Today')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
      Text('History')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
      Text('Profile')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(66)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#24000000', offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column({ space: AppSpacing.md }) {
        Text('Medicine Reminder')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .textAlign(TextAlign.Center)
          .width('100%')

        Scroll() {
          Column({ space: AppSpacing.md }) {
            ForEach(this.items, (item: Medicine) => {
              this.MedicineItem(item)
            })
            Blank().height(AppSpacing.xxl)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)

        Button('Mark All Taken')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSecondary)
          .width('80%')
          .height(48)
          .backgroundColor(AppColors.secondary)
          .borderRadius(16)
          .alignSelf(ItemAlign.Center)

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.lg })
      .backgroundColor(AppColors.background)
      .linearGradient({
        angle: 180,
        colors: [[AppColors.surfaceVariant, 0.0], [AppColors.surface, 1.0]]
      })

      Text('+')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .textAlign(TextAlign.Center)
        .width(56)
        .height(56)
        .lineHeight(56)
        .backgroundColor(AppColors.primary)
        .borderRadius(28)
        .shadow({ radius: 12, color: '#33000000', offsetY: 4 })
        .margin({ right: 20, bottom: 78 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
