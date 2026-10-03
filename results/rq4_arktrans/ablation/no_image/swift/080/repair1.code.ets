@Entry
@Component
struct Index {
  build() {
    Stack() {
      Stack() {
        Column({ space: 0 }) {
          Row() {
            Button() {}
            Blank()
            Text('Details').fontColor(Color.Black).fontSize(18).fontWeight(FontWeight.Medium)
            Blank()
            Button() {}
          }

          Scroll() {
            Column({ space: 0 }) {
              Blank().height(24)

              Stack() {
                Rect().fill('#F5F5F5')
                Image('').width(80).height(80).objectFit(ImageFit.Contain)
              }.width('100%').height(300)

              Blank().height(32)

              Column({ space: 0 }) {
                Row() {
                  Column({ space: 8 }) {
                    Text('Modern Lounge\nChair').lineSpacing(4).fontColor(Color.Black).fontSize(26).fontWeight(FontWeight.Bold)
                    Text('Minimalist Series').fontColor(Color.Gray).fontSize(16)
                  }
                  Blank()
                  Text('$1299').fontColor(Color.Black).fontSize(24).fontWeight(FontWeight.Bold)
                }

                Blank().height(24)

                Row({ space: 0 }) {
                  Image('').width(20).height(20).objectFit(ImageFit.Contain)
                  Blank().width(4)
                  Text('4.8').fontColor(Color.Black).fontSize(16).fontWeight(FontWeight.Bold)
                  Blank().width(8)
                  Text('(238 Reviews)').fontColor(Color.Gray).fontSize(14)
                }

                Blank().height(24)

                Text('Colors').fontColor(Color.Black).fontSize(18).fontWeight(FontWeight.Medium)

                Blank().height(12)

                Row({ space: 12 }) {
                  ColorSelector({ color: '#212121', isSelected: true })
                  ColorSelector({ color: '#795448', isSelected: false })
                  ColorSelector({ color: '#9E9E9E', isSelected: false })
                }
              }

              Blank().height(24)
            }.padding({ left: 24, right: 24 }).alignItems(HorizontalAlign.Start)
          }.scrollBar(BarState.Off)

          Row({ space: 16 }) {
            Button() {
              Text('Add to Cart')
                .borderRadius(16)
                .backgroundColor(Color.Black)
                .height(56)
                .width('100%')
                .fontColor(Color.White)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
            }

            Stack() {
              Rect().width(56).height(56).fill('#F5F5F5').borderRadius(16)
              Image('')
            }
          }
        }
      }
    }.width('100%').height('100%')
  }
}

@Component
struct ColorSelector {
  private props: {
    color: string;
    isSelected: boolean;
  } = {
    color: '',
    isSelected: false
  }

  build() {
    Circle()
      .width(40)
      .height(40)
      .fill(this.props.color)
      .border({ width: this.props.isSelected ? 2 : 0, color: Color.Black })
  }
}