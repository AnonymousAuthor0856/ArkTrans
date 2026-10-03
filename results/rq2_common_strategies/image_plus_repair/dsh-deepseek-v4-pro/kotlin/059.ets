@Entry
@Component
struct MedicineReminderPage {
  @State medicines: Medicine[] = [
    { id: 1, name: "Vitamin C", time: "08:00 AM" },
    { id: 2, name: "Aspirin", time: "12:30 PM" },
    { id: 3, name: "Insulin", time: "06:00 PM" },
    { id: 4, name: "Melatonin", time: "10:00 PM" }
  ];

  @Builder
  MedicineItemView(m: Medicine) {
    Row() {
      Column({ space: 4 }) {
        Text(m.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(m.time)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Row()
        .width(16)
        .height(16)
        .borderRadius(8)
        .backgroundColor(AppColors.primary)
    }
    .width('100%')
    .padding(12)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: AppColors.outline })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  MedicineListView() {
    List({ space: 12 }) {
      ForEach(this.medicines, (m: Medicine) => {
        ListItem() {
          this.MedicineItemView(m)
        }
      }, (m: Medicine) => m.id.toString())
    }
    .width('100%')
    .layoutWeight(1)
    .scrollBar(BarState.Off)
    .padding({ bottom: 36 })
  }

  @Builder
  BottomBar() {
    Row() {
      Text("Today")
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
      Text("History")
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
      Text("Profile")
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column({ space: 12 }) {
          Text("Medicine Reminder")
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)

          this.MedicineListView()

          Blank()
            .height(12)

          Button() {
            Text("Mark All Taken")
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
          }
          .width('80%')
          .height(48)
          .borderRadius(16)
          .backgroundColor(AppColors.secondary)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .linearGradient({
          angle: 180,
          colors: [[AppColors.surfaceVariant, 0.0], [AppColors.surface, 1.0]]
        })

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Button() {
        Text("+")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onPrimary)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(AppColors.primary)
      .margin({ right: 16, bottom: 72 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

interface Medicine {
  id: number;
  name: string;
  time: string;
}

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
