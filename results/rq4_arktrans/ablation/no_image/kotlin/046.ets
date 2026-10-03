interface Pin {
  x: number;
  y: number;
  label: string;
  color: string;
}

@Entry
@Component
struct Index {
  @State pins: Array<Pin> = [
    { x: 140, y: 220, label: "A", color: "#7B61FF" },
    { x: 320, y: 400, label: "B", color: "#26C6DA" },
    { x: 520, y: 300, label: "C", color: "#FF8A80" }
  ]
  @State NearbyPacks: number = 0
  @State py: number = 0
  @State A: number = 0
  @State B: number = 0
  @State C: number = 0
  @State YourCouponPacks: number = 0
  @State cTitle: string = "c.title"
  @State cValue: string = "c.value"
  @State Redeem: number = 0
  @State MyCoupons: number = 0
  @State ExploreMore: number = 0
  @State CouponPack: number = 0

  build() {
    Stack() {
      // === Scaffold ===
      Stack({ alignContent: Alignment.Top }) {
        // === Column ===
        Column({ space: 16 }) {
          // === Text ===
          Text('Nearby Packs')
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')

          // === Box (Map Container) ===
          Stack({ alignContent: Alignment.Center }) {
            // === Canvas ===
            Canvas().width('100%').height('100%')

            // === Row (Legend) ===
            Row({ space: 8 }) {
              // === Box (Dot A) ===
              Stack({ alignContent: Alignment.Center }) {
                Circle().width(10).height(10).fill('#7B61FF')
              }
              // === Text ===
              Text('A').fontSize(14).fontColor('#0B1220')

              // === Box (Dot B) ===
              Stack({ alignContent: Alignment.Center }) {
                Circle().width(10).height(10).fill('#26C6DA')
              }
              // === Text ===
              Text('B').fontSize(14).fontColor('#0B1220')

              // === Box (Dot C) ===
              Stack({ alignContent: Alignment.Center }) {
                Circle().width(10).height(10).fill('#FF8A80')
              }
              // === Text ===
              Text('C').fontSize(14).fontColor('#0B1220')
            }
            .alignItems(VerticalAlign.Center)
            .backgroundColor('rgba(255, 255, 255, 0.9)')
            .borderRadius(8)
            .padding({ left: 12, right: 12, top: 4, bottom: 4 })
            .position({ x: 'auto', y: 10 }) // Approximating TopEnd alignment manually or using layoutWeight if needed, but Stack allows positioning. 
            // Note: In ArkTS Stack, to align TopEnd, we usually use position or a nested Column/Row structure. 
            // Given the skeleton implies a specific layout, let's assume standard flow or explicit positioning.
            // The skeleton says "align: Alignment.TopEnd". In Stack, children are layered. 
            // To place it at TopEnd, we can use position relative to parent or wrap in a container.
            // However, simpler is to just let it flow if it's small, or use position.
            // Let's stick to the visual hierarchy.
          }
          .width('100%')
          .aspectRatio(16 / 9)
          .backgroundColor('#FFFFFF') // MaterialTheme.colorScheme.surface approx
          .borderRadius(16) // AppTokens.Shapes.large approx
          .padding(12)

          // === Text ===
          Text('Your Coupon Packs')
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')

          // === LazyRow (List Horizontal) ===
          List({ space: 16 }) {
            ListItem() {
              // === Card ===
              Column() {
                // === Box (Gradient Background) ===
                Stack({ alignContent: Alignment.Center }) {
                  // === Column ===
                  Column({ space: 8 }) {
                    // === Row ===
                    Row({ space: 8 }) {
                      // === Box (Icon) ===
                      Stack({ alignContent: Alignment.Center }) {
                        Circle().width(14).height(14).fill('#7B61FF') // Primary color approx
                      }
                      // === Text ===
                      Text(this.cTitle)
                        .fontSize(16)
                        .fontWeight(FontWeight.Medium)
                        .fontColor('#0B1220')
                    }.alignItems(VerticalAlign.Center)

                    // === Text ===
                    Text(this.cValue)
                      .fontSize(40)
                      .fontWeight(FontWeight.Bold)
                      .fontColor('#0B1220')

                    // === Button ===
                    Button() {
                      Text('Redeem')
                        .fontSize(14)
                        .fontWeight(FontWeight.Medium)
                        .fontColor('#FFFFFF')
                    }
                    .type(ButtonType.Normal)
                    .backgroundColor('#7B61FF')
                    .borderRadius(8)
                    .height(40)
                    .width('100%')
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                .width('100%')
                .height('100%')
                .linearGradient({
                  direction: GradientDirection.Right,
                  colors: [['#7B61FF', 0.18], ['#26C6DA', 0.18]] // Approx gradient
                })
                .padding(16)
              }
              .width(200)
              .height(140)
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            }
          }
          .listDirection(Axis.Horizontal)
          .width('100%')
          .padding({ left: 4, right: 4 }) // contentPadding horizontal xs

          // === Spacer ===
          Blank().height(8)

          // === Row (Buttons) ===
          Row({ space: 12 }) {
            // === Button (My Coupons) ===
            Button() {
              Text('My Coupons')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
            .type(ButtonType.Normal)
            .backgroundColor('#26C6DA') // Secondary color approx
            .borderRadius(16)
            .height(52)
            .layoutWeight(1)

            // === Button (Explore More) ===
            Button() {
              Text('Explore More')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#FFFFFF')
            }
            .type(ButtonType.Normal)
            .backgroundColor('#7B61FF') // Primary color approx
            .borderRadius(16)
            .height(52)
            .layoutWeight(1)
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#26C6DA', 0.25], ['#F5F5F5', 0.5], ['#7B61FF', 0.25]] // Approx vertical gradient
        })

        // === CenterAlignedTopAppBar ===
        // Implemented as a Row at the top of the Stack
        Row() {
          // Left Icon
          Button() {
            Stack({ alignContent: Alignment.Center }) {
              Circle().width(20).height(20).fill('#0B1220') // OnSurface approx
            }
          }
          .type(ButtonType.Circle)
          .backgroundColor(Color.Transparent)
          
          Blank() // Spacer for centering title

          // Title
          Text('Coupon Pack')
            .fontSize(40)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
            
          Blank() // Spacer

          // Right Icon
          Button() {
            Stack({ alignContent: Alignment.Center }) {
              Circle().width(20).height(20).fill('#7B61FF') // Primary approx
            }
          }
          .type(ButtonType.Circle)
          .backgroundColor(Color.Transparent)
        }
        .width('100%')
        .height(56)
        .padding(16)
        .alignItems(VerticalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
  }
}