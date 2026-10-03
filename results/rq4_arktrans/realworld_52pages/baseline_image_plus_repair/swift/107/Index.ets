@Entry
@Component
struct NoResultsView {
  build() {
    Column() {
      // Magnifying glass icon (using a simple SVG path for the magnifying glass)
      Image($r('app.media.magnifying_glass')) // Replace with actual media resource or use a vector drawable
        .width(50)
        .height(50)
        .objectFit(ImageFit.Contain)
        .margin({ bottom: 16 })

      Text("No Results")
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 3 })

      Text("Check the spelling, try a new search or choose another category.")
        .fontSize(16)
        .fontColor(Color.Gray)
        .textAlign(TextAlign.Center)
        .margin({ bottom: 15 })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .height('100%')
  }
}