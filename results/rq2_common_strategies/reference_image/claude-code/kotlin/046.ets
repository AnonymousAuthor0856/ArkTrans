@Entry
@Component
struct Index {
  private coupons: Coupon[] = [
    { id: 1, title: "Grocery Pack", value: "-$5", colorA: "#7B61FF", colorB: "#26C6DA" },
    { id: 2, title: "Cafe Bundle", value: "-15%", colorA: "#26C6DA", colorB: "#FF8A80" },
    { id: 3, title: "Electro Deal", value: "-$20", colorA: "#FF8A80", colorB: "#7B61FF" },
    { id: 4, title: "Fashion Duo", value: "-10%", colorA: "#26C6DA", colorB: "#7B61FF" }
  ]
  private pins: MapPin[] = [
    { x: 140, y: 220, label: "A", tint: "#7B61FF" },
    { x: 320, y: 400, label: "B", tint: "#26C6DA" },
    { x: 520, y: 300, label: "C", tint: "#FF8A80" }
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Circle({ width: 20, height: 20 })
          .fill("#0B1220")
        Text("Coupon Pack")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor("#0B1220")
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Circle({ width: 20, height: 20 })
          .fill("#7B61FF")
      }
      .width("100%")
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })

      // Content
      Scroll() {
        Column({ space: 16 }) {
          // Nearby Packs Section
          Text("Nearby Packs")
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor("#0B1220")
            .width("100%")

          // Map Box
          Stack() {
            // Map canvas area
            Column() { }
              .width("100%")
              .aspectRatio(16 / 9)
              .backgroundColor("#F0F2F8")
              .borderRadius(20)

            // Map pins drawn as positioned circles
            ForEach(this.pins, (pin: MapPin, index: number) => {
              Circle({ width: 28, height: 28 })
                .fill(pin.tint)
                .position({ x: pin.x - 14, y: pin.y - 14 })
            }, (pin: MapPin) => pin.label)

            // Legend
            Row({ space: 8 }) {
              Circle({ width: 10, height: 10 })
                .fill("#7B61FF")
              Text("A")
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor("#0B1220")
              Circle({ width: 10, height: 10 })
                .fill("#26C6DA")
              Text("B")
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor("#0B1220")
              Circle({ width: 10, height: 10 })
                .fill("#FF8A80")
              Text("C")
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor("#0B1220")
            }
            .padding({ left: 12, right: 12, top: 4, bottom: 4 })
            .backgroundColor("rgba(255, 255, 255, 0.9)")
            .borderRadius(8)
            .position({ x: 0, y: 0 })
            .margin({ top: 12, right: 12 })
            .align(Alignment.TopEnd)
          }
          .width("100%")
          .aspectRatio(16 / 9)
          .backgroundColor("#FFFFFF")
          .borderRadius(20)
          .padding(12)

          // Your Coupon Packs Section
          Text("Your Coupon Packs")
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor("#0B1220")
            .width("100%")

          // Coupon Cards Row (horizontal scroll)
          List() {
            ForEach(this.coupons, (coupon: Coupon) => {
              ListItem() {
                this.CouponCard(coupon)
              }
            }, (coupon: Coupon) => coupon.id.toString())
          }
          .listDirection(Axis.Horizontal)
          .divider({ strokeWidth: 0 })
          .width("100%")
          .height(260)

          // Bottom Buttons
          Row({ space: 12 }) {
            Button("My Coupons")
              .type(ButtonType.Normal)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor("#0B1220")
              .backgroundColor("#26C6DA")
              .borderRadius(20)
              .height(52)
              .layoutWeight(1)

            Button("Explore More")
              .type(ButtonType.Normal)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor("#FFFFFF")
              .backgroundColor("#7B61FF")
              .borderRadius(20)
              .height(52)
              .layoutWeight(1)
          }
          .width("100%")
          .margin({ top: 8 })
        }
        .width("100%")
        .padding({ left: 16, right: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width("100%")
    .height("100%")
    .background(this.GradientBg())
  }

  @Builder
  GradientBg() {
    Column() { }
      .width("100%")
      .height("100%")
      .linearGradient({
        angle: 180,
        colors: [["rgba(38, 198, 218, 0.25)", 0], ["#F5F7FF", 0.5], ["rgba(123, 97, 255, 0.25)", 1]]
      })
  }

  @Builder
  CouponCard(coupon: Coupon) {
    Column({ space: 8 }) {
      // Title row with dot
      Row({ space: 8 }) {
        Circle({ width: 14, height: 14 })
          .fill("#7B61FF")
        Text(coupon.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor("#0B1220")
      }
      .width("100%")
      .alignItems(VerticalAlign.Center)

      // Value text
      Text(coupon.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor("#0B1220")
        .width("100%")

      // Redeem button
      Button("Redeem")
        .type(ButtonType.Normal)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor("#FFFFFF")
        .backgroundColor("#7B61FF")
        .borderRadius(14)
        .height(40)
        .width("100%")
    }
    .width(200)
    .height(260)
    .padding(16)
    .justifyContent(FlexAlign.Start)
    .linearGradient({
      angle: 90,
      colors: [[this.hexToRgba(coupon.colorA, 0.18), 0], [this.hexToRgba(coupon.colorB, 0.18), 1]]
    })
    .borderRadius(20)
    .shadow({ radius: 10, color: "rgba(0, 0, 0, 0.16)", offsetY: 6 })
  }

  hexToRgba(hex: string, alpha: number): string {
    let h = hex.replace("#", "")
    let r = parseInt(h.substring(0, 2), 16)
    let g = parseInt(h.substring(2, 4), 16)
    let b = parseInt(h.substring(4, 6), 16)
    return `rgba(${r}, ${g}, ${b}, ${alpha})`
  }
}

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
