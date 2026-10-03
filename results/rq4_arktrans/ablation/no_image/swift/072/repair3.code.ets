import { drawing } from '@kit.ArkGraphics'

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Column({ space: 16 }) {
        Text('Applicant details')
          .font({ size: 22, weight: FontWeight.Bold })
          .fontColor('#333333') // Approximation for .rfTextDark
          .padding({ bottom: 4 })

        TextInput({ placeholder: 'Field 1' })
          .backgroundColor('#FBF8F3')
          .borderRadius(16)
          .height(50)
          .width('100%')
          .padding(16)
          .fontColor('#333333')
          .fontSize(16)
          .overlay(
            new drawing.DrawTask((context: drawing.DrawingContext, size: drawing.Size) => {
              context.beginPath()
              context.roundRect(0, 0, size.width, size.height, 16)
              context.lineWidth = 1.5
              context.strokeStyle = '#C5B8A9'
              context.stroke()
            })
          )

        TextInput({ placeholder: 'Field 2' })
          .backgroundColor('#FBF8F3')
          .borderRadius(16)
          .height(50)
          .width('100%')
          .padding(16)
          .fontColor('#333333')
          .fontSize(16)
          .overlay(
            new drawing.DrawTask((context: drawing.DrawingContext, size: drawing.Size) => {
              context.beginPath()
              context.roundRect(0, 0, size.width, size.height, 16)
              context.lineWidth = 1.5
              context.strokeStyle = '#C5B8A9'
              context.stroke()
            })
          )

        TextInput({ placeholder: 'Field 3' })
          .backgroundColor('#FBF8F3')
          .borderRadius(16)
          .height(50)
          .width('100%')
          .padding(16)
          .fontColor('#333333')
          .fontSize(16)
          .overlay(
            new drawing.DrawTask((context: drawing.DrawingContext, size: drawing.Size) => {
              context.beginPath()
              context.roundRect(0, 0, size.width, size.height, 16)
              context.lineWidth = 1.5
              context.strokeStyle = '#C5B8A9'
              context.stroke()
            })
          )

        TextInput({ placeholder: 'Field 4' })
          .backgroundColor('#FBF8F3')
          .borderRadius(16)
          .height(50)
          .width('100%')
          .padding(16)
          .fontColor('#333333')
          .fontSize(16)
          .overlay(
            new drawing.DrawTask((context: drawing.DrawingContext, size: drawing.Size) => {
              context.beginPath()
              context.roundRect(0, 0, size.width, size.height, 16)
              context.lineWidth = 1.5
              context.strokeStyle = '#C5B8A9'
              context.stroke()
            })
          )

        Row({ space: 2 }) {
          Button() {
            Text('Cancel')
          }
          Blank()
          Button() {
            Text('Submit')
          }
        }.padding({ top: 80 }).width('100%')

      }
      .width('100%')
      .padding(24)
      .backgroundColor('#FFFFFF') // Approximation for .rfCardBg
      .borderRadius(32)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5') // Background for the page
  }
}