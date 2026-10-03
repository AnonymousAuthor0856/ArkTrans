@Entry
@Component
struct Index {
  @State bass: number = 40
  @State mid: number = 50
  @State treble: number = 60
  @State master: number = 70

  build() {
    Stack() {
      Column({ space: 0 }) {
        Text('Audio Mixer Terminal')
          .backgroundColor('#000000')
          .height(64)
          .padding({ top: 19, bottom: 19 })
          .width('100%')
          .fontColor('#00FF66')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)

        Column({ space: 24 }) {
          Column({ space: 8 }) {
            Text(`Bass ${this.bass}%`).fontColor('#E0E0E0').fontSize(13).alignSelf(ItemAlign.Start)
            Slider({ value: this.bass, min: 0, max: 100 }).width('100%').trackColor('#222222').selectedColor('#00FF66')
          }

          Column({ space: 8 }) {
            Text(`Mid ${this.mid}%`).fontColor('#E0E0E0').fontSize(13).alignSelf(ItemAlign.Start)
            Slider({ value: this.mid, min: 0, max: 100 }).width('100%').trackColor('#222222').selectedColor('#00FF66')
          }

          Column({ space: 8 }) {
            Text(`Treble ${this.treble}%`).fontColor('#E0E0E0').fontSize(13).alignSelf(ItemAlign.Start)
            Slider({ value: this.treble, min: 0, max: 100 }).width('100%').trackColor('#222222').selectedColor('#00FF66')
          }

          Blank().height(12)

          Progress({ value: this.master, total: 100, type: ProgressType.Linear })
            .height(6)
            .width('100%')
            .color('#00FF66')
            .backgroundColor('#222222')

          Text(`Master Volume ${this.master}%`)
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontColor('#E0E0E0')
            .fontSize(16)

          Slider({ value: this.master, min: 0, max: 100 })
            .width('100%')
            .trackColor('#222222')
            .selectedColor('#00FF66')

          Button('Apply Settings')
            .height(48)
            .borderRadius(12)
            .backgroundColor('#00FF66')
            .fontColor('#000000')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .height('100%')
        .padding(24)
        .backgroundColor('#000000')
      }
    }.width('100%').height('100%')
  }
}