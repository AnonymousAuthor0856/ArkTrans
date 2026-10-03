@Entry
@Component
struct WorkoutPlanScreen {
  build() {
    Stack() {
      // === Main Content Column ===
      Column() {
        // Top App Bar
        Row() {
          Text('Workout Plan')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)

        // Scrollable Body
        Scroll() {
          Column({ space: 16 }) {
            // Sign In Text
            Text('Sign In to Continue')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1E293B')
              .textAlign(TextAlign.Center)

            // Preview Box
            Column() {
              Text('Workout Preview')
                .fontSize(14)
                .fontColor('#1E293B')
            }
            .width('100%')
            .height(200)
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .border({ width: 1, color: '#CBD5E1' })
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)

            // Authenticate Button
            Button('Authenticate')
              .width('80%')
              .height(52)
              .backgroundColor('#2563EB')
              .fontColor('#FFFFFF')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .borderRadius(16)
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 80 })
        }
        .layoutWeight(1)
        .backgroundColor('#F8FAFC')
        
        // Bottom Navigation Bar
        Row() {
          Text('Home')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#2563EB')
          
          Blank()
          
          Text('Plan')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')
            
          Blank()
          
          Text('Profile')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')
        }
        .width('100%')
        .height(64)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFFFFF')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height('100%')

      // Floating Action Button
      Button('+')
        .width(56)
        .height(56)
        .backgroundColor('#2563EB')
        .fontColor('#FFFFFF')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .borderRadius(28)
        .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })
        .position({ x: 'calc(100% - 64px)', y: 'calc(100% - 120px)' })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [['#38BDF8', 0.1], ['#2563EB', 0.15]]
    })
  }
}