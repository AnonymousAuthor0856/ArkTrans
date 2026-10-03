@Entry
@Component
struct Index {
  @State timerDisplay: string = '01:23'
  @State reminderDate: string = 'Jul 20, 2026 3:00 PM'

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column() {
        // Header Row
        Row() {
          Image($r('app.media.startIcon')).width(48).height(48)
          Blank().width(8)
          Text('New Note').fontSize(18).fontWeight(FontWeight.Bold).fontColor('#000000')
        }.alignItems(VerticalAlign.Center).width('100%').padding({ left: 8, top: 16, right: 16 })

        // Scrollable Content Area
        Column() {
          TextInput({ placeholder: 'Note title (required)' }).placeholderFont({ size: 16 }).placeholderColor('#555555').borderWidth(0)
          
          Blank().height(10)
          
          TextInput({ placeholder: 'Description' }).placeholderFont({ size: 12 }).placeholderColor('#555555').borderWidth(0)
          
          Blank().height(24)
          
          Text(this.timerDisplay).fontSize(24).textAlign(TextAlign.Center).fontColor('#000000')
          
          Blank().height(16)
          
          Button() {
            Image($r('app.media.startIcon')).width(48).height(48)
          }.backgroundColor(Color.Transparent).borderWidth(0)
        }.layoutWeight(1).padding({ left: 16, right: 16, top: 16, bottom: 16 })

        // Reminder Card
        Column() {
          Row() {
            Image($r('app.media.startIcon')).width(48).height(48)
            Blank().width(16)
            Text(this.reminderDate).fontSize(14).fontColor('#000000')
          }.alignItems(VerticalAlign.Center).width('100%').backgroundColor('#FCE4EC').padding({ left: 12, right: 12, top: 8, bottom: 8 })
        }.width('100%').padding({ left: 16, right: 16 }).backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' })
      }.width('100%').height('100%')

      // Floating Action Button
      Button() {
        Row() {
          Image($r('app.media.startIcon')).width(20).height(20)
          Blank().width(4)
          Text('Save').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#000000')
        }.alignItems(VerticalAlign.Center)
      }
      .width(100)
      .height(56)
      .backgroundColor('#F48FB1')
      .borderRadius(16)
      .shadow({ radius: 6, color: '#3F000000' })
      .margin({ end: 16, bottom: 72 })
      .position({ x: 'auto', y: 'auto' }) // Positioning handled by Stack alignment if needed, but here we use margin on the button itself relative to parent or absolute positioning. 
      // To strictly follow the skeleton's "BottomEnd" intent with margins:
      .position({ x: '100%', y: '100%' }) // Move to bottom right corner
      .translate({ x: -116, y: -128 }) // Offset by width + margin and height + margin
    }.width('100%').height('100%').backgroundColor('#FFF0F5')
  }
}