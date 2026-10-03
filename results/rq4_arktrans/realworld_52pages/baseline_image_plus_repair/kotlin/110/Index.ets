@Entry
@Component
struct AddNoteScreen {
  @State titleText: string = ''
  @State descriptionText: string = ''
  @State timerDisplay: string = '01:23'
  @State reminderDate: string = 'Jul 20, 2026 3:00 PM'
  @State hasReminder: boolean = true

  // Colors matching the reference
  private readonly BG_COLOR: string = '#FFF0F5' // LavenderBlush / Light Pink
  private readonly TEXT_BLACK: string = '#000000'
  private readonly FAB_COLOR: string = '#EFB8C8'
  private readonly PLACEHOLDER_COLOR: string = '#808080'

  build() {
    Column() {
      // Header Row
      Row() {
        Image($r('app.media.ic_arrow_back'))
          .width(24)
          .height(24)
          .fillColor(this.TEXT_BLACK)
          .onClick(() => {
            // Back action
          })

        Text('New Note')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.TEXT_BLACK)
          .margin({ left: 8 })
      }
      .width('100%')
      .padding({ top: 16, bottom: 16, left: 16, right: 16 })

      // Scrollable Content Area
      Scroll() {
        Column() {
          // Title Input Field
          TextInput({ placeholder: 'Note title (required)' })
            .placeholderColor(this.PLACEHOLDER_COLOR)
            .backgroundColor(Color.Transparent)
            .borderWidth(0)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.TEXT_BLACK)
            .type(InputType.Normal)
            .onChange((value: string) => {
              this.titleText = value
            })

          // Description Input Field
          TextInput({ placeholder: 'Description' })
            .placeholderColor(this.PLACEHOLDER_COLOR)
            .backgroundColor(Color.Transparent)
            .borderWidth(0)
            .fontSize(12)
            .fontColor(this.TEXT_BLACK)
            .type(InputType.Normal)
            .margin({ top: 10 })
            .onChange((value: string) => {
              this.descriptionText = value
            })

          // Timer Display
          Text(this.timerDisplay)
            .fontSize(24)
            .fontColor(this.TEXT_BLACK)
            .textAlign(TextAlign.Center)
            .margin({ top: 24 })

          // Microphone Icon Button
          Row() {
            Image($r('app.media.ic_mic'))
              .width(48)
              .height(48)
              .fillColor(this.TEXT_BLACK)
              .onClick(() => {
                // Record action
              })
          }
          .justifyContent(FlexAlign.Center)
          .margin({ top: 16 })
        }
        .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Reminder Card
      if (this.hasReminder) {
        Row() {
          Image($r('app.media.ic_alarm_on'))
            .width(24)
            .height(24)
            .fillColor(this.TEXT_BLACK)

          Text(this.reminderDate)
            .fontSize(14)
            .fontColor(this.TEXT_BLACK)
            .margin({ left: 16 })
        }
        .width('100%')
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        .backgroundColor('#E6FFFFFF') // Slight transparency effect
        .borderRadius(8)
        .margin({ left: 16, right: 16, top: 16 })
        .onClick(() => {
          // Reminder click action
        })
      }

      // Floating Action Button (Save)
      Row() {
        Image($r('app.media.ic_done'))
          .width(20)
          .height(20)
          .fillColor(this.TEXT_BLACK)

        Text('Save')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.TEXT_BLACK)
          .margin({ left: 4 })
      }
      .padding({ left: 12, right: 12, top: 12, bottom: 12 })
      .backgroundColor(this.FAB_COLOR)
      .borderRadius(16)
      .shadow({ radius: 8, color: '#33000000', offsetY: 4 })
      .alignSelf(ItemAlign.End)
      .margin({ right: 16, bottom: 72 })
      .onClick(() => {
        // Save action
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.BG_COLOR)
  }
}