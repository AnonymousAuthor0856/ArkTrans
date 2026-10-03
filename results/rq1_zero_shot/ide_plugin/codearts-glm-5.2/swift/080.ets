class FdColors {
  static readonly white: string = '#FFFFFFFF'
  static readonly black: string = '#FF000000'
  static readonly gray: string = '#FF808080'
  static readonly headerStroke: string = '#FFE0E0E0'
  static readonly imageBg: string = '#FFF5F5F5'
  static readonly imageIcon: string = '#FFBDBDBD'
  static readonly starColor: string = '#FFFFC107'
  static readonly color0: string = '#FF212121'
  static readonly color1: string = '#FF795548'
  static readonly color2: string = '#FF9E9E9E'
  static readonly selectorStroke: string = '#80808080'
  static readonly bottomActionBg: string = '#FFF5F5F5'
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row() {
          Text('←')
            .fontSize(20)
            .fontColor(FdColors.black)
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .border({ width: 1, color: FdColors.headerStroke, radius: 24 })

          Blank()

          Text('Details')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(FdColors.black)

          Blank()

          Text('♡')
            .fontSize(20)
            .fontColor(FdColors.black)
            .width(48)
            .height(48)
            .textAlign(TextAlign.Center)
            .border({ width: 1, color: FdColors.headerStroke, radius: 24 })
        }
        .padding({ left: 24, right: 24, top: 16 })

        Scroll() {
          Column() {
            Blank().height(24)

            Stack() {
              Text('🛒')
                .fontSize(80)
                .fontColor(FdColors.imageIcon)
            }
            .width('100%')
            .height(300)
            .backgroundColor(FdColors.imageBg)
            .borderRadius(32)

            Blank().height(32)

            Column() {
              Row() {
                Column() {
                  Text('Modern Lounge\nChair')
                    .fontSize(26)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(FdColors.black)
                    .lineHeight(32)

                  Text('Minimalist Series')
                    .fontSize(16)
                    .fontColor(FdColors.gray)
                    .margin({ top: 8 })
                }
                .alignItems(HorizontalAlign.Start)

                Blank()

                Text('$1299')
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(FdColors.black)
              }
              .alignItems(VerticalAlign.Top)

              Blank().height(24)

              Row() {
                Text('★')
                  .fontSize(20)
                  .fontColor(FdColors.starColor)

                Text('4.8')
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(FdColors.black)
                  .margin({ left: 4 })

                Text('(238 Reviews)')
                  .fontSize(14)
                  .fontColor(FdColors.gray)
                  .margin({ left: 8 })
              }

              Blank().height(24)

              Text('Colors')
                .fontSize(18)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(FdColors.black)

              Blank().height(12)

              Row() {
                ColorSelector({ color: FdColors.color0, isSelected: true })
                ColorSelector({ color: FdColors.color1, isSelected: false })
                ColorSelector({ color: FdColors.color2, isSelected: false })
              }
            }
            .alignItems(HorizontalAlign.Start)

            Blank().height(24)
          }
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)

        Row() {
          Text('Add to Cart')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(FdColors.white)
            .width('100%')
            .height(56)
            .textAlign(TextAlign.Center)
            .backgroundColor(FdColors.black)
            .borderRadius(16)
            .layoutWeight(1)

          Stack() {
            Text('♥')
              .fontSize(24)
              .fontColor(FdColors.black)
          }
          .width(56)
          .height(56)
          .backgroundColor(FdColors.bottomActionBg)
          .borderRadius(16)
          .margin({ left: 16 })
        }
        .padding({ left: 24, right: 24, bottom: 24 })
      }
    }
    .backgroundColor(FdColors.white)
    .width('100%')
    .height('100%')
  }
}

@Component
struct ColorSelector {
  @Prop color: string = '#FFFFFF'
  @Prop isSelected: boolean = false

  build() {
    Stack() {
      Circle({ width: 32, height: 32 })
        .fill(this.color)

      if (this.isSelected) {
        Circle({ width: 32, height: 32 })
          .fill('#00000000')
          .border({ width: 2, color: FdColors.selectorStroke })

        Circle({ width: 10, height: 10 })
          .fill(FdColors.white)
      }
    }
    .margin({ right: 12 })
  }
}