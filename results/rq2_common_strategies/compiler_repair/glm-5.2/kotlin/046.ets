// Index.ets

interface Coupon {
  id: number;
  title: string;
  value: string;
  colorA: ResourceColor;
  colorB: ResourceColor;
}

interface MapPin {
  x: number;
  y: number;
  label: string;
  tint: ResourceColor;
}

@Entry
@Component
struct RootScreen {
  private coupons: Coupon[] = [
    { id: 1, title: "Grocery Pack", value: "-$5", colorA: "#7B61FF", colorB: "#26C6DA" },
    { id: 2, title: "Cafe Bundle", value: "-15%", colorA: "#26C6DA", colorB: "#FF8A80" },
    { id: 3, title: "Electro Deal", value: "-$20", colorA: "#FF8A80", colorB: "#7B61FF" },
    { id: 4, title: "Fashion Duo", value: "-10%", colorA: "#26C6DA", colorB: "#7B61FF" }
  ];

  private pins: MapPin[] = [
    { x: 140, y: 220, label: "A", tint: "#7B61FF" },
    { x: 320, y: 400, label: "B", tint: "#26C6DA" },
    { x: 520, y: 300, label: "C", tint: "#FF8A80" }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Circle({ width: 20, height: 20 }).fill("#0B1220");
        Text("Coupon Pack")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor("#0B1220")
          .layoutWeight(1)
          .textAlign(TextAlign.Center);
        Circle({ width: 20, height: 20 }).fill("#7B61FF");
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center);

      // Content
      Scroll() {
        Column() {
          Text("Nearby Packs")
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor("#0B1220")
            .margin({ top: 16, bottom: 12 });

          // Map Box
          Stack({ alignContent: Alignment.TopEnd }) {
            // Canvas Background
            Column() {
              ForEach(this.pins, (pin: MapPin) => {
                Stack() {
                  Circle({ width: 28, height: 28 }).fill(pin.tint);
                  Text(pin.label).fontSize(12).fontColor("#FFFFFF").fontWeight(FontWeight.Bold);
                }
                .position({ x: pin.x - 14, y: pin.y - 14 })
              })
            }
            .width('100%')
            .height('100%')
            .backgroundColor("#F0F2F8")
            .borderRadius(20);

            // Legend
            Row() {
              Row() {
                Circle({ width: 10, height: 10 }).fill("#7B61FF");
                Text("A").fontSize(12).fontColor("#0B1220").margin({ left: 4 });
              }
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .backgroundColor("#FFFFFFEE")
              .borderRadius(8);

              Row() {
                Circle({ width: 10, height: 10 }).fill("#26C6DA");
                Text("B").fontSize(12).fontColor("#0B1220").margin({ left: 4 });
              }
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .backgroundColor("#FFFFFFEE")
              .borderRadius(8)
              .margin({ left: 8 });

              Row() {
                Circle({ width: 10, height: 10 }).fill("#FF8A80");
                Text("C").fontSize(12).fontColor("#0B1220").margin({ left: 4 });
              }
              .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              .backgroundColor("#FFFFFFEE")
              .borderRadius(8)
              .margin({ left: 8 });
            }
            .padding(8)
            .margin(12);
          }
          .width('100%')
          .aspectRatio(16 / 9)
          .clip(true)
          .borderRadius(20);

          Text("Your Coupon Packs")
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor("#0B1220")
            .margin({ top: 24, bottom: 12 });

          // Lazy Row
          Scroll() {
            Row({ space: 16 }) {
              ForEach(this.coupons, (c: Coupon) => {
                Column() {
                  Row() {
                    Circle({ width: 14, height: 14 }).fill("#7B61FF");
                    Text(c.title)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor("#0B1220")
                      .margin({ left: 8 });
                  }
                  .alignItems(VerticalAlign.Center);

                  Text(c.value)
                    .fontSize(28)
                    .fontWeight(FontWeight.Bold)
                    .fontColor("#0B1220")
                    .margin({ top: 8, bottom: 8 });

                  Button("Redeem")
                    .type(ButtonType.Capsule)
                    .width('100%')
                    .height(40)
                    .backgroundColor("#7B61FF")
                    .fontColor("#FFFFFF")
                    .fontSize(12);
                }
                .width(200)
                .height(140)
                .padding(16)
                .borderRadius(20)
                .backgroundColor("#FFFFFF")
                .shadow({ radius: 10, color: "#00000028", offsetX: 0, offsetY: 6 });
              })
            }
            .padding({ left: 4, right: 4 });
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%');

          // Bottom Buttons
          Row({ space: 12 }) {
            Button("My Coupons")
              .type(ButtonType.Capsule)
              .layoutWeight(1)
              .height(52)
              .backgroundColor("#26C6DA")
              .fontColor("#0B1220")
              .fontSize(16)
              .fontWeight(FontWeight.Medium);

            Button("Explore More")
              .type(ButtonType.Capsule)
              .layoutWeight(1)
              .height(52)
              .backgroundColor("#7B61FF")
              .fontColor("#FFFFFF")
              .fontSize(16)
              .fontWeight(FontWeight.Medium);
          }
          .width('100%')
          .margin({ top: 24, bottom: 24 });
        }
        .width('100%')
        .padding(16);
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off);
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [["#26C6DA40", 0.0], ["#F5F7FF", 0.5], ["#7B61FF40", 1.0]]
    });
  }
}