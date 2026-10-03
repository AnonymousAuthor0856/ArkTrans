@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column() {
        Image($r('app.media.startIcon')).width(50).height(50).margin({ bottom: 16 })
        Text('No Items').fontWeight(FontWeight.Bold).fontSize(24).margin({ bottom: 3 })
        Text('Make today a little bit better.').fontColor('#8E8E93').margin({ bottom: 15 })
        Button() {
          Text('Add item').fontColor('#A67C52')
        }
      }.alignItems(HorizontalAlign.Center)
    }.width('100%').height('100%')
  }
}