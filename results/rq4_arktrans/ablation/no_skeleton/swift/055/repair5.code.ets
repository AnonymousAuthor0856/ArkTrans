@Entry
@Component
struct RootScreen {
  // Constants matching SwiftUI layout dimensions
  private topBarHeight: number = 64
  private bottomBarHeight: number = 80
  private fabSize: number = 56

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // === Main Content Layer ===
      Column() {
        // Top Spacer to account for Top Bar
        Blank().height(this.topBarHeight)

        // "Sign In to Continue" Text
        Text('Sign In to Continue')
          .fontSize(20)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#1E293B')

        // Workout Preview Box
        Column() {
          Text('Workout Preview')
            .fontSize(14)
            .fontColor('#1E293B')
        }
        .width('100%')
        .height(200)
        .backgroundColor('#FFF')
        .borderRadius(16)
        .border({ width: 1, color: '#CBD5E1' })

        // Authenticate Button
        Button() {
          Text('Authenticate')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFF')
        }
        .width('80%')
        .height(52)
        .backgroundColor('#FF2563EB')
        .borderRadius(16)

        // Bottom Spacer
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16 })
      .linearGradient({
        angle: 90,
        colors: [
          ['#38BDF8', 0.1],
          ['#FF2563EB', 0.15]
        ]
      })
      .backgroundColor('#F8FAFC')
      .padding({ bottom: this.bottomBarHeight })

      // === Top Bar Layer ===
      Column() {
        Text('Workout Plan')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
      }
      .width('100%')
      .height(this.topBarHeight)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor('#FFF')
      .position({ x: 0, y: 0 })

      // === Bottom Bar Layer ===
      Column() {
        Row() {
          Text('Home')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF2563EB')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('Plan')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('Profile')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .padding({ left: 16, right: 16 })
      }
      .width('100%')
      .height(this.bottomBarHeight)
      .backgroundColor('#FFF')
      .shadow({ radius: 8, color: 'rgba(15, 23, 42, 0.14)', offsetY: 4 })
      .position({ x: 0, y: 0 })
      .alignSelf(ItemAlign.End)

      // === FAB (Floating Action Button) Layer ===
      Button() {
        Text('+')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFF')
      }
      .width(this.fabSize)
      .height(this.fabSize)
      .backgroundColor('#FF2563EB')
      .borderRadius(this.fabSize / 2)
      .margin({ right: 16, bottom: this.bottomBarHeight + 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}