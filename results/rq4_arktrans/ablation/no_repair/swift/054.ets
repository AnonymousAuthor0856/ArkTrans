@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Row() {
          Text('Homework Submit')
            .fontColor('#1E293B')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
        }
        .width('100%')
        .padding({ top: 24, bottom: 24 })

        Scroll() {
          Column() {
            // Assignments Section
            Text('Assignments')
              .fontColor('#1E293B')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .margin({ bottom: 16 })

            Grid() {
              GridItem() {
                Column() {
                  Rect().fill('#06B6D4').borderRadius(8).width(40).height(40)
                  Blank()
                  Text('Linear Algebra HW1').fontColor('#1E293B').fontSize(16).fontWeight(FontWeight.Medium)
                  Text('Submitted').fontColor('#1E293B').fontSize(14)
                }
                .width('100%')
                .height(160)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(HorizontalAlign.Center)
                .padding(16)
              }
              GridItem() {
                Column() {
                  Rect().fill('#06B6D4').borderRadius(8).width(40).height(40)
                  Blank()
                  Text('Data Structures HW2').fontColor('#1E293B').fontSize(16).fontWeight(FontWeight.Medium)
                  Text('Pending').fontColor('#1E293B').fontSize(14)
                }
                .width('100%')
                .height(160)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(HorizontalAlign.Center)
                .padding(16)
              }
              GridItem() {
                Column() {
                  Rect().fill('#06B6D4').borderRadius(8).width(40).height(40)
                  Blank()
                  Text('Algorithm HW3').fontColor('#1E293B').fontSize(16).fontWeight(FontWeight.Medium)
                  Text('Graded').fontColor('#1E293B').fontSize(14)
                }
                .width('100%')
                .height(160)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(HorizontalAlign.Center)
                .padding(16)
              }
              GridItem() {
                Column() {
                  Rect().fill('#06B6D4').borderRadius(8).width(40).height(40)
                  Blank()
                  Text('Probability HW4').fontColor('#1E293B').fontSize(16).fontWeight(FontWeight.Medium)
                  Text('Pending').fontColor('#1E293B').fontSize(14)
                }
                .width('100%')
                .height(160)
                .backgroundColor('#FFFFFF')
                .borderRadius(16)
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(HorizontalAlign.Center)
                .padding(16)
              }
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(16)
            .rowsGap(16)
            .width('100%')
            .margin({ bottom: 32 })

            // Progress Chart Section
            Text('Progress Chart')
              .fontColor('#1E293B')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .margin({ bottom: 16 })

            Column() {
              // Week 1
              Column() {
                Row() {
                  Rect().fill('#0EA5E9').borderRadius(8).height(24).width('70%')
                  Blank()
                }.width('100%').backgroundColor('#F1F5F9').borderRadius(8)
                Text('Week 1: 70%').fontColor('#1E293B').fontSize(14).margin({ top: 4 })
              }.margin({ bottom: 16 })

              // Week 2
              Column() {
                Row() {
                  Rect().fill('#0EA5E9').borderRadius(8).height(24).width('90%')
                  Blank()
                }.width('100%').backgroundColor('#F1F5F9').borderRadius(8)
                Text('Week 2: 90%').fontColor('#1E293B').fontSize(14).margin({ top: 4 })
              }.margin({ bottom: 16 })

              // Week 3
              Column() {
                Row() {
                  Rect().fill('#0EA5E9').borderRadius(8).height(24).width('50%')
                  Blank()
                }.width('100%').backgroundColor('#F1F5F9').borderRadius(8)
                Text('Week 3: 50%').fontColor('#1E293B').fontSize(14).margin({ top: 4 })
              }
            }

            Button('Submit New HW')
              .type(ButtonType.Capsule)
              .backgroundColor('#0EA5E9')
              .fontColor('#FFFFFF')
              .width('60%')
              .height(40)
              .margin({ top: 32 })
          }
          .width('100%')
          .padding(16)
        }
        .layoutWeight(1)
        .linearGradient({
          angle: 90,
          colors: [['#0EA5E9', 0.15], ['#6366F1', 0.1]]
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}