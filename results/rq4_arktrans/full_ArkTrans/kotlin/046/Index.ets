@Entry
@Component
struct Index {
  @State pins: Array<Pin> = [
    { x: 140, y: 220, label: "A", color: "#7B61FF" },
    { x: 320, y: 400, label: "B", color: "#26C6DA" },
    { x: 520, y: 300, label: "C", color: "#FF8A80" }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Main Content Column ===
      Column({ space: 16 }) {
        // === Nearby Packs Section ===
        Text('Nearby Packs')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')

        // === Map Box ===
        Stack({ alignContent: Alignment.Center }) {
          // Canvas Background
          Canvas().width('100%').height('100%').backgroundColor('#F0F2F5')

          // Render Pins based on state
          ForEach(this.pins, (pin: Pin) => {
            Stack({ alignContent: Alignment.Center }) {
              Text(pin.label).fontColor('#FFF').fontSize(12)
            }
            .width(24).height(24).borderRadius(12).backgroundColor(pin.color)
            .position({ x: pin.x, y: pin.y })
          })

          // Legend Row
          Row({ space: 8 }) {
            ForEach(this.pins, (pin: Pin) => {
              Stack({ alignContent: Alignment.Center }) {
                Circle().width(10).height(10).fill(pin.color)
              }
              Text(pin.label).fontSize(14).fontColor('#0B1220')
            })
          }
          .alignItems(VerticalAlign.Center)
          .padding({ left: 12, right: 12, top: 4, bottom: 4 })
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 4, color: '#1A000000' })
          .position({ x: 'auto', y: 10 })
          .margin({ right: 10 })
          .alignSelf(ItemAlign.End)
        }
        .width('100%')
        .aspectRatio(16 / 9)
        .backgroundColor('#FFFFFF')
        .borderRadius(24)
        .padding(12)

        // === Your Coupon Packs Section ===
        Text('Your Coupon Packs')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')

        // === Horizontal List of Cards ===
        List({ space: 16 }) {
          ListItem() {
            // Card 1: Grocery Pack
            Column({ space: 8 }) {
              Row({ space: 8 }) {
                Stack({ alignContent: Alignment.Center }) {
                  Circle().width(14).height(14).fill('#7B61FF')
                }
                Text('Grocery Pack').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#0B1220')
              }.alignItems(VerticalAlign.Center)

              Text('-$5').fontSize(32).fontWeight(FontWeight.Bold).fontColor('#0B1220')

              Button('Redeem')
                .width('100%')
                .height(40)
                .backgroundColor('#7B61FF')
                .borderRadius(20)
                .fontColor('#FFFFFF')
            }
            .width(200)
            .height(140)
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .shadow({ radius: 8, color: '#1A000000' })
            .linearGradient({
              direction: GradientDirection.Right,
              colors: [['#7B61FF', 0.1], ['#26C6DA', 0.1]]
            })
          }

          ListItem() {
            // Card 2: Cafe Bundle
            Column({ space: 8 }) {
              Row({ space: 8 }) {
                Stack({ alignContent: Alignment.Center }) {
                  Circle().width(14).height(14).fill('#7B61FF')
                }
                Text('Cafe Bundle').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#0B1220')
              }.alignItems(VerticalAlign.Center)

              Text('-15%').fontSize(32).fontWeight(FontWeight.Bold).fontColor('#0B1220')

              Button('Redeem')
                .width('100%')
                .height(40)
                .backgroundColor('#7B61FF')
                .borderRadius(20)
                .fontColor('#FFFFFF')
            }
            .width(200)
            .height(140)
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .shadow({ radius: 8, color: '#1A000000' })
            .linearGradient({
              direction: GradientDirection.Right,
              colors: [['#26C6DA', 0.1], ['#FF8A80', 0.1]]
            })
          }
        }
        .width('100%')
        .listDirection(Axis.Horizontal)
        .padding({ left: 8, right: 8 })

        Blank().height(8)

        // === Bottom Buttons ===
        Row({ space: 12 }) {
          Button('My Coupons')
            .layoutWeight(1)
            .height(52)
            .backgroundColor('#26C6DA')
            .borderRadius(24)
            .fontColor('#0B1220')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          Button('Explore More')
            .layoutWeight(1)
            .height(52)
            .backgroundColor('#7B61FF')
            .borderRadius(24)
            .fontColor('#FFFFFF')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#7B61FF', 0.25], ['#FFFFFF', 0.5], ['#26C6DA', 0.25]]
      })

      // === Top App Bar ===
      Row({ space: 12 }) {
        // Left Icon Placeholder
        Stack({ alignContent: Alignment.Center }) {
          Circle().width(20).height(20).fill('#0B1220')
        }

        Text('Coupon Pack')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        // Right Icon Placeholder
        Stack({ alignContent: Alignment.Center }) {
          Circle().width(20).height(20).fill('#7B61FF')
        }
      }
      .width('100%')
      .height(60)
      .padding({ left: 16, right: 16 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
  }
}

interface Pin {
  x: number;
  y: number;
  label: string;
  color: string;
}