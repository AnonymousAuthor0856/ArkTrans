@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true

  build() {
    Stack() {
      Stack() {
        Column() {
          Column() {
            Row() {
              Blank()
              Text('Kanban Board').fontColor('#1E1E1E').fontSize(28).fontWeight(FontWeight.Bold)
              Blank()
            }.padding({ top: 24, bottom: 16 }).width('100%')
          }

          Column() {
            Row() {
              Text('Notifications').fontColor('#1E1E1E').fontSize(18).fontWeight(FontWeight.Medium)
              Blank()
              Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled })
                .onChange((isOn: boolean) => {
                  this.notificationsEnabled = isOn
                })
                .selectedColor('#2563EB')
            }.width('100%')

            Scroll() {
              Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start, alignItems: ItemAlign.Top }) {
                // To Do Column
                Column() {
                  Text('To Do').fontColor('#2563EB').fontSize(18).fontWeight(FontWeight.Medium)
                  Column({ space: 12 }) {
                    Text('Write report')
                      .textAlign(TextAlign.Center)
                      .backgroundColor('#E5E7EB')
                      .borderRadius(12)
                      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                      .fontColor('#1E1E1E')
                      .fontSize(16)
                    
                    Text('Design mockup')
                      .textAlign(TextAlign.Center)
                      .backgroundColor('#E5E7EB')
                      .borderRadius(12)
                      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                      .fontColor('#1E1E1E')
                      .fontSize(16)
                  }.margin({ top: 16 })
                  Blank()
                }
                .width(240)
                .height(400)
                .backgroundColor('#FFFFFF')
                .borderRadius(24)
                .shadow({ radius: 10, color: '#1F000000', offsetY: 4 })
                .padding(24)

                // In Progress Column
                Column() {
                  Text('In Progress').fontColor('#2563EB').fontSize(18).fontWeight(FontWeight.Medium)
                  Column({ space: 12 }) {
                    Text('Implement API')
                      .textAlign(TextAlign.Center)
                      .backgroundColor('#E5E7EB')
                      .borderRadius(12)
                      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                      .fontColor('#1E1E1E')
                      .fontSize(16)
                    
                    Text('Fix layout bug')
                      .textAlign(TextAlign.Center)
                      .backgroundColor('#E5E7EB')
                      .borderRadius(12)
                      .padding({ left: 24, right: 24, top: 12, bottom: 12 })
                      .fontColor('#1E1E1E')
                      .fontSize(16)
                  }.margin({ top: 16 })
                  Blank()
                }
                .width(240)
                .height(400)
                .backgroundColor('#FFFFFF')
                .borderRadius(24)
                .shadow({ radius: 10, color: '#1F000000', offsetY: 4 })
                .padding(24)
              }
              .justifyContent(FlexAlign.Start)
              .alignItems(ItemAlign.Top)
              .width('100%')
              .padding({ vertical: 8 })
            }.scrollable(ScrollDirection.Horizontal).width('100%')

            Text('Task Completion').fontColor('#1E1E1E').fontSize(18).fontWeight(FontWeight.Medium).margin({ top: 24 })
            
            Progress({ value: 65, total: 100, type: ProgressType.Linear })
              .width('100%')
              .height(8)
              .color('#2563EB')
              .trackColor('#E5E7EB')
              .margin({ top: 12 })
          }
          .width('100%')
          .layoutWeight(1)
          .padding(24)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#F3F4F6')
      }
    }.width('100%').height('100%')
  }
}