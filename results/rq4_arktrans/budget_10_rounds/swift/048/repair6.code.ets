@Entry
@Component
struct Index {
  build() {
    Stack() {
      // === ZStack ===
      Stack() {
        // === VStack (Background) ===
        Column() {
          // Gradient Background
          .linearGradient({
            angle: 90,
            colors: [['#F8FAFC', 0], ['#E2E8F0', 1]]
          })
          .width('100%')
          .height('100%')
          .alignItems(HorizontalAlign.Start)

          // Content Container
          Column() {
            // === Text (Title) ===
            Text('Live Shop Events')
              .fontColor('#1E3A8A')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 16 })

            // === ScrollView ===
            Scroll() {
              // === LazyVStack ===
              Column({ space: 16 }) {
                // === ForEach (Item 1) ===
                this.LiveCardItem({
                  title: 'Smartphone Flash Deal',
                  viewers: '1,234',
                  price: '$699'
                })

                // === ForEach (Item 2) ===
                this.LiveCardItem({
                  title: 'Gaming Chair Special',
                  viewers: '880',
                  price: '$299'
                })
                
                // Bottom padding for scroll
                Blank().height(100)
              }
              .padding(16)
              .width('100%')
            }
            .layoutWeight(1)
            .scrollBar(BarState.Off)
          }
          .width('100%')
          .height('100%')
          .padding({ left: 16, right: 16, top: 50 }) // Safe area approximation
        }

        // === VStack (Bottom Bar) ===
        Column() {
          Blank()
          Row() {
            Blank()
            Text('Home').fontColor('#1E3A8A').fontSize(14).fontWeight(FontWeight.Medium)
            Blank()
            Text('Live').fontColor('#0B1220').fontSize(14).fontWeight(FontWeight.Medium)
            Blank()
            Text('Cart').fontColor('#0B1220').fontSize(14).fontWeight(FontWeight.Medium)
            Blank()
            Text('Profile').fontColor('#0B1220').fontSize(14).fontWeight(FontWeight.Medium)
            Blank()
          }
          .width('100%')
          .height(60)
          .backgroundColor('#FFFFFF')
          .shadow({ radius: 10, color: '#0D000000', offsetY: -2 })
        }
        .width('100%')
        .height('100%')
        .alignItems(HorizontalAlign.Center)
        
        // === VStack (Floating Action Button) ===
        Column() {
          Blank()
          Row() {
            Blank()
            Button() {
              Text('+')
                .fontColor('#FFFFFF')
                .fontSize(32)
                .fontWeight(FontWeight.Lighter)
            }
            .type(ButtonType.Circle)
            .backgroundColor('#3B82F6')
            .width(56)
            .height(56)
            .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
            .margin({ right: 24, bottom: 80 })
          }
        }
        .width('100%')
        .height('100%')
        .alignItems(HorizontalAlign.End)

      }.width('100%').height('100%')
    }.width('100%').height('100%')
  }

  interface LiveCardItemParams {
    title: string;
    viewers: string;
    price: string;
  }

  @Builder
  LiveCardItem(item: LiveCardItemParams) {
    Column() {
      // Card Container
      Column({ space: 12 }) {
        // Image Placeholder
        Rect()
          .fill('#3B82F6')
          .borderRadius(16)
          .width('100%')
          .height(160)

        // Title
        Text(item.title)
          .fontColor('#0B1220')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Viewers
        Text(`${item.viewers} viewers`)
          .fontColor('#60A5FA')
          .fontSize(14)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Price and Button Row
        Row() {
          Text(item.price)
            .fontColor('#1E3A8A')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
          
          Blank()

          Button('Join Live')
            .type(ButtonType.Capsule)
            .backgroundColor('#1E3A8A')
            .fontColor('#FFFFFF')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .borderRadius(12)
            .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        }
        .width('100%')
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFF')
      .borderRadius(24)
      .shadow({ radius: 12, color: '#0D000000', offsetY: 4 })
    }
  }
}