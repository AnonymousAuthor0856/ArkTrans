@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Top App Bar ===
      Column() {
        Text('Workout Plan')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .textAlign(TextAlign.Center)
          .width('100%')
          .height(64)
      }.width('100%').backgroundColor('#FFFFFF')

      // === Main Content ===
      Column({ space: 16 }) {
        Text('Sign In to Continue')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .textAlign(TextAlign.Center)

        // Preview Box
        Stack({ alignContent: Alignment.Center }) {
          Text('Workout Preview')
            .fontSize(16)
            .fontColor('#1E293B')
        }
        .width('100%')
        .height(200)
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .border({ width: 1, color: '#CBD5E1' })

        // Authenticate Button
        Button() {
          Text('Authenticate')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .width('80%')
        .height(52)
        .backgroundColor('#2563EB')
        .borderRadius(26)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#E0F2FE', 0], ['#DBEAFE', 1]]
      })

      // === FAB ===
      Button() {
        Text('+')
          .fontSize(40)
          .fontColor('#FFFFFF')
          .lineHeight(40)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor('#2563EB')
      .shadow({ radius: 8, color: '#000000', offsetX: 0, offsetY: 4 })
      .position({ x: 'auto', y: 'auto' })
      .margin({ right: 24, bottom: 80 })
      .alignSelf(ItemAlign.End)

      // === Bottom Navigation ===
      Row({ space: 0 }) {
        Text('Home')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2563EB')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        
        Text('Plan')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
          
        Text('Profile')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E293B')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .height(80)
      .padding({ top: 16, bottom: 16 })
      .backgroundColor('#F8FAFC')
      .alignSelf(ItemAlign.End)
    }
    .width('100%')
    .height('100%')
  }
}