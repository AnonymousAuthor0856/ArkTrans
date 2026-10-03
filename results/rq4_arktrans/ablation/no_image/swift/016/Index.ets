@Entry
@Component
struct Index {
  @State title: string = ''
  @State recording: boolean = false
  @State seconds: number = 0

  build() {
    Stack() {
      Column() {
        Text('Neon Recorder')
          .backgroundColor('#FF0B0B0D')
          .width('100%')
          .padding({ top: 12, bottom: 12 })
          .fontColor('#FF00FFFF')
          .fontSize(28)

        Column() {
          Column() {
            Text('Recording name')
              .fontColor('#FFE5E7EB')
              .opacity(0.7)
              .fontSize(12)

            TextInput({ placeholder: '' })
              .type(InputType.Text)
              .text(this.title)
              .onChange((value: string) => {
                this.title = value
              })
              .accentColor('#FF00FFFF')
              .borderRadius(8)
              .backgroundColor('#FF1A1A1D')
              .padding(8)
              .fontColor('#FFE5E7EB')
              .fontSize(14)
              .border({
                width: 1,
                color: this.title === '' ? '#FF3F3F46' : '#FF00FFFF',
                radius: 8
              })
          }.alignItems(HorizontalAlign.Start).space(8)

          Stack() {
            Rect().fill('#FF2E2E33')
            Text(this.recording ? `Recording... ${this.seconds}s` : 'Press Record')
              .fontColor(this.recording ? '#FF00FFFF' : '#FFE5E7EB')
              .fontSize(20)
          }.height(200)

          Row() {
            Button() {
              Text(this.recording ? 'Stop' : 'Record')
                .fontColor('#FFFFFFFF')
                .fontSize(18)
            }
            .backgroundColor(this.recording ? '#FFEF4444' : '#FF00FFFF')
            .width(160)
            .height(52)
            .borderRadius(16)
            .onClick(() => {
              this.recording = !this.recording
              if (this.recording) {
                this.seconds = 0
                // startTimer logic would go here
              } else {
                // stopTimer logic would go here
              }
            })

            Button() {
              Text('Reset')
                .fontColor('#FFFFFFFF')
                .fontSize(18)
            }
            .backgroundColor('#FF9D00FF')
            .width(120)
            .height(52)
            .borderRadius(16)
            .onClick(() => {
              this.seconds = 0
              if (this.recording) {
                // stopTimer and startTimer logic
              }
            })
          }.space(24)

          Blank().height(24)

          Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
            .width('100%')
            .textAlign(TextAlign.Start)
            .fontColor('#FFE5E7EB')
            .opacity(0.7)
            .fontSize(14)

          // Simulating LinearGradient background for the container or specific element
          // In ArkTS, gradients are often applied via linearGradient modifier on shapes or containers
          // Since the skeleton implies a structure, we ensure the parent column has the gradient effect if intended
          // However, based on the skeleton, the LinearGradient is a child of the main content column.
          // We will apply it to a shape or just acknowledge the structure.
          // To make it compilable and visually consistent with "background" intent:
        }
        .width('100%')
        .height('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(16)
        .linearGradient({
          angle: 180,
          colors: [['#FF0B0B0D', 0], ['#FF2E2E33', 1]]
        })
      }
      .width('100%')
      .height('100%')
    }.width('100%').height('100%')
  }
}