interface Medicine {
  id: number
  name: string
  time: string
}

class AppColors {
  static readonly primary: string = '#111827'
  static readonly backgroundTop: string = '#E5E7EB'
  static readonly backgroundBottom: string = '#FFFFFF'
  static readonly surface: string = '#FFFFFF'
  static readonly outline: string = '#D1D5DB'
  static readonly onSurface: string = '#1F2937'
  static readonly onPrimary: string = '#FFFFFF'
}

@Entry
@Component
struct MedicineReminderPage {
  private medicines: Medicine[] = [
    { id: 1, name: 'Vitamin C', time: '08:00 AM' },
    { id: 2, name: 'Aspirin', time: '12:30 PM' },
    { id: 3, name: 'Insulin', time: '06:00 PM' },
    { id: 4, name: 'Melatonin', time: '10:00 PM' }
  ]

  @Builder
  MedicineItem(item: Medicine) {
    Row() {
      Column({ space: 10 }) {
        Text(item.name)
          .fontSize(30)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(36)

        Text(item.time)
          .fontSize(28)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .lineHeight(34)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Circle()
        .width(32)
        .height(32)
        .fill(AppColors.primary)
        .margin({ right: 10 })
    }
    .width('100%')
    .height(126)
    .padding({ left: 24, right: 14, top: 20, bottom: 18 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .border({
      width: 1.5,
      color: AppColors.outline,
      radius: 22
    })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Text('Medicine Reminder')
          .fontSize(56)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .lineHeight(68)
          .textAlign(TextAlign.Center)
          .width('100%')
          .margin({ top: 32, bottom: 20 })

        List({ space: 24 }) {
          ForEach(this.medicines, (item: Medicine) => {
            ListItem() {
              this.MedicineItem(item)
            }
          }, (item: Medicine) => item.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .padding({ left: 32, right: 32, bottom: 36 })

        Row() {
          Text('Today')
            .fontSize(30)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)

          Text('History')
            .fontSize(30)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text('Profile')
            .fontSize(30)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(160)
        .padding({ left: 40, right: 40, bottom: 14 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 180,
        colors: [[AppColors.backgroundTop, 0.0], [AppColors.backgroundBottom, 0.58]]
      })

      Button({ type: ButtonType.Circle }) {
        Text('+')
          .fontSize(54)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onPrimary)
          .lineHeight(62)
      }
      .width(112)
      .height(112)
      .backgroundColor(AppColors.primary)
      .shadow({
        radius: 18,
        color: '#33000000',
        offsetX: 0,
        offsetY: 8
      })
      .margin({ right: 32, bottom: 192 })
    }
    .width('100%')
    .height('100%')
  }
}
