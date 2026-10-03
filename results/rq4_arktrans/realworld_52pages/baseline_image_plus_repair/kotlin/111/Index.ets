// EditNoteScreen.ets
import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct EditNoteScreen {
  @State noteColor: string = '#FFECF1'
  @State title: string = 'Meeting Notes'
  @State description: string = 'Discussed Q3 roadmap...'
  @State timerDisplay: string = '02:15'
  @State isPlaying: boolean = true
  @State hasReminder: boolean = true
  @State reminderDate: string = 'Jul 20, 2026 3:00 PM'
  @State reminderCompleted: boolean = false

  private titleController: TextInputController = new TextInputController()
  private descriptionController: TextInputController = new TextInputController()

  build() {
    Column() {
      // Header row with back button and actions
      Row() {
        // Back button
        Button() {
          Image('ic_arrow_back')
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          router.back();
        })

        Text('Edit Note')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ left: 8 })
          .layoutWeight(1)

        // Delete button
        Button() {
          Image('ic_delete')
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          // Handle delete action
        })

        // Share button
        Button() {
          Image('ic_share')
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          // Handle share action
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 8 })

      // Scrollable content area
      Scroll() {
        Column() {
          // Title input field
          TextInput({ placeholder: 'Note title (required)' })
            .text(this.title)
            .controller(this.titleController)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
            .placeholderColor(Color.Gray)
            .backgroundColor(Color.Transparent)
            .borderWidth(0)
            .onChange((value: string) => {
              this.title = value;
            })

          // Description input field
          TextInput({ placeholder: 'Description' })
            .text(this.description)
            .controller(this.descriptionController)
            .fontSize(12)
            .fontColor(Color.Black)
            .placeholderColor(Color.Gray)
            .backgroundColor(Color.Transparent)
            .borderWidth(0)
            .margin({ top: 10 })
            .type(InputType.Normal)
            .maxLength(500)
            .onChange((value: string) => {
              this.description = value;
            })

          // Timer display
          Text(this.timerDisplay)
            .fontSize(24)
            .fontColor(Color.Black)
            .textAlign(TextAlign.Center)
            .margin({ top: 24 })

          // Play/Pause button
          Button() {
            if (this.isPlaying) {
              Image('ic_pause')
                .width(48)
                .height(48)
                .fillColor(Color.Black)
            } else {
              Image('ic_play')
                .width(48)
                .height(48)
                .fillColor(Color.Black)
            }
          }
          .backgroundColor(Color.Transparent)
          .margin({ top: 16 })
          .onClick(() => {
            this.isPlaying = !this.isPlaying;
          })
        }
        .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      }
      .layoutWeight(1)

      // Reminder section
      Row() {
        Image('ic_alarm')
          .width(24)
          .height(24)
          .fillColor(Color.Black)

        if (this.hasReminder && this.reminderDate) {
          Text(this.reminderDate)
            .fontSize(14)
            .fontColor(Color.Black)
            .decoration({ type: this.reminderCompleted ? TextDecorationType.LineThrough : TextDecorationType.None })
            .margin({ left: 16 })
        } else {
          Text('Click to add a reminder to this note')
            .fontSize(12)
            .fontColor(Color.Black)
            .margin({ left: 16 })
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor('#FFECECF5')
      .onClick(() => {
        // Handle reminder click
      })

      // Save FAB
      Button() {
        Row() {
          Image('ic_done')
            .width(20)
            .height(20)
            .fillColor(Color.Black)

          Text('Save')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
            .margin({ left: 4 })
        }
      }
      .backgroundColor('#EFB8C8')
      .borderRadius(16)
      .position({ x: 'auto', y: 'auto' })
      .margin({ right: 16, bottom: 72 })
      .onClick(() => {
        // Handle save action
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.noteColor)
  }
}