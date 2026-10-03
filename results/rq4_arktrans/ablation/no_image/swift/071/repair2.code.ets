@Entry
@Component
struct Index {
  build() {
    Stack() {
      Stack() {
        Column({ space: 0 }) {
          Row() {
            Circle().width(48).height(48).fill('#FCE4D1')
            Blank()
            Column({ space: 2 }) {
              Text('QuizForge').fontColor(Color.Black).fontSize(20).fontWeight(FontWeight.Bold)
              Text('Aroma sprint').fontColor('#666666').fontSize(14).fontWeight(FontWeight.Regular)
            }
            Blank()
            Circle().width(48).height(48).fill('#FCE4D1')
          }.padding({ left: 24, right: 24 })

          Scroll() {
            Column() {
              Column() {
                Row() {
                  Text('Citrus crafts').fontColor('#333333').fontSize(18).fontWeight(FontWeight.Medium)
                  Blank()
                  Text('45%').fontColor('#FF9642').fontSize(16).fontWeight(FontWeight.Bold)
                }.padding({ top: 24, left: 24, right: 24 })

                Row({ space: 4 }) {
                  Rect().width(100).height(5).fill('#FF9642')
                  Rect().height(5).fill('#EBE6F5').overlay(
                    () => {
                      Circle().fill('#FF9642').width(4).height(4).offset({ x: 2 })
                    },
                    { alignment: Alignment.End }
                  )
                }.padding({ top: 10, bottom: 12, left: 24, right: 24 })

                Text('Which zest carrier gives the brightest aroma when infused cold?')
                  .padding({ bottom: 24, left: 24, right: 24 })
                  .lineHeight(27) // approx lineSpacing(4) on size 23
                  .fontColor('#333333')
                  .fontSize(23)
                  .fontWeight(FontWeight.Bold)

                Column({ space: 12 }) {
                  Row() {
                    Text('').fontColor('#333333').fontSize(10).fontWeight(FontWeight.Medium)
                    Blank()
                  }.padding({ top: 14, bottom: 14, left: 18, right: 18 }).backgroundColor('#FFF0E6').borderRadius(16).border({ width: 1, color: '#DFAAF0' })

                  Row() {
                    Text('').fontColor('#333333').fontSize(10).fontWeight(FontWeight.Medium)
                    Blank()
                  }.padding({ top: 14, bottom: 14, left: 18, right: 18 }).backgroundColor('#FFF0E6').borderRadius(16).border({ width: 1, color: '#DFAAF0' })

                  Row() {
                    Text('').fontColor('#333333').fontSize(10).fontWeight(FontWeight.Medium)
                    Blank()
                  }.padding({ top: 14, bottom: 14, left: 18, right: 18 }).backgroundColor('#FFF0E6').borderRadius(16).border({ width: 1, color: '#DFAAF0' })

                  Row() {
                    Text('').fontColor('#333333').fontSize(10).fontWeight(FontWeight.Medium)
                    Blank()
                  }.padding({ top: 14, bottom: 14, left: 18, right: 18 }).backgroundColor('#FFF0E6').borderRadius(16).border({ width: 1, color: '#DFAAF0' })
                }.padding({ bottom: 24, left: 24, right: 24 })

                Text('Hint: Think surface area')
                  .padding({ bottom: 24, left: 24, right: 24 })
                  .borderRadius(12)
                  .backgroundColor('#F5F5F5')
                  .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                  .fontColor('#333333')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
              }.borderRadius(36).backgroundColor('#FFEFE8')

              Column({ space: 16 }) {
                Text('Trackers').padding({ left: 4 }).fontColor('#333333').fontSize(24).fontWeight(FontWeight.Bold)

                Row({ space: 12 }) {
                  Column({ space: 8 }) {
                    Text('Label').fontColor('#666666').fontSize(13).fontWeight(FontWeight.Regular).maxLines(1)
                    Blank()
                    Text('Value').fontColor('#333333').fontSize(18).fontWeight(FontWeight.Bold).minFontSize(14)
                  }.padding({ top: 20, bottom: 20, left: 16, right: 16 }).backgroundColor('#F0F0F0').borderRadius(24).width('100%').height(100)

                  Column({ space: 8 }) {
                    Text('Label').fontColor('#666666').fontSize(13).fontWeight(FontWeight.Regular).maxLines(1)
                    Blank()
                    Text('Value').fontColor('#333333').fontSize(18).fontWeight(FontWeight.Bold).minFontSize(14)
                  }.padding({ top: 20, bottom: 20, left: 16, right: 16 }).backgroundColor('#F0F0F0').borderRadius(24).width('100%').height(100)

                  Column({ space: 8 }) {
                    Text('Label').fontColor('#666666').fontSize(13).fontWeight(FontWeight.Regular).maxLines(1)
                    Blank()
                    Text('Value').fontColor('#333333').fontSize(18).fontWeight(FontWeight.Bold).minFontSize(14)
                  }.padding({ top: 20, bottom: 20, left: 16, right: 16 }).backgroundColor('#F0F0F0').borderRadius(24).width('100%').height(100)
                }
              }
            }.padding({ bottom: 40, left: 16, right: 16 })
          }
        }
      }
    }.width('100%').height('100%')
  }
}