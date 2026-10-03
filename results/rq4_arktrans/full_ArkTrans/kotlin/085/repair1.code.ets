@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      List() {
        ListItem() {
          Column({ space: 0 }) {
            Text('Good Morning,').fontColor('#888888')
            Text('My Jungle').fontWeight(FontWeight.Bold).fontSize(42)
          }.padding({ left: 24, right: 24, top: 16, bottom: 16 })
        }

        ListItem() {
          Text('Pending Tasks').fontWeight(FontWeight.Bold).fontSize(20).fontColor('#1A1A1A').padding({ left: 24, right: 24, top: 12, bottom: 12 })
        }

        ListItem() {
          List({ space: 16 }) {
            ListItem() {
              Column() {
                Column({ space: 0 }) {
                  Row({ space: 0 }) {
                    Stack({ alignContent: Alignment.Center }) {
                      Image($r('app.media.startIcon'))
                    }.width(40).height(40).borderRadius(20).backgroundColor('#FFFFFF')
                  }.width('100%')

                  Column({ space: 0 }) {
                    Text('Watering').fontWeight(FontWeight.Bold).fontSize(16).fontColor('#1A1A1A')
                    Text('Monstera Deliciosa').fontColor('#888888').maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
                    Blank().height(8)
                    Stack({ alignContent: Alignment.Center }) {
                      Text('Today').fontWeight(FontWeight.Bold).fontSize(12).fontColor('#1A1A1A')
                    }.backgroundColor('#E0E0E0').borderRadius(4).padding({ left: 6, right: 6, top: 2, bottom: 2 })
                  }
                }.width('100%').height('100%').padding(16)
              }.width(160).height(180).backgroundColor('#F7F7F7').borderRadius(24).border({ width: 1, color: '#EEEEEE' })
            }

            ListItem() {
              Column() {
                Column({ space: 0 }) {
                  Row({ space: 0 }) {
                    Stack({ alignContent: Alignment.Center }) {
                      Image($r('app.media.startIcon'))
                    }.width(40).height(40).borderRadius(20).backgroundColor('#FFFFFF')
                  }.width('100%')

                  Column({ space: 0 }) {
                    Text('Fertilize').fontWeight(FontWeight.Bold).fontSize(16).fontColor('#1A1A1A')
                    Text('Fiddle Leaf Fig').fontColor('#888888').maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis })
                    Blank().height(8)
                    Stack({ alignContent: Alignment.Center }) {
                      Text('Tomorrow').fontWeight(FontWeight.Bold).fontSize(12).fontColor('#1A1A1A')
                    }.backgroundColor('#E0E0E0').borderRadius(4).padding({ left: 6, right: 6, top: 2, bottom: 2 })
                  }
                }.width('100%').height('100%').padding(16)
              }.width(160).height(180).backgroundColor('#F7F7F7').borderRadius(24).border({ width: 1, color: '#EEEEEE' })
            }
          }.listDirection(Axis.Horizontal).width('100%').padding({ left: 24, right: 24 })
        }

        ListItem() {
          Column() {
            Blank().height(32)
          }
        }

        ListItem() {
          Text('Your Collection').fontWeight(FontWeight.Bold).fontSize(20).fontColor('#1A1A1A').padding({ left: 24, right: 24, top: 12, bottom: 12 })
        }

        ListItem() {
          Row({ space: 0 }) {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
            }.width(56).height(56).borderRadius(12).backgroundColor('#EEEEEE')

            Blank().width(16)

            Column({ space: 0 }) {
              Text('Monstera').fontWeight(FontWeight.Bold).fontSize(16).fontColor('#1A1A1A')
              Text('Monstera deliciosa').fontStyle(FontStyle.Italic).fontColor('#888888')
              Blank().height(8)
              Row({ space: 0 }) {
                Image($r('app.media.startIcon')).width(12).height(12)
                Blank().width(4)
                Text('Indoor').fontSize(12).fontColor('#888888')
              }.alignItems(VerticalAlign.Center)
            }.layoutWeight(1)

            Column({ space: 0 }) {
              Image($r('app.media.startIcon')).width(24).height(24)
              Text('Water').fontWeight(FontWeight.Bold).fontSize(12).fontColor('#2E7D32')
              Text('0 days').fontSize(12).fontColor('#888888')
            }.alignItems(HorizontalAlign.End)
          }.alignItems(VerticalAlign.Center).width('100%').padding(16).backgroundColor('#FAFAFA').borderRadius(16)
        }
      }.width('100%').height('100%').backgroundColor('#FFFFFF').layoutWeight(1)

      Row({ space: 0 }) {
        Button() {
          Image($r('app.media.startIcon'))
        }.width(40).height(40).borderRadius(20).backgroundColor('#F5F5F5')

        Blank().layoutWeight(1)

        Button() {
          Image($r('app.media.startIcon'))
        }.width(40).height(40).borderRadius(20).backgroundColor('#F5F5F5')
      }.alignItems(VerticalAlign.Center).width('100%').padding({ top: 24, left: 24, right: 24, bottom: 8 })

      Button() {
        Image($r('app.media.startIcon'))
      }.width(56).height(56).borderRadius(28).backgroundColor('#1A1A1A').margin(24).shadow({ radius: 6, color: '#3F000000', offsetY: 4 }).position({ x: 'auto', y: 'auto' }).margin({ right: 24, bottom: 90 })

      Row({ space: 0 }) {
        Button() {
          Image($r('app.media.startIcon'))
        }
        Button() {
          Image($r('app.media.startIcon'))
        }
        Blank().width(32)
        Button() {
          Image($r('app.media.startIcon'))
        }
        Button() {
          Image($r('app.media.startIcon'))
        }
      }.justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).width('100%').backgroundColor('#FFFFFF').padding({ left: 48, right: 48, top: 24, bottom: 24 })
    }.width('100%').height('100%')
  }
}