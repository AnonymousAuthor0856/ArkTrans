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

class MedicineColors {
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

@Entry
@Component
struct Index {
  private items: Medicine[] = [
    new Medicine(1, 'Vitamin C', '08:00 AM'),
    new Medicine(2, 'Aspirin', '12:30 PM'),
    new Medicine(3, 'Insulin', '06:00 PM'),
    new Medicine(4, 'Melatonin', '10:00 PM')
  ];

  @Builder
  MedicineItem(item: Medicine) {
    Row() {
      Column() {
        Text(item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(MedicineColors.onSurface)
        Text(item.time)
          .fontSize(14)
          .fontColor(MedicineColors.onSurface)
          .margin({ top: 4 })
      }
      .layoutWeight(1)

      Circle()
        .width(16)
        .height(16)
        .fill(MedicineColors.primary)
    }
    .width('100%')
    .padding(12)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(MedicineColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: MedicineColors.outline })
  }

  @Builder
  BottomBar() {
    Row() {
      Text('Today')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(MedicineColors.primary)
      Text('History')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(MedicineColors.onSurface)
      Text('Profile')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(MedicineColors.onSurface)
    }
    .width('100%')
    .height(64)
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(MedicineColors.surface)
    .shadow({ radius: 8, color: '#24000000', offsetX: 0, offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Text('Medicine Reminder')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(MedicineColors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Center)
          .margin({ bottom: 12 })

        Scroll() {
          Column() {
            ForEach(this.items, (item: Medicine) => {
              Column() {
                this.MedicineItem(item)
              }
              .margin({ bottom: 12 })
            }, (item: Medicine) => item.id.toString())

            Button('Mark All Taken')
              .width('80%')
              .height(48)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(MedicineColors.onSecondary)
              .backgroundColor(MedicineColors.secondary)
              .borderRadius(16)
              .alignSelf(ItemAlign.Center)
              .margin({ top: 4, bottom: 96 })
          }
          .width('100%')
        }
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 64 })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[MedicineColors.surfaceVariant, 0.0], [MedicineColors.surface, 1.0]]
      })

      Column() {
        this.BottomBar()
      }
      .width('100%')
      .align(Alignment.Bottom)

      Button('+')
        .width(56)
        .height(56)
        .borderRadius(28)
        .fontSize(28)
        .fontColor(MedicineColors.onPrimary)
        .backgroundColor(MedicineColors.primary)
        .margin({ right: 24, bottom: 76 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(MedicineColors.background)
  }
}
