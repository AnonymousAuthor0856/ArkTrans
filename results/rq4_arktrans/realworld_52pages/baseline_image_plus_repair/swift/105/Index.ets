import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct EmptyListView {
  @State imageSystemName: string = 'questionmark'
  @State label: string = 'No Items'
  @State buttonLabel: string = 'Add item'
  @State randomDescription: string = ''

  private placeholders: string[] = [
    "What's on your mind?",
    "How's been your day?",
    "How are you feeling right now?",
    "It's OK. Write it down.",
    "Make today a little bit better.",
    "Let the words flow.",
    "Capture the moment.",
    "Start the symphony of thoughts."
  ]

  aboutToAppear() {
    if (this.randomDescription === '') {
      const index = Math.floor(Math.random() * this.placeholders.length);
      this.randomDescription = this.placeholders[index];
    }
  }

  build() {
    Column() {
      Image($r('app.media.ic_question')) // Replace with actual icon resource or use system icon
        .width(50)
        .height(50)
        .fillColor(Color.Gray)
        .margin({ bottom: 16 })

      Text(this.label)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 3 })

      Text(this.randomDescription)
        .fontSize(16)
        .fontColor(Color.Gray)
        .margin({ bottom: 15 })

      Button(this.buttonLabel)
        .type(ButtonType.Capsule)
        .backgroundColor('#B8956A')
        .fontColor(Color.White)
        .width('auto')
        .height(40)
        .onClick(() => {
          // Handle button action here
        })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}