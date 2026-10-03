@Entry
@Component
struct Index {
  build() {
    Stack() {
      Stack() {
        Column({ space: 0 }) {
          Row() {
            Column({ space: 2 }) {
              Text('Good Morning,')
                .fontColor('#808080')
                .fontSize(14)
              Text('Tea Master')
                .fontColor('#000000')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
            }.alignItems(HorizontalAlign.Start)
            Blank()
            Button() {}
          }

          Row({ space: 16 }) {
            Stack() {
              Circle()
                .width(60)
                .height(60)
                .fill(Color('#F0EBE7')) // Color(red: 0.94, green: 0.92, blue: 0.91) approx
              
              Image($r('app.media.startIcon')) // Using allowed resource
                .width(24)
                .height(24)
                .objectFit(ImageFit.Contain)
                .opacity(0)
            }

            Column({ space: 2 }) {
              Text('Earl Grey Reserve')
                .fontColor('#000000')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
              Text('Black Tea • 95°C')
                .fontColor('#8C6D63')
                .fontSize(12)
            }.alignItems(HorizontalAlign.Start)

            Blank()

            Image($r('app.media.startIcon')) // Placeholder for heart icon as only startIcon is allowed
              .width(24)
              .height(24)
              .fillColor('#FFCCD1')
          }
          .padding(20)
          .backgroundColor('#F5F5F5') // TeaColors.surfaceVariant approx
          .borderRadius(24)
          .border({ width: 1, color: '#E0E0E0', radius: 24 }) // TeaColors.outline approx

          Stack() {
            Circle()
              .width(220)
              .height(220)
              .stroke('#F4F4F4')
              .strokeWidth(12)

            Circle()
              .width(220)
              .height(220)
              .stroke('#6D4C3F')
              .strokeWidth(12)
              .lineCap(LineCap.Round)
              .trimRatio(0.66)
              .rotate({ angle: -210 })

            Column({ space: 4 }) {
              Text('Steeping')
                .fontColor('#808080')
                .letterSpacing(2)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
              
              Text('03:20') // Placeholder for time
                .fontColor('#000000')
                .fontSize(45)
                .fontWeight(FontWeight.Lighter)
            }
          }

          Row({ space: 24 }) {
            Button() {}
            Button() {}
            Button() {}
          }

          Blank()

          Column({ space: 0 }) {
            Text('PREPARATION')
              .fontColor('#A0A0A0') // .gray.opacity(0.8) approx
              .fontSize(11)
              .fontWeight(FontWeight.Bold)
              .padding({ bottom: 12 })

            StepItem({ step: '1', text: 'Boil fresh water to 95°C' })
            StepItem({ step: '2', text: 'Add 1 tsp of loose leaf per cup' })
            StepItem({ step: '3', text: 'Pour water and wait for timer' })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
        }
        .padding({ left: 24, right: 24 })
      }
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct StepItem {
  private step: string = ''
  private text: string = ''

  build() {
    Row() {
      Text(this.step)
        .width(24)
        .height(24)
        .textAlign(TextAlign.Center)
        .backgroundColor('#6D4C3F')
        .fontColor('#FFFFFF')
        .borderRadius(12)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
      
      Text(this.text)
        .margin({ left: 12 })
        .fontColor('#000000')
        .fontSize(14)
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
  }
}