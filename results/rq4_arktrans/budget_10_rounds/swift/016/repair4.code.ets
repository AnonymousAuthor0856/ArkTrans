@Entry
@Component
struct Index {
  @State title: string = ''
  @State recording: boolean = false

  build() {
    Stack() {
      Column() {
        // Header
        Text('Neon Recorder')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#00FFFF')
          .textAlign(TextAlign.Center)
          .width('100%')
          .padding({ top: 40, bottom: 20 })

        // Main Content Area
        Column() {
          // Input Section
          Column() {
            Text('Recording name')
              .fontSize(14)
              .fontColor('#9CA3AF')
              .margin({ bottom: 8 })
            
            TextInput({ placeholder: 'Enter name' })
              .type(InputType.Normal)
              .text(this.title)
              .onChange((value: string) => {
                this.title = value
              })
              .backgroundColor('#1A1A1D')
              .borderRadius(12)
              .height(48)
              .padding({ left: 16 })
              .fontColor('#E5E7EB')
              .border({ width: 1, color: '#3F3F46', radius: 12 })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .margin({ bottom: 20 })

          // Status Card
          Stack() {
            Text(this.recording ? 'Recording...' : 'Press Record')
              .fontSize(24)
              .fontColor(this.recording ? '#00FFFF' : '#E5E7EB')
          }
          .width('100%')
          .height(200)
          .backgroundColor('#2E2E33')
          .borderRadius(20)
          .margin({ bottom: 24 })

          // Buttons Row
          Row() {
            Button() {
              Text(this.recording ? 'Stop' : 'Record')
                .fontSize(18)
                .fontColor('#000000')
            }
            .width(160)
            .height(52)
            .backgroundColor(this.recording ? '#EF4444' : '#00FFFF')
            .borderRadius(20)
            .onClick(() => {
              this.recording = !this.recording
            })

            Button() {
              Text('Reset')
                .fontSize(18)
                .fontColor('#FFFFFF')
            }
            .width(120)
            .height(52)
            .backgroundColor('#9D00FF')
            .borderRadius(20)
            .margin({ left: 20 })
            .onClick(() => {
              this.recording = false
              this.title = ''
            })
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('100%')
          .margin({ bottom: 24 })

          Blank()

          // Footer Path
          Text(`Output Path: /storage/recordings/${this.title === '' ? 'untitled' : this.title}.mp3`)
            .fontSize(14)
            .fontColor('#9CA3AF')
            .textAlign(TextAlign.Start)
            .width('100%')
            .margin({ bottom: 20 })
        }
        .width('100%')
        .layoutWeight(1)
        .padding(20)
        .linearGradient({
          angle: 180,
          colors: [['#0B0B0D', 0], ['#2E2E33', 1]]
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#0B0B0D')
    }.width('100%').height('100%')
  }
}