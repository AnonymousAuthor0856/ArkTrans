// AppTokens
const primaryColor: string = '#FF111827';
const secondaryColor: string = '#FF374151';
const tertiaryColor: string = '#FF6B7280';
const backgroundColor: string = '#FFF9FAFB';
const surfaceColor: string = '#FFFFFFFF';
const surfaceVariantColor: string = '#FFE5E7EB';
const outlineColor: string = '#FFD1D5DB';
const successColor: string = '#FF16A34A';
const warningColor: string = '#FFF59E0B';
const errorColor: string = '#FFEF4444';
const onPrimaryColor: string = '#FFFFFFFF';
const onSecondaryColor: string = '#FFFFFFFF';
const onTertiaryColor: string = '#FF111827';
const onBackgroundColor: string = '#FF111827';
const onSurfaceColor: string = '#FF1F2937';

const spacingXs: number = 4;
const spacingSm: number = 8;
const spacingMd: number = 12;
const spacingLg: number = 16;
const spacingXl: number = 24;
const spacingXxl: number = 36;

const shapeSmall: number = 8;
const shapeMedium: number = 12;
const shapeLarge: number = 16;

interface Medicine {
  id: number;
  name: string;
  time: string;
}

const medicineItems: Medicine[] = [
  { id: 1, name: 'Vitamin C', time: '08:00 AM' },
  { id: 2, name: 'Aspirin', time: '12:30 PM' },
  { id: 3, name: 'Insulin', time: '06:00 PM' },
  { id: 4, name: 'Melatonin', time: '10:00 PM' },
];

@Component
struct MedicineItemView {
  medicine: Medicine = { id: 0, name: '', time: '' };

  build() {
    Row() {
      Column() {
        Text(this.medicine.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(onSurfaceColor)
          .margin({ bottom: spacingXs })

        Text(this.medicine.time)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(onSurfaceColor)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Circle()
        .width(16)
        .height(16)
        .fill(primaryColor)
    }
    .width('100%')
    .padding(spacingMd)
    .backgroundColor(surfaceColor)
    .borderRadius(shapeMedium)
    .border({ width: 1, color: outlineColor, radius: shapeMedium })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MedicineListView {
  build() {
    Scroll() {
      Column({ space: spacingMd }) {
        ForEach(medicineItems, (item: Medicine) => {
          MedicineItemView({ medicine: item })
        }, (item: Medicine) => item.id.toString())
      }
      .width('100%')
      .padding({ bottom: spacingXxl })
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
      // Main content
      Column() {
        // Top content area with gradient background
        Column({ space: spacingMd }) {
          Text('Medicine Reminder')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(onBackgroundColor)
            .width('100%')
            .textAlign(TextAlign.Start)

          MedicineListView()

          Button('Mark All Taken')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSecondaryColor)
            .height(48)
            .width('80%')
            .backgroundColor(secondaryColor)
            .borderRadius(shapeLarge)
            .margin({ bottom: spacingMd })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({
          top: spacingLg,
          left: spacingLg,
          right: spacingLg,
          bottom: 56
        })
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [[0xFFE5E7EB, 0.0], [0xFFFFFFFF, 1.0]]
        })
        .alignItems(HorizontalAlign.Center)

        // Bottom App Bar
        Row() {
          Text('Today')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(primaryColor)

          Blank()

          Text('History')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSurfaceColor)

          Blank()

          Text('Profile')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(onSurfaceColor)
        }
        .width('100%')
        .height(56)
        .padding({ left: spacingLg, right: spacingLg })
        .backgroundColor(surfaceColor)
        .shadow({
          color: '#24000000',
          radius: 8,
          offsetX: 0,
          offsetY: 4
        })
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(backgroundColor)

      // Floating Action Button
      Button('+')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(onPrimaryColor)
        .width(56)
        .height(56)
        .backgroundColor(primaryColor)
        .borderRadius(28)
        .margin({
          right: spacingLg,
          bottom: 56 + spacingLg
        })
    }
    .width('100%')
    .height('100%')
  }
}