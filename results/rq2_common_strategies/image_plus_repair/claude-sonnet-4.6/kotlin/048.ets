interface LiveItem {
  id: number;
  title: string;
  viewers: number;
  price: string;
}

@Entry
@Component
struct RootScreen {
  private liveList: LiveItem[] = [
    { id: 1, title: "Smartphone Flash Deal", viewers: 1234, price: "$699" },
    { id: 2, title: "Gaming Chair Special", viewers: 880, price: "$249" },
    { id: 3, title: "Headphones Clearance", viewers: 1640, price: "$99" },
    { id: 4, title: "Mechanical Keyboard", viewers: 512, price: "$129" }
  ];

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Main content
        Column() {
          Text("Live Shop Events")
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E3A8A')
            .margin({ bottom: 10 })

          List({ space: 10 }) {
            ForEach(this.liveList, (item: LiveItem) => {
              ListItem() {
                Column({ space: 6 }) {
                  // Image placeholder
                  Row()
                    .width('100%')
                    .height(160)
                    .backgroundColor('#3B82F6')
                    .borderRadius(10)

                  Text(item.title)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0B1220')

                  Text(`${item.viewers} viewers`)
                    .fontSize(14)
                    .fontColor('#60A5FA')

                  Row() {
                    Text(item.price)
                      .fontSize(18)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#1E3A8A')

                    Button("Join Live")
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#FFFFFF')
                      .backgroundColor('#1E3A8A')
                      .borderRadius(10)
                      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                  }
                  .width('100%')
                  .justifyContent(FlexAlign.SpaceBetween)
                  .alignItems(VerticalAlign.Center)
                }
                .width('100%')
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
              }
            })
          }
          .width('100%')
          .layoutWeight(1)
          .padding({ bottom: 96 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(16)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#F5F8FF', 0.0], ['#E8EEFA', 0.5], ['#F5F8FF', 1.0]]
        })

        // Bottom bar
        Row() {
          Text("Home")
            .fontSize(14)
            .fontColor('#1E3A8A')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text("Live")
            .fontSize(14)
            .fontColor('#0B1220')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text("Cart")
            .fontSize(14)
            .fontColor('#0B1220')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text("Profile")
            .fontSize(14)
            .fontColor('#0B1220')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FFFFFF')
        .padding({ left: 16, right: 16 })
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height('100%')

      // FAB
      Button("+")
        .fontSize(24)
        .fontColor('#FFFFFF')
        .backgroundColor('#3B82F6')
        .width(56)
        .height(56)
        .borderRadius(28)
        .margin({ right: 16, bottom: 72 })
        .shadow({ radius: 8, color: '#263B82F6', offsetX: 0, offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F8FF')
  }
}