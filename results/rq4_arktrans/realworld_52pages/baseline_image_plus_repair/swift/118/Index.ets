@Entry
@Component
struct CityWeatherView {
  @State private city: string = "Chambéry"
  @State private isLoading: boolean = true

  build() {
    Column() {
      Text(this.city)
        .fontSize(34)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 60, bottom: 20 })

      WeatherSection({ title: "NOW" })
      WeatherSection({ title: "HOURLY" })
      WeatherSection({ title: "THIS WEEK" })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F2F7')
  }
}

@Component
struct WeatherSection {
  @Prop title: string

  build() {
    Column() {
      Text(this.title.toUpperCase())
        .fontSize(15)
        .fontColor('#8E8E93')
        .margin({ top: 16, bottom: 8 })
    }
    .width('100%')
    .padding({ left: 20 })
  }
}