class FsColors {
  static readonly background: string = '#FFF5F5F7'
  static readonly imageBg: string = '#FFE8E8E8'
  static readonly iconColor: string = '#FFEFB495'
  static readonly color0: string = '#FFEFB495'
  static readonly color1: string = '#FF8D6E63'
  static readonly color2: string = '#FF5D4037'
  static readonly titleColor: string = '#FF333333'
  static readonly starColor: string = '#FFFFC107'
  static readonly buttonBg: string = '#FF333333'
  static readonly gray: string = '#FF808080'
  static readonly black: string = '#FF000000'
  static readonly white: string = '#FFFFFFFF'
  static readonly red: string = '#FFFF0000'
}

@Entry
@Component
struct Index {
  @State isFavorite: boolean = false
  @State selectedColorIndex: number = 0
  @State quantity: number = 1

  private colorList: string[] = [FsColors.color0, FsColors.color1, FsColors.color2]

  build() {
    Stack() {
      Column() {
        Scroll() {
          Column() {
            Stack() {
              Column() {
                Blank()
              }
              .width('100%')
              .height(400)
              .backgroundColor(FsColors.imageBg)
              .borderRadius({ bottomLeft: 40, bottomRight: 40 })

              Stack() {
                Circle({ width: 200, height: 200 })
                  .fill(FsColors.white)
                  .shadow({ radius: 20, color: '#33000000', offsetY: 10 })

                Text('⌂')
                  .fontSize(100)
                  .fontColor(FsColors.iconColor)
              }

              Column() {
                Row() {
                  Text('←')
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(FsColors.black)
                    .width(42)
                    .height(42)
                    .textAlign(TextAlign.Center)
                    .backgroundColor(FsColors.white)
                    .borderRadius(21)

                  Blank()

                  Text(this.isFavorite ? '♥' : '♡')
                    .fontSize(20)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.isFavorite ? FsColors.red : FsColors.black)
                    .width(42)
                    .height(42)
                    .textAlign(TextAlign.Center)
                    .backgroundColor(FsColors.white)
                    .borderRadius(21)
                    .onClick(() => {
                      this.isFavorite = !this.isFavorite
                    })
                }
                .padding(24)
                Blank()
              }
              .height(400)
            }

            Column() {
              Row() {
                Text('Modern Lounge')
                  .fontSize(26)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(FsColors.titleColor)

                Blank()

                Row() {
                  Text('★')
                    .fontSize(20)
                    .fontColor(FsColors.starColor)

                  Text('4.8')
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(FsColors.black)
                    .margin({ left: 4 })
                }
              }

              Text('Armchair')
                .fontSize(20)
                .fontWeight(FontWeight.Lighter)
                .fontColor(FsColors.gray)
                .margin({ top: -4 })

              Blank().height(24)

              Text('Description')
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(FsColors.black)

              Blank().height(8)

              Text('Experience the ultimate comfort with this modern minimalist armchair. Crafted with premium bamboo wood and soft linen fabric, it perfectly blends style and functionality for your living room.')
                .fontSize(14)
                .fontColor(FsColors.gray)
                .lineHeight(22)

              Blank().height(24)

              Row() {
                Column() {
                  Text('Color')
                    .fontSize(18)
                    .fontWeight(FontWeight.SemiBold)
                    .fontColor(FsColors.black)

                  Row() {
                    ForEach(this.colorList, (color: string, index: number) => {
                      Stack() {
                        Circle({ width: 30, height: 30 })
                          .fill(color)

                        if (this.selectedColorIndex === index) {
                          Circle({ width: 30, height: 30 })
                            .fill('#00000000')
                            .border({ width: 2, color: FsColors.black })
                        }
                      }
                      .onClick(() => {
                        this.selectedColorIndex = index
                      })
                      .margin({ right: 12 })
                    })
                  }
                  .margin({ top: 8 })
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Column() {
                  Text('Quantity')
                    .fontSize(18)
                    .fontWeight(FontWeight.SemiBold)
                    .fontColor(FsColors.black)

                  Row() {
                    Text('-')
                      .fontSize(20)
                      .fontColor(FsColors.black)
                      .width(40)
                      .height(32)
                      .textAlign(TextAlign.Center)
                      .onClick(() => {
                        if (this.quantity > 1) {
                          this.quantity -= 1
                        }
                      })

                    Text(`${this.quantity}`)
                      .fontSize(18)
                      .fontWeight(FontWeight.Bold)
                      .fontColor(FsColors.black)
                      .width(20)
                      .textAlign(TextAlign.Center)

                    Text('+')
                      .fontSize(16)
                      .fontColor(FsColors.black)
                      .width(40)
                      .height(32)
                      .textAlign(TextAlign.Center)
                      .onClick(() => {
                        this.quantity += 1
                      })
                  }
                  .backgroundColor(FsColors.white)
                  .borderRadius(12)
                  .margin({ top: 8 })
                }
                .alignItems(HorizontalAlign.End)
              }

              Blank().height(100)
            }
            .padding(24)
            .alignItems(HorizontalAlign.Start)
          }
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }

      Stack() {
        Row() {
          Column() {
            Text('Total Price')
              .fontSize(14)
              .fontColor(FsColors.gray)

            Text(`$${245 * this.quantity}`)
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor(FsColors.black)
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Row() {
            Text('🛒')
              .fontSize(20)
            Text('Add to Cart')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(FsColors.white)
              .margin({ left: 8 })
          }
          .fontColor(FsColors.white)
          .width(160)
          .height(50)
          .backgroundColor(FsColors.buttonBg)
          .borderRadius(16)
        }
        .padding(24)
        .backgroundColor(FsColors.white)
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 16, color: '#1A000000', offsetY: -4 })
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Bottom)
    }
    .backgroundColor(FsColors.background)
    .width('100%')
    .height('100%')
  }
}