// entry/src/main/ets/components/AddTodoScreen.ets

import { router } from '@kit.ArkUI'

@Entry
@Component
struct AddTodoScreen {
  @State title: string = ''
  @State description: string = ''
  @State selectedPriority: string = 'Low Priority'
  @State isDropdownOpen: boolean = false

  private readonly priorities: string[] = ['High Priority', 'Medium Priority', 'Low Priority']

  build() {
    Column() {
      // Top Bar
      Row() {
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .fillColor(Color.White)
          .onClick(() => {
            router.back()
          })

        Text('Add ToDo')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
          .margin({ left: 16 })

        Blank()

        Image($r('app.media.check'))
          .width(24)
          .height(24)
          .fillColor(Color.White)
          .onClick(() => {
            // Save logic here
            console.info(`Saved: ${this.title}`)
            router.back()
          })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#6750A4') // Material You Primary Purple
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          // Title Field
          TextInput({ placeholder: 'Title' })
            .type(InputType.Normal)
            .text(this.title)
            .onChange((value: string) => {
              this.title = value
            })
            .borderRadius(4)
            .border({ width: 1, color: '#939597' })
            .margin({ top: 24, left: 24, right: 24 })
            .height(56)
            .backgroundColor(Color.White)

          // Priority Dropdown
          Column() {
            Row() {
              Text(this.selectedPriority)
                .fontSize(16)
                .fontColor(this.selectedPriority === 'Low Priority' && this.selectedPriority.length > 0 ? Color.Black : '#939597')
                .layoutWeight(1)
              
              Image($r('app.media.expand_more'))
                .width(24)
                .height(24)
                .fillColor('#939597')
            }
            .width('100%')
            .height(56)
            .padding({ left: 16, right: 16 })
            .onClick(() => {
              this.isDropdownOpen = !this.isDropdownOpen
            })
          }
          .width('100%')
          .borderRadius(4)
          .border({ width: 1, color: '#939597' })
          .margin({ top: 8, left: 24, right: 24 })
          .backgroundColor(Color.White)

          // Dropdown Menu (Overlay)
          if (this.isDropdownOpen) {
            Column() {
              ForEach(this.priorities, (priority: string) => {
                Text(priority)
                  .fontSize(16)
                  .fontColor(Color.Black)
                  .width('100%')
                  .padding({ left: 16, right: 16, top: 12, bottom: 12 })
                  .onClick(() => {
                    this.selectedPriority = priority
                    this.isDropdownOpen = false
                  })
              })
            }
            .width('100%')
            .backgroundColor(Color.White)
            .border({ width: 1, color: '#E0E0E0' })
            .position({ x: 24, y: 130 }) // Approximate position below the dropdown trigger
            .zIndex(10)
          }

          // Description Field
          TextArea({ placeholder: 'Description' })
            .text(this.description)
            .onChange((value: string) => {
              this.description = value
            })
            .borderRadius(4)
            .border({ width: 1, color: '#939597' })
            .margin({ top: 16, left: 24, right: 24 })
            .height(300)
            .backgroundColor(Color.White)
            .padding(16)
        }
        .width('100%')
        .padding({ bottom: 40 })
      }
      .layoutWeight(1)
      .backgroundColor('#FDFDFD') // Light background
    }
    .width('100%')
    .height('100%')
  }
}