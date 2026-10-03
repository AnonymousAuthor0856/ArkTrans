@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        Row() {
          Column() {
            Text('Hi there!')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
            Text('Welcome back')
              .fontSize(12)
              .fontColor('#999999')
          }.layoutWeight(1)

          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
          }
            .backgroundColor(Color.Transparent)
            .borderRadius(8)
        }
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .padding({ left: 16, top: 16, right: 8 })

        Blank().height(16)

        Column() {
          Image($r('app.media.startIcon'))
            .width(120)
            .height(120)
            .objectFit(ImageFit.Contain)
          
          Blank().height(8)

          Text('Your record list is empty.\nClick the button below to get started.')
            .fontSize(12)
            .fontColor('#999999')
            .textAlign(TextAlign.Center)
            .lineHeight(18)
        }
          .alignItems(HorizontalAlign.Center)
          .width('100%')
          .layoutWeight(1)

        Grid() {
          GridItem() {
            Column() {
              Column() {
                Row() {
                  Text('note.title')
                    .fontSize(12)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#FFFFFF')
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .layoutWeight(1)
                  
                  Blank().width(4)
                  
                  Text('formatDateStamp(note.lastModificationDate)')
                    .fontSize(10)
                    .fontColor('#FFFFFF')
                    .maxLines(1)
                }.width('100%')

                Blank().height(8)

                Row() {
                  Image($r('app.media.startIcon'))
                    .width(14)
                    .height(14)
                    .objectFit(ImageFit.Contain)
                  
                  Blank().width(4)
                  
                  Text('formatAudioLength(note.audioLength)')
                    .fontSize(12)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#FFFFFF')
                  
                  Blank().layoutWeight(1)
                  
                  Text('note.size')
                    .fontSize(12)
                    .fontColor('#FFFFFF')
                }
                  .alignItems(VerticalAlign.Center)
                  .width('100%')

                Blank().height(8)

                Row() {
                  Image($r('app.media.startIcon'))
                    .width(14)
                    .height(14)
                    .objectFit(ImageFit.Contain)
                    .opacity(0.6)
                  
                  Blank().width(4)
                  
                  Text('if (reminder != null) formatReminderText(reminder)\nelse "No reminder set"')
                    .fontSize(12)
                    .fontColor('#FFFFFF')
                    .opacity(0.6)
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                }
                  .alignItems(VerticalAlign.Center)
                  .width('100%')
              }
                .backgroundColor('#EADDFF')
                .padding(8)
            }
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000' })
          }
        }
          .columnsTemplate('1fr 1fr')
          .columnsGap(8)
          .rowsGap(8)
          .width('100%')
          .padding(8)
      }
        .width('100%')
        .height('100%')
        .padding(16)
        .backgroundColor('#FFF0F5')

      Button() {
        Image($r('app.media.startIcon'))
          .width(28)
          .height(28)
          .objectFit(ImageFit.Contain)
      }
        .width(56)
        .height(56)
        .backgroundColor('#F4ABBD')
        .borderRadius(16)
        .shadow({ radius: 6, color: '#3F000000' })
        .margin(24)
    }
      .width('100%')
      .height('100%')
  }
}