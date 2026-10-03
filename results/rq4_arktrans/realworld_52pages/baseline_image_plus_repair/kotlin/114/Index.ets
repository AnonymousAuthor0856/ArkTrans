// OnboardingPage.ets

@Entry
@Component
struct OnboardingPage {
  @State currentPage: number = 0;
  private swiperController: SwiperController = new SwiperController();

  // Data model for the slides
  private sliderItems: SliderItem[] = [
    {
      title: "Audio Recording",
      description: "Taking notes shouldn't be about typing or writing alone.",
      imageResource: $r('app.media.ic_undraw_empty') // Replace with actual media resource
    },
    {
      title: "Notification",
      description: "Set a reminder for your notes and get notified.",
      imageResource: $r('app.media.ic_undraw_empty')
    },
    {
      title: "Dark Mode",
      description: "Enjoy dark mode for a better night experience.",
      imageResource: $r('app.media.ic_undraw_empty')
    }
  ];

  build() {
    Column() {
      // Main Content Area (Swiper)
      Swiper(this.swiperController) {
        ForEach(this.sliderItems, (item: SliderItem, index: number) => {
          Column() {
            // Image Placeholder
            Image(item.imageResource)
              .width(120)
              .height(120)
              .objectFit(ImageFit.Contain)
            
            // Title
            Text(item.title)
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#000000')
              .margin({ top: 32 })
              .textAlign(TextAlign.Center)
            
            // Description
            Text(item.description)
              .fontSize(12)
              .fontColor(Color.Black.withAlpha(0.7))
              .margin({ top: 12 })
              .textAlign(TextAlign.Center)
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .padding({ left: 24, right: 24 })
        })
      }
      .autoPlay(false)
      .displayCount(1)
      .loop(false)
      .indicator(false) // We use custom dots below
      .onChange((index: number) => {
        this.currentPage = index;
      })
      .layoutWeight(1)

      // Custom Page Indicators (Dots)
      Row() {
        ForEach(Array.from({ length: this.sliderItems.length }), (_item: void, index: number) => {
          Circle({
            width: this.currentPage === index ? 12 : 10,
            height: this.currentPage === index ? 12 : 10
          })
          .fill(this.currentPage === index ? '#986977' : '#AEAEAE')
          .margin({ right: index < this.sliderItems.length - 1 ? 8 : 0 })
        })
      }
      .margin({ top: 16, bottom: 16 })

      // Get Started Button
      Button("Get Started")
      .width('40%')
      .height(48)
      .backgroundColor('#D29DAC')
      .borderRadius(12)
      .fontColor('#000000')
      .fontWeight(FontWeight.Medium)
      .fontSize(14)
      
      Blank()
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFECF1')
    .padding(16)
  }
}

interface SliderItem {
  title: string;
  description: string;
  imageResource: Resource;
}