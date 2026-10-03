@Entry
@Component
struct CouponPackPage {
  @State coupons: Coupon[] = [
    { id: 1, title: 'Grocery Pack', value: '-$5', colorA: '#7B61FF', colorB: '#26C6DA' },
    { id: 2, title: 'Cafe Bundle', value: '-15%', colorA: '#26C6DA', colorB: '#FF8A80' },
    { id: 3, title: 'Electro Deal', value: '-$20', colorA: '#FF8A80', colorB: '#7B61FF' },
    { id: 4, title: 'Fashion Duo', value: '-10%', colorA: '#26C6DA', colorB: '#7B61FF' }
  ];
  @State pins: MapPin[] = [
    { x: 140, y: 220, label: 'A', tint: '#7B61FF' },
    { x: 320, y: 400, label: 'B', tint: '#26C6DA' },
    { x: 520, y: 300, label: 'C', tint: '#FF8A80' }
  ];
  private scroller: Scroller = new Scroller();

  build() {
    Column() {
      // Top bar
      Row() {
        // Navigation icon
        Column() {
          Circle({ width: 20, height: 20 })
            .fill('#0B1220')
        }
        .width(48)
        .height(48)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Text('Coupon Pack')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // Action icon
        Column() {
          Circle({ width: 20, height: 20 })
            .fill('#7B61FF')
        }
        .width(48)
        .height(48)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: 4, right: 4 })

      Scroll() {
        Column() {
          Text('Nearby Packs')
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#0B1220')
            .width('100%')
            .margin({ bottom: 16 })

          // Map canvas area
          Stack() {
            // Map background with pins
            Canvas(this.onCanvasDraw.bind(this))
              .width('100%')
              .height('100%')
              .backgroundColor('#F0F2F8')
              .borderRadius(20)

            // Legend row top-right
            Row() {
              Circle({ width: 10, height: 10 }).fill('#7B61FF')
              Text('A')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
                .margin({ left: 4, right: 8 })
              Circle({ width: 10, height: 10 }).fill('#26C6DA')
              Text('B')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
                .margin({ left: 4, right: 8 })
              Circle({ width: 10, height: 10 }).fill('#FF8A80')
              Text('C')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
                .margin({ left: 4 })
            }
            .padding({ left: 12, right: 12, top: 4, bottom: 4 })
            .backgroundColor('rgba(255,255,255,0.9)')
            .borderRadius(8)
            .align(Alignment.TopEnd)
            .margin({ top: 12, right: 12 })
          }
          .width('100%')
          .aspectRatio(16 / 9)
          .backgroundColor('#FFFFFF')
          .borderRadius(20)
          .padding(12)
          .margin({ bottom: 16 })

          Text('Your Coupon Packs')
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#0B1220')
            .width('100%')
            .margin({ bottom: 16 })

          // Horizontal coupon cards
          Scroll(this.scroller) {
            Row() {
              ForEach(this.coupons, (coupon: Coupon) => {
                this.CouponCard(coupon)
              }, (coupon: Coupon) => coupon.id.toString())
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')
          .margin({ bottom: 16 })

          // Bottom action buttons
          Row() {
            Button('My Coupons')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')
              .backgroundColor('#26C6DA')
              .borderRadius(20)
              .height(52)
              .layoutWeight(1)
              .margin({ right: 6 })

            Button('Explore More')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFF')
              .backgroundColor('#7B61FF')
              .borderRadius(20)
              .height(52)
              .layoutWeight(1)
              .margin({ left: 6 })
          }
          .width('100%')
        }
        .width('100%')
        .padding(16)
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['rgba(38,198,218,0.25)', 0.0], ['#F5F7FF', 0.5], ['rgba(123,97,255,0.25)', 1.0]]
    })
  }

  @Builder
  CouponCard(coupon: Coupon) {
    Column() {
      Column() {
        Row() {
          Circle({ width: 14, height: 14 }).fill('#7B61FF')
          Text(coupon.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
            .margin({ left: 8 })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Text(coupon.value)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
          .width('100%')
          .margin({ top: 8, bottom: 8 })

        Button('Redeem')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#7B61FF')
          .borderRadius(14)
          .height(40)
          .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .justifyContent(FlexAlign.SpaceBetween)
      .linearGradient({
        direction: GradientDirection.Right,
        colors: [[this.withAlpha(coupon.colorA, 0.18), 0.0], [this.withAlpha(coupon.colorB, 0.18), 1.0]]
      })
    }
    .width(200)
    .height(140)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.16)', offsetX: 0, offsetY: 6 })
    .margin({ right: 16 })
  }

  private withAlpha(hex: string, alpha: number): string {
    const r = parseInt(hex.slice(1, 3), 16);
    const g = parseInt(hex.slice(3, 5), 16);
    const b = parseInt(hex.slice(5, 7), 16);
    return `rgba(${r},${g},${b},${alpha})`;
  }

  private onCanvasDraw(canvasCtx: CanvasRenderingContext2D): void {
    canvasCtx.fillStyle = '#F0F2F8';
    canvasCtx.fillRect(0, 0, canvasCtx.canvas.width, canvasCtx.canvas.height);
    for (let i = 0; i < this.pins.length; i++) {
      const pin = this.pins[i];
      canvasCtx.beginPath();
      canvasCtx.arc(pin.x, pin.y, 14, 0, 2 * Math.PI);
      canvasCtx.fillStyle = pin.tint;
      canvasCtx.fill();
    }
  }
}

interface Coupon {
  id: number;
  title: string;
  value: string;
  colorA: string;
  colorB: string;
}

interface MapPin {
  x: number;
  y: number;
  label: string;
  tint: string;
}
