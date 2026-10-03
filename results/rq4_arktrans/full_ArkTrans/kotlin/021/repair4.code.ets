@Entry
@Component
struct Index {
  @State notificationsEnabled: boolean = true
  @State syncProgress: number = 0.3

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 16 }) {
        Row({ space: 0 }) {
          Text('Notifications').fontSize(20).fontColor('#1E1E1E')
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.notificationsEnabled }).onChange((isOn: boolean) => {
            this.notificationsEnabled = isOn
          })
        }.alignItems(VerticalAlign.Center).width('100%')

        List({ space: 12 }) {
          ListItem() {
            Column() {
              Column({ space: 8 }) {
                Text('To Do').fontSize(20).fontColor('#2563EB')
                Column({ space: 8 }) {
                  Button('Write report')
                    .backgroundColor('#E5E7EB')
                    .borderRadius(16)
                    .height(40)
                    .margin({ left: 8, right: 8 })
                  Button('Design mockup')
                    .backgroundColor('#E5E7EB')
                    .borderRadius(16)
                    .height(40)
                    .margin({ left: 8, right: 8 })
                }
              }.width('100%').padding(12)
            }.backgroundColor('#FFFFFF').borderRadius(16).shadow({ radius: 4, color: '#1A000000' }).width(220)
          }
          ListItem() {
            Column() {
              Column({ space: 8 }) {
                Text('In Progress').fontSize(20).fontColor('#2563EB')
                Column({ space: 8 }) {
                  Button('Implement feature')
                    .backgroundColor('#E5E7EB')
                    .borderRadius(16)
                    .height(40)
                    .margin({ left: 8, right: 8 })
                  Button('Fix layout bug')
                    .backgroundColor('#E5E7EB')
                    .borderRadius(16)
                    .height(40)
                    .margin({ left: 8, right: 8 })
                }
              }.width('100%').padding(12)
            }.backgroundColor('#FFFFFF').borderRadius(16).shadow({ radius: 4, color: '#1A000000' }).width(220)
          }
        }.listDirection(Axis.Horizontal).width('100%')

        Text('Task Completion').fontSize(20).fontColor('#1E1E1E')
        Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
          .width('100%')
          .height(8)
          .color('#2563EB')
          .trackColor('#E5E7EB')
      }.width('100%').height('100%').padding(16).backgroundColor('#F3F4F6')

      Column() {
        Text('Kanban Board')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
          .textAlign(TextAlign.Center)
          .width('100%')
      }.position({ x: 0, y: 0 }).width('100%').height(60).justifyContent(FlexAlign.Center)
    }.width('100%').height('100%')
  }
}