@Entry
@Component
struct Index {
  private topBarHeight: number = 48
  private bottomBarHeight: number = 60
  private fabSize: number = 56

  build() {
    Stack() {
      // WindowGroup content
      Stack({ alignContent: Alignment.BottomEnd }) {
        // Main Content Column
        Column() {
          Blank().height(this.topBarHeight)

          Text('Sign In to Continue')
            .fontColor('#1E293B')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          // Workout Preview Card
          Stack() {
            Text('Workout Preview')
              .fontColor('#1E293B')
              .fontSize(14)
            
            Rect()
              .width('100%')
              .height('100%')
              .border({ width: 1, color: '#CBD5E1' })
              .borderRadius(16)
          }
          .width('100%')
          .height(200)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .margin({ top: 16, bottom: 16 })

          Button() {
            Text('Authenticate')
              .fontColor('#FFFFFF')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Center)
          }
          .width('80%')
          .height(52)
          .backgroundColor('#2563EB')
          .borderRadius(16)
          .margin({ top: 16 })

          Blank()

          // Gradient Background Overlay (Simulated with a colored rect for ArkTS compatibility as LinearGradient is complex without specific props)
          Column() {
            // Placeholder for gradient effect if needed, usually handled by background modifier in newer API versions
            // For strict compilation based on skeleton structure:
          }
          .width('100%')
          .height('100%')
          .position({ x: 0, y: 0 })
          .zIndex(-1)

        }
        .width('100%')
        .height('100%')
        .padding({ bottom: this.bottomBarHeight })
        .backgroundColor('#F8FAFC')

        // Top Bar
        Column() {
          Text('Workout Plan')
            .fontColor('#0F172A')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .height(this.topBarHeight)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 16 })
        .backgroundColor('#FFFFFF')
        .position({ x: 0, y: 0 })

        // Bottom Bar
        Column() {
          Row() {
            Text('Home')
              .fontColor('#2563EB')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)

            Text('Plan')
              .fontColor('#1E293B')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)

            Text('Profile')
              .fontColor('#1E293B')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .height(this.bottomBarHeight)
          .backgroundColor('#FFFFFF')
          .shadow({ radius: 10, color: '#00000010', offsetY: -2 })
        }
        .width('100%')
        .position({ x: 0, y: 0 })
        .alignSelf(ItemAlign.End)

        // FAB Button
        Button() {
          Text('+')
            .fontColor('#FFFFFF')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
        }
        .width(this.fabSize)
        .height(this.fabSize)
        .backgroundColor('#2563EB')
        .borderRadius(this.fabSize / 2)
        .margin({ bottom: this.bottomBarHeight + 12, right: 12 })
        .position({ x: 0, y: 0 })
        .alignSelf(ItemAlign.End)
        
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}