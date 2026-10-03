import { BusinessError } from '@kit.BasicServicesKit';

interface LiveItem {
  title: string;
  viewers: number;
  price: string;
}

@Entry
@Component
struct Index {
  // Mock data to satisfy ForEach requirements and make code compilable
  @State liveList: LiveItem[] = [
    { title: 'Summer Sale Live', viewers: 1200, price: '$99' },
    { title: 'New Arrivals', viewers: 850, price: '$49' },
    { title: 'Flash Deal', viewers: 3000, price: '$19' }
  ];

  build() {
    Stack() {
      // === ZStack ===
      Stack() {
        // === VStack (Main Content) ===
        Column() {
          // === Text ===
          Text('Live Shop Events')
            .fontColor('#1E3A8A')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)

          // === ScrollView / LazyVStack ===
          // Using List for LazyVStack behavior in ArkTS
          List({ space: 16 }) {
            ForEach(this.liveList, (item: LiveItem) => {
              ListItem() {
                // === VStack (Card) ===
                Column() {
                  // === Rectangle (Image Placeholder) ===
                  Rect()
                    .fill('#3B82F6')
                    .width('100%')
                    .height(160)
                    .borderRadius(12) // AppTokens.Shapes.medium.cornerRadius approx

                  // === Text (Title) ===
                  Text(item.title)
                    .fontColor('#0B1220')
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .margin({ top: 8 })

                  // === Text (Viewers) ===
                  Text(`${item.viewers} viewers`)
                    .fontColor('#60A5FA')
                    .fontSize(14)
                    .margin({ top: 4 })

                  // === HStack (Price & Button) ===
                  Row() {
                    // === Text (Price) ===
                    Text(item.price)
                      .fontColor('#1E3A8A')
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)

                    Blank()

                    // === Button ===
                    Button() {
                      Text('Buy Now')
                        .fontColor('#FFFFFF')
                    }
                    .type(ButtonType.Capsule)
                    .backgroundColor('#1E3A8A')
                    .borderRadius(20)
                    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                  }
                  .width('100%')
                  .margin({ top: 12 })
                }
                .width('100%')
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(16) // AppTokens.Shapes.large.cornerRadius
                .shadow({ radius: 4, color: '#000000', offsetX: 0, offsetY: 2 })
              }
            }, (item: LiveItem) => item.title)
          }
          .width('100%')
          .layoutWeight(1)
          .edgeEffect(EdgeEffect.Spring)
        }
        .width('100%')
        .height('100%')
        .padding(24)
        .backgroundColor('#F5F5F5')
        .ignoreSafeArea([SafeAreaType.RIGHT, SafeAreaType.LEFT, SafeAreaType.BOTTOM, SafeAreaType.TOP])

        // === VStack (FAB Area) ===
        Column() {
          Blank()
          Row() {
            Blank()
            Button() {
              Text('+')
                .fontColor('#FFFFFF')
                .fontSize(24)
            }
            .type(ButtonType.Circle)
            .backgroundColor('#1E3A8A')
            .width(56)
            .height(56)
            .shadow({ radius: 6, color: '#000000', offsetX: 0, offsetY: 4 })
            .margin({ right: 24, bottom: 24 })
          }
          .alignItems(VerticalAlign.End)
        }
        .width('100%')
        .height('100%')
        .position({ x: 0, y: 0 })

        // === VStack (Bottom Bar) ===
        Column() {
          Blank()
          Row() {
            Blank()
            Text('Home')
              .fontColor('#1E3A8A')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
            Blank()
            Text('Live')
              .fontColor('#0B1220')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
            Blank()
            Text('Cart')
              .fontColor('#0B1220')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
            Blank()
            Text('Profile')
              .fontColor('#0B1220')
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
            Blank()
          }
          .width('100%')
          .height(60)
          .backgroundColor('#FFFFFF')
          .shadow({ radius: 0.5, color: '#000000', offsetX: 0, offsetY: -1 })
        }
        .width('100%')
        .height('100%')
        .position({ x: 0, y: 0 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}