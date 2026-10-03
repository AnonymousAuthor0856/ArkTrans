interface Coupon {
  id: number
  title: string
  value: string
  colorA: string
  colorB: string
}

interface MapPin {
  x: number
  y: number
  label: string
  tint: string
}

@Entry
@Component
struct CouponPackPage {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  @State coupons: Coupon[] = [
    { id: 1, title: 'Grocery Pack', value: '-$5', colorA: '#2E7B61FF', colorB: '#2E26C6DA' },
    { id: 2, title: 'Cafe Bundle', value: '-15%', colorA: '#2E26C6DA', colorB: '#2EFF8A80' },
    { id: 3, title: 'Electro Deal', value: '-$20', colorA: '#2EFF8A80', colorB: '#2E7B61FF' },
    { id: 4, title: 'Fashion Duo', value: '-10%', colorA: '#2E26C6DA', colorB: '#2E7B61FF' }
  ]

  private pins: MapPin[] = [
    { x: 140, y: 220, label: 'A', tint: '#7B61FF' },
    { x: 320, y: 400, label: 'B', tint: '#26C6DA' },
    { x: 520, y: 300, label: 'C', tint: '#FF8A80' }
  ]

  build() {
    Column() {
      Row() {
        Row() {
          Row()
            .width(20)
            .height(20)
            .backgroundColor('#0B1220')
            .borderRadius(10)
        }
        .width(48)
        .height(48)
        .justifyContent(FlexAlign.Center)

        Text('Coupon Pack')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Row() {
          Row()
            .width(20)
            .height(20)
            .backgroundColor('#7B61FF')
            .borderRadius(10)
        }
        .width(48)
        .height(48)
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .height(64)
      .padding({ left: 8, right: 8 })
      .backgroundColor('#FFFFFF')

      Column({ space: 16 }) {
        Text('Nearby Packs')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')

        Stack() {
          Canvas(this.ctx)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.ctx.fillStyle = '#F0F2F8'
              this.ctx.fillRect(0, 0, this.ctx.width, this.ctx.height)
              this.pins.forEach((p: MapPin) => {
                this.ctx.fillStyle = p.tint
                this.ctx.beginPath()
                this.ctx.arc(p.x, p.y, 14, 0, Math.PI * 2)
                this.ctx.fill()
              })
            })

          Column() {
            Row({ space: 8 }) {
              Row()
                .width(10)
                .height(10)
                .backgroundColor('#7B61FF')
                .borderRadius(5)
              Text('A')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
              Row()
                .width(10)
                .height(10)
                .backgroundColor('#26C6DA')
                .borderRadius(5)
              Text('B')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
              Row()
                .width(10)
                .height(10)
                .backgroundColor('#FF8A80')
                .borderRadius(5)
              Text('C')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
            }
            .padding({ left: 12, right: 12, top: 4, bottom: 4 })
            .backgroundColor('#E6FFFFFF')
            .borderRadius(8)
          }
          .width('100%')
          .height('100%')
          .alignItems(HorizontalAlign.End)
          .justifyContent(FlexAlign.Start)
        }
        .width('100%')
        .aspectRatio(16 / 9)
        .backgroundColor('#FFFFFF')
        .borderRadius(20)
        .padding(12)

        Text('Your Coupon Packs')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')

        Scroll() {
          Row({ space: 16 }) {
            ForEach(this.coupons, (item: Coupon) => {
              Column({ space: 8 }) {
                Row({ space: 8 }) {
                  Row()
                    .width(14)
                    .height(14)
                    .backgroundColor('#7B61FF')
                    .borderRadius(7)
                  Text(item.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#0B1220')
                }
                .alignItems(VerticalAlign.Center)

                Text(item.value)
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#0B1220')

                Button('Redeem')
                  .width('100%')
                  .height(40)
                  .backgroundColor('#7B61FF')
                  .fontColor('#FFFFFF')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .borderRadius(14)
              }
              .width(200)
              .height(140)
              .padding(16)
              .linearGradient({ direction: GradientDirection.Right, colors: [[item.colorA, 0.0], [item.colorB, 1.0]] })
              .borderRadius(20)
              .shadow({ radius: 10, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: 6 })
            }, (item: Coupon) => item.id.toString())
          }
          .padding({ left: 4, right: 4 })
        }
        .width('100%')
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)

        Row()
          .width('100%')
          .height(8)

        Row({ space: 12 }) {
          Button('My Coupons')
            .layoutWeight(1)
            .height(52)
            .backgroundColor('#26C6DA')
            .fontColor('#0B1220')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .borderRadius(20)
          Button('Explore More')
            .layoutWeight(1)
            .height(52)
            .backgroundColor('#7B61FF')
            .fontColor('#FFFFFF')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .borderRadius(20)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(16)
      .alignItems(HorizontalAlign.Start)
      .linearGradient({ direction: GradientDirection.Bottom, colors: [['#4026C6DA', 0.0], ['#F5F7FF', 0.5], ['#407B61FF', 1.0]] })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F7FF')
  }
}
