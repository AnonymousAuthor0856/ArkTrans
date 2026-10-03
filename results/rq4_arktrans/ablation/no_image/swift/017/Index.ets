@Entry
@Component
struct Index {
  @State value1: number = 0.5
  @State value2: number = 0.5
  @State value3: number = 0.5
  @State master: number = 0.8

  build() {
    Stack() {
      Column({ space: 0 }) {
        Text('Audio Mixer Terminal')
          .backgroundColor('#FF000000')
          .height(64)
          .padding({ top: (64 - 26) / 2, bottom: (64 - 26) / 2 })
          .width('100%')
          .fontColor('#FF00FF66')
          .fontSize(26)

        Column({ space: 16 }) {
          Column({ space: 4 }) {
            Text(`Channel 1 ${Math.round(this.value1 * 100)}%`)
              .fontColor('#FFE0E0E0')
              .fontSize(13)
            Slider({ value: this.value1, min: 0, max: 1 })
              .width('100%')
          }

          Column({ space: 4 }) {
            Text(`Channel 2 ${Math.round(this.value2 * 100)}%`)
              .fontColor('#FFE0E0E0')
              .fontSize(13)
            Slider({ value: this.value2, min: 0, max: 1 })
              .width('100%')
          }

          Column({ space: 4 }) {
            Text(`Channel 3 ${Math.round(this.value3 * 100)}%`)
              .fontColor('#FFE0E0E0')
              .fontSize(13)
            Slider({ value: this.value3, min: 0, max: 1 })
              .width('100%')
          }

          Blank().height(16)

          Progress({ value: this.master, total: 1, type: ProgressType.Linear })
            .height(6)
            .width('100%')
            .color('#FF00FF66')

          Text(`Master Volume ${Math.round(this.master * 100)}%`)
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontColor('#FFE0E0E0')
            .fontSize(16)

          Slider({ value: this.master, min: 0, max: 1 })
            .width('100%')

          Button()
            .height(48)
            .borderRadius(8)
            .backgroundColor('#FF00FF66')
        }
        .backgroundColor('#FF000000')
        .width('100%')
        .layoutWeight(1)
        .padding(16)
      }
    }
    .width('100%')
    .height('100%')
  }
}