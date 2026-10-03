@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column({ space: 0 }) {
        Row({ space: 24 }) {
          Circle().width(48).height(48).fill('#FCE4D1')
          Blank()
          Column({ space: 2 }) {
            Text('QuizForge').fontColor('#000000').fontSize(20).fontWeight(FontWeight.Bold)
            Text('Aroma sprint').fontColor('#757575').fontSize(14).fontWeight(FontWeight.Regular)
          }
          Blank()
          Circle().width(48).height(48).fill('#FCE4D1')
        }.padding({ left: 24, right: 24 })

        Scroll() {
          Column({ space: 30 }) {
            // Main Quiz Card
            Column({ space: 0 }) {
              Row({ space: 24 }) {
                Text('Citrus crafts').fontColor('#261C15').fontSize(18).fontWeight(FontWeight.Medium)
                Blank()
                Text('45%').fontColor('#FFC107').fontSize(16).fontWeight(FontWeight.Bold)
              }.padding({ top: 24, left: 24, right: 24 })

              Row({ space: 4 }) {
                Rect().width(100).height(5).fill('#FF9642')
                Rect().height(5).fill('#EBE6F5')
                  .overlay(
                    () => {
                      Circle().width(4).height(4).fill('#FF9642')
                    },
                    { alignment: Alignment.TopEnd }
                  )
              }.padding({ top: 10, bottom: 12, left: 24, right: 24 })

              Text('Which zest carrier gives the brightest aroma when infused cold?')
                .fontColor('#261C15')
                .fontSize(23)
                .fontWeight(FontWeight.Bold)
                .lineHeight(32)
                .padding({ left: 24, right: 24, bottom: 24 })

              Column({ space: 12 }) {
                Row({ space: 14 }) {
                  Text('Dried peel sachet').fontColor('#261C15').fontSize(10).fontWeight(FontWeight.Medium)
                  Blank()
                }.width('100%').height(48).backgroundColor('#FFE0B2').borderRadius(16)
                  .border({ width: 1, color: '#DEB08C' })
                  .padding({ left: 18, right: 18 })

                Row({ space: 14 }) {
                  Text('Twist garnish').fontColor('#261C15').fontSize(10).fontWeight(FontWeight.Medium)
                  Blank()
                }.width('100%').height(48).backgroundColor('#FFE0B2').borderRadius(16)
                  .border({ width: 1, color: '#DEB08C' })
                  .padding({ left: 18, right: 18 })

                Row({ space: 14 }) {
                  Text('Zester microplane').fontColor('#261C15').fontSize(10).fontWeight(FontWeight.Medium)
                  Blank()
                }.width('100%').height(48).backgroundColor('#FFE0B2').borderRadius(16)
                  .border({ width: 1, color: '#DEB08C' })
                  .padding({ left: 18, right: 18 })

                Row({ space: 14 }) {
                  Text('Candied strip').fontColor('#261C15').fontSize(10).fontWeight(FontWeight.Medium)
                  Blank()
                }.width('100%').height(48).backgroundColor('#FFE0B2').borderRadius(16)
                  .border({ width: 1, color: '#DEB08C' })
                  .padding({ left: 18, right: 18 })
              }.padding({ left: 24, right: 24, bottom: 24 })

              Text('Hint: Think surface area')
                .fontColor('#261C15')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .backgroundColor('#FAF3E0')
                .borderRadius(12)
                .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                .alignSelf(ItemAlign.Start)
                .margin({ left: 24, right: 24, bottom: 24 })
            }.borderRadius(36).backgroundColor('#FFF3E0')

            // Trackers Section
            Column({ space: 16 }) {
              Text('Trackers').fontColor('#261C15').fontSize(24).fontWeight(FontWeight.Bold)
                .alignSelf(ItemAlign.Start).margin({ left: 4 })

              Row({ space: 12 }) {
                Column({ space: 8 }) {
                  Text('Current streak').fontColor('#757575').fontSize(13).fontWeight(FontWeight.Regular)
                    .maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
                  Blank()
                  Text('12').fontColor('#261C15').fontSize(18).fontWeight(FontWeight.Bold)
                }.width('100%').height(100).backgroundColor('#FFE0B2').borderRadius(24)
                  .padding({ left: 16, right: 16, top: 20, bottom: 20 })

                Column({ space: 8 }) {
                  Text('Accuracy').fontColor('#757575').fontSize(13).fontWeight(FontWeight.Regular)
                    .maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
                  Blank()
                  Text('94%').fontColor('#261C15').fontSize(18).fontWeight(FontWeight.Bold)
                }.width('100%').height(100).backgroundColor('#FFE0B2').borderRadius(24)
                  .padding({ left: 16, right: 16, top: 20, bottom: 20 })

                Column({ space: 8 }) {
                  Text('Rank').fontColor('#757575').fontSize(13).fontWeight(FontWeight.Regular)
                    .maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
                  Blank()
                  Text('Gold').fontColor('#261C15').fontSize(18).fontWeight(FontWeight.Bold)
                }.width('100%').height(100).backgroundColor('#FFE0B2').borderRadius(24)
                  .padding({ left: 16, right: 16, top: 20, bottom: 20 })
              }
            }
          }.padding({ left: 16, right: 16, bottom: 40 })
        }
      }
    }.width('100%').height('100%').backgroundColor('#FDFBF7')
  }
}