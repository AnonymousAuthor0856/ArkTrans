@Entry
@Component
struct RootScreen {
  private coupons: Coupon[] = [
    { id: 1, title: "Grocery Pack", value: "-$5", colorA: "#FF7B61FF", colorB: "#FF26C6DA" },
    { id: 2, title: "Cafe Bundle", value: "-15%", colorA: "#FF26C6DA", colorB: "#FFFF8A80" },
    { id: 3, title: "Electro Deal", value: "-$20", colorA: "#FFFF8A80", colorB: "#FF7B61FF" },
    { id: 4, title: "Fashion Duo", value: "-10%", colorA: "#FF26C6DA", colorB: "#FF7B61FF" }
  ]

  build() {
    Stack() {
      Column({ space: 12 }) {
        // Top bar
        Row({ space: 0 }) {
          Button() {
            Text('').width(20).height(20).backgroundColor('#FF0B1220').borderRadius(10)
          }
          .margin({ left: 16 })

          Blank().layoutWeight(1)

          Text('Coupon Pack')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#FF0B1220')

          Blank().layoutWeight(1)

          Button() {
            Text('').width(20).height(20).backgroundColor('#FF7B61FF').borderRadius(10)
          }
          .margin({ right: 16 })
        }
        .width('100%')
        .padding({ top: 16 })

        // Nearby Packs section
        List({ space: 12 }) {
          ListItem() {
            Text('Nearby Packs')
              .fontSize(20)
              .fontWeight(FontWeight.Bold) // Fixed Semibold -> Bold
              .foregroundColor('#FF0B1220')
          }

          // Map area (simulated with a colored box and pin indicators)
          ListItem() {
            Stack() {
              // Map background
              Column() { }
                .width('100%')
                .aspectRatio(16 / 9)
                .backgroundColor('#FFF0F2F8')
                .borderRadius(20)
                .shadow({ radius: 10, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: 6 })

              // Pin labels overlay (A, B, C)
              Row({ space: 8 }) {
                Row({ space: 4 }) {
                  Text('').width(10).height(10).backgroundColor('#FF7B61FF').borderRadius(5)
                  Text('A').fontSize(12).fontWeight(FontWeight.Medium).foregroundColor('#FF0B1220')
                }
                Row({ space: 4 }) {
                  Text('').width(10).height(10).backgroundColor('#FF26C6DA').borderRadius(5)
                  Text('B').fontSize(12).fontWeight(FontWeight.Medium).foregroundColor('#FF0B1220')
                }
                Row({ space: 4 }) {
                  Text('').width(10).height(10).backgroundColor('#FFFF8A80').borderRadius(5)
                  Text('C').fontSize(12).fontWeight(FontWeight.Medium).foregroundColor('#FF0B1220')
                }
              }
              .padding({ left: 12, right: 12, top: 4, bottom: 4 })
              .backgroundColor('rgba(255,255,255,0.9)')
              .borderRadius(8)
              .margin({ right: 12, top: 12 })
              .alignSelf(ItemAlign.End)
            }
            .width('100%')
            .padding({ left: 12, right: 12, top: 12, bottom: 12 })
          }

          // Your Coupon Packs header
          ListItem() {
            Text('Your Coupon Packs')
              .fontSize(20)
              .fontWeight(FontWeight.Bold) // Fixed Semibold -> Bold
              .foregroundColor('#FF0B1220')
          }

          // Coupon cards row
          ListItem() {
            Row({ space: 12 }) {
              ForEach(this.coupons, (coupon: Coupon) => {
                Stack() {
                  Column({ space: 8 }) {
                    Row({ space: 8 }) {
                      Text('').width(14).height(14).backgroundColor('#FF7B61FF').borderRadius(7)
                      Text(coupon.title)
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                        .foregroundColor('#FF0B1220')
                    }
                    Text(coupon.value)
                      .fontSize(28)
                      .fontWeight(FontWeight.Bold)
                      .foregroundColor('#FF0B1220')

                    Button() {
                      Text('Redeem')
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .foregroundColor('#FFFFFFFF')
                    }
                    .width('100%')
                    .height(40)
                    .backgroundColor('#FF7B61FF')
                    .borderRadius(14)
                  }
                  .padding(16)
                }
                .width(200)
                .height(140)
                .backgroundColor('#FFFFFFFF')
                .borderRadius(20)
                .shadow({ radius: 10, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: 6 })
              })
            }
            .width('100%')
          }

          // Bottom buttons
          ListItem() {
            Row({ space: 12 }) {
              Button() {
                Text('My Coupons')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FF0B1220')
              }
              .layoutWeight(1)
              .height(52)
              .backgroundColor('#FF26C6DA')
              .borderRadius(20)

              Button() {
                Text('Explore More')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FFFFFFFF')
              }
              .layoutWeight(1)
              .height(52)
              .backgroundColor('#FF7B61FF')
              .borderRadius(20)
            }
            .width('100%')
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      colors: [['rgba(38,198,218,0.25)', 0], ['#FFF5F7FF', 0.5], ['rgba(123,97,255,0.25)', 1]],
      direction: GradientDirection.Bottom
    })
  }
}

interface Coupon {
  id: number
  title: string
  value: string
  colorA: string
  colorB: string
}