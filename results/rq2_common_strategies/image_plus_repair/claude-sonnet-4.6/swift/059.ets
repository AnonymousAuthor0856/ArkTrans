// AppTokens
const ColorPrimary: string = '#111827';
const ColorSecondary: string = '#374151';
const ColorTertiary: string = '#6B7280';
const ColorBackground: string = '#F9FAFB';
const ColorSurface: string = '#FFFFFF';
const ColorSurfaceVariant: string = '#E5E7EB';
const ColorOutline: string = '#D1D5DB';
const ColorSuccess: string = '#16A34A';
const ColorWarning: string = '#F59E0B';
const ColorError: string = '#EF4444';
const ColorOnPrimary: string = '#FFFFFF';
const ColorOnSecondary: string = '#FFFFFF';
const ColorOnTertiary: string = '#111827';
const ColorOnBackground: string = '#111827';
const ColorOnSurface: string = '#1F2937';

const SpacingXs: number = 4;
const SpacingSm: number = 8;
const SpacingMd: number = 12;
const SpacingLg: number = 16;
const SpacingXl: number = 24;
const SpacingXxl: number = 36;

const ShapeSmall: number = 8;
const ShapeMedium: number = 12;
const ShapeLarge: number = 16;

interface Medicine {
  id: number;
  name: string;
  time: string;
}

const medicines: Medicine[] = [
  { id: 1, name: 'Vitamin C', time: '08:00 AM' },
  { id: 2, name: 'Aspirin', time: '12:30 PM' },
  { id: 3, name: 'Insulin', time: '06:00 PM' },
  { id: 4, name: 'Melatonin', time: '10:00 PM' },
]

@Component
struct MedicineItem {
  medicine: Medicine = { id: 0, name: '', time: '' };

  build() {
    Row() {
      Column() {
        Text(this.medicine.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColorOnSurface)
        Text(this.medicine.time)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(ColorOnSurface)
          .margin({ top: SpacingXs })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Circle()
        .width(16)
        .height(16)
        .fill(ColorPrimary)
    }
    .width('100%')
    .padding(SpacingMd)
    .backgroundColor(ColorSurface)
    .borderRadius(ShapeMedium)
    .border({ width: 1, color: ColorOutline, radius: ShapeMedium })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MedicineList {
  build() {
    Scroll() {
      Column({ space: SpacingMd }) {
        ForEach(medicines, (item: Medicine) => {
          MedicineItem({ medicine: item })
        }, (item: Medicine) => item.id.toString())
      }
      .width('100%')
      .padding({ bottom: SpacingXxl })
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
        Column({ space: SpacingMd }) {
          Text('Medicine Reminder')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(ColorOnBackground)
            .textAlign(TextAlign.Center)
            .width('100%')

          MedicineList()

          Button('Mark All Taken')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColorOnSecondary)
            .height(48)
            .width('80%')
            .backgroundColor(ColorSecondary)
            .borderRadius(ShapeLarge)
            .margin({ bottom: SpacingMd })
        }
        .padding({
          top: SpacingLg,
          left: SpacingLg,
          right: SpacingLg,
          bottom: 56
        })
        .width('100%')
        .layoutWeight(1)
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
            .fontColor(ColorPrimary)

          Blank()

          Text('History')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColorOnSurface)

          Blank()

          Text('Profile')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColorOnSurface)
        }
        .padding({ left: SpacingLg, right: SpacingLg })
        .width('100%')
        .height(56)
        .backgroundColor(ColorSurface)
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
      .backgroundColor(ColorBackground)

      // Floating Action Button
      Button('+')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(ColorOnPrimary)
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(ColorPrimary)
        .margin({ right: SpacingLg, bottom: 56 + SpacingLg })
    }
    .width('100%')
    .height('100%')
  }
}