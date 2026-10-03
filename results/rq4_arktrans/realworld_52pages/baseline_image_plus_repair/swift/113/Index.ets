@Entry
@Component
struct WhatsNewView {
  @State private animate: boolean = false

  aboutToAppear() {
    setTimeout(() => {
      this.animate = true
    }, 1000)
  }

  build() {
    Column() {
      // Header
      Text("What's New in CleanPad")
        .fontWeight(FontWeight.Bold)
        .fontSize(34)
        .fontColor(Color.Black)
        .margin({ top: 60, bottom: 40 })

      // Feature List
      Column() {
        this.NewFeatureItem(
          $r('app.media.ic_line_3_horizontal_decrease_circle_fill'),
          "Every thought finds its place",
          "Easily create and assign categories to organize your notes better"
        )

        this.NewFeatureItem(
          $r('app.media.ic_lock_fill'),
          "Your private notes, still personal",
          "Personal Notes are now called Private Notes to make things clearer"
        )

        this.NewFeatureItem(
          $r('app.media.ic_sparkles'),
          "A smoother, comfier experience",
          "Say hello to a refreshed interface that makes CleanPad smoother, more intuitive, and easier to navigate"
        )
      }
      .width('100%')
      .padding({ left: 20, right: 20 })

      Blank()

      // Dismiss Button
      Button("Great!")
        .width('90%')
        .height(50)
        .borderRadius(25)
        .backgroundColor('#F2F2F7')
        .fontColor(Color.Black)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .shadow({ radius: 10, color: '#10000000', offsetY: 4 })
        .margin({ bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FAFAFA')
    .padding({ top: 50 })
  }

  @Builder
  NewFeatureItem(iconSrc: Resource, title: string, description: string) {
    Row() {
      Image(iconSrc)
        .width(40)
        .height(40)
        .objectFit(ImageFit.Contain)
        .margin({ right: 16 })

      Column() {
        Text(title)
          .fontWeight(FontWeight.Bold)
          .fontSize(20)
          .fontColor(Color.Black)
          .lineHeight(26)
          .margin({ bottom: 4 })

        Text(description)
          .fontSize(16)
          .fontColor('#666666')
          .lineHeight(22)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .width('100%')
    .padding({ top: 20, bottom: 20 })
  }
}