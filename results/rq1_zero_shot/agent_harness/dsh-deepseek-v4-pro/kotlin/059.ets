const Colors = {
  primary: '#111827',
  secondary: '#374151',
  tertiary: '#6B7280',
  background: '#F9FAFB',
  surface: '#FFFFFF',
  surfaceVariant: '#E5E7EB',
  outline: '#D1D5DB',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#111827',
  onBackground: '#111827',
  onSurface: '#1F2937'
}

interface Medicine {
  id: number
  name: string
  time: string
}

@Entry
@Component
struct Index {
  private medicines: Medicine[] = [
    { id: 1, name: 'Vitamin C', time: '08:00 AM' },
    { id: 2, name: 'Aspirin', time: '12:30 PM' },
    { id: 3, name: 'Insulin', time: '06:00 PM' },
    { id: 4, name: 'Melatonin', time: '10:00 PM' }
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column({ space: 12 }) {
          Text('Medicine Reminder')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onBackground)

          Column({ space: 12 }) {
            ForEach(this.medicines, (m: Medicine) => {
              Row() {
                Column({ space: 4 }) {
                  Text(m.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text(m.time)
                    .fontSize(14)
                    .fontColor(Colors.onSurface)
                }
                .alignItems(HorizontalAlign.Start)

                Stack().width(16).height(16).backgroundColor(Colors.primary).borderRadius(8)
              }
              .width('100%')
              .padding(12)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .backgroundColor(Colors.surface)
              .borderRadius(12)
              .border({ width: 1, color: Colors.outline })
            }, (m: Medicine) => m.id.toString())
          }

          Blank().height(12)

          Button('Mark All Taken', { type: ButtonType.Normal })
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .backgroundColor(Colors.secondary)
            .fontColor(Colors.onSecondary)
            .borderRadius(16)
            .width('80%')
            .height(48)
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .alignItems(HorizontalAlign.Center)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#E5E7EB', 0.0], ['#FFFFFF', 1.0]]
        })

        Row() {
          Text('Today').fontSize(16).fontWeight(FontWeight.Medium).fontColor(Colors.primary)
          Text('History').fontSize(16).fontWeight(FontWeight.Medium).fontColor(Colors.onSurface)
          Text('Profile').fontSize(16).fontWeight(FontWeight.Medium).fontColor(Colors.onSurface)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(Colors.surface)
        .shadow({ radius: 8, color: '#00000024', offsetX: 0, offsetY: 4 })
      }
      .width('100%')
      .height('100%')

      Button('+', { type: ButtonType.Normal })
        .width(56)
        .height(56)
        .borderRadius(28)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .backgroundColor(Colors.primary)
        .fontColor(Colors.onPrimary)
        .margin({ right: 16, bottom: 72 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
