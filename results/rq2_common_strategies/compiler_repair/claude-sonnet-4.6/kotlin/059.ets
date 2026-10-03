import { router } from '@kit.ArkUI';

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
];

@Component
struct MedicineItem {
  medicine: Medicine = { id: 0, name: '', time: '' };

  build() {
    Row() {
      Column() {
        Text(this.medicine.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1F2937')
        Text(this.medicine.time)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#1F2937')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)

      Circle({ width: 16, height: 16 })
        .fill('#111827')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#D1D5DB' })
    .padding(12)
  }
}

@Component
struct MedicineList {
  build() {
    List({ space: 12 }) {
      ForEach(medicines, (item: Medicine) => {
        ListItem() {
          MedicineItem({ medicine: item })
        }
      }, (item: Medicine) => item.id.toString())
    }
    .width('100%')
    .layoutWeight(1)
    .padding({ bottom: 36 })
  }
}

@Entry
@Component
struct RootScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Main content area
        Column() {
          Text('Medicine Reminder')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#111827')
            .margin({ bottom: 12 })

          MedicineList()

          Blank().height(12)

          Button('Mark All Taken')
            .width('80%')
            .height(48)
            .borderRadius(16)
            .backgroundColor('#374151')
            .fontColor('#FFFFFF')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 12 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Start)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#E5E7EB', 0.0], ['#FFFFFF', 1.0]]
        })

        // Bottom bar
        Row() {
          Text('Today')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#111827')

          Text('History')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1F2937')

          Text('Profile')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1F2937')
        }
        .width('100%')
        .height(60)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFFFFF')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F9FAFB')

      // Floating Action Button
      Button('+')
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor('#111827')
        .fontColor('#FFFFFF')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 80, right: 16 })
        .position({ x: '80%', y: '80%' })
    }
    .width('100%')
    .height('100%')
  }
}