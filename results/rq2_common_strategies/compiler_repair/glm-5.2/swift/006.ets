interface WeatherHour {
  hour: string;
  temp: string;
  condition: string;
  color: ResourceColor;
}

interface WeatherDay {
  day: string;
  high: string;
  low: string;
  condition: string;
  color: ResourceColor;
}

@Entry
@Component
struct WeatherPage {
  @State currentLocation: string = "New York";
  @State temperature: string = "72°";
  @State condition: string = "Sunny";
  @State feelsLike: string = "74°";
  @State humidity: string = "45%";
  @State wind: string = "5 mph";

  private primaryBlue: ResourceColor = "#2196F3";
  private primaryGreen: ResourceColor = "#4CAF50";
  private primaryOrange: ResourceColor = "#FF9800";
  private bgColor: ResourceColor = "#F5F7FA";
  private surfaceColor: ResourceColor = "#FFFFFF";
  private surfaceVariant: ResourceColor = "#E8F5E8";
  private textPrimary: ResourceColor = "#263238";
  private textSecondary: ResourceColor = "#263238B3";

  private hourlyForecast: WeatherHour[] = [
    { hour: "Now", temp: "72°", condition: "Sunny", color: this.primaryOrange },
    { hour: "1 PM", temp: "74°", condition: "Sunny", color: this.primaryOrange },
    { hour: "2 PM", temp: "75°", condition: "Sunny", color: this.primaryOrange },
    { hour: "3 PM", temp: "76°", condition: "Cloudy", color: this.primaryBlue },
    { hour: "4 PM", temp: "74°", condition: "Cloudy", color: this.primaryBlue },
    { hour: "5 PM", temp: "72°", condition: "Rain", color: this.primaryGreen },
    { hour: "6 PM", temp: "70°", condition: "Rain", color: this.primaryGreen }
  ];

  private weeklyForecast: WeatherDay[] = [
    { day: "Today", high: "76°", low: "62°", condition: "Sunny", color: this.primaryOrange },
    { day: "Mon", high: "74°", low: "60°", condition: "Cloudy", color: this.primaryBlue },
    { day: "Tue", high: "72°", low: "58°", condition: "Rain", color: this.primaryGreen },
    { day: "Wed", high: "70°", low: "56°", condition: "Rain", color: this.primaryGreen },
    { day: "Thu", high: "73°", low: "59°", condition: "Cloudy", color: this.primaryBlue },
    { day: "Fri", high: "75°", low: "61°", condition: "Sunny", color: this.primaryOrange },
    { day: "Sat", high: "77°", low: "63°", condition: "Sunny", color: this.primaryOrange }
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.bgColor)

      Column() {
        Text("Weather")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textPrimary)
          .margin({ top: 44, bottom: 18 })

        Scroll() {
          Column({ space: 18 }) {
            Column({ space: 10 }) {
              Text(this.currentLocation)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimary)

              Text(this.temperature)
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.textPrimary)

              Text(this.condition)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textSecondary)

              Row() {
                this.WeatherInfoItem("Feels like", this.feelsLike)
                Blank()
                this.WeatherInfoItem("Humidity", this.humidity)
                Blank()
                this.WeatherInfoItem("Wind", this.wind)
              }
              .width('100%')
              .padding({ left: 20, right: 20 })
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.surfaceColor)
            .borderRadius(14)
            .shadow({ radius: 5, color: '#1A000000', offsetX: 0, offsetY: 2 })

            Column({ space: 10 }) {
              Text("Hourly Forecast")
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimary)

              Scroll() {
                Row({ space: 6 }) {
                  ForEach(this.hourlyForecast, (item: WeatherHour) => {
                    Column({ space: 6 }) {
                      Text(item.hour)
                        .fontSize(10)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(this.textPrimary)
                      
                      Circle({ width: 20, height: 20 })
                        .fill(item.color)
                      
                      Text(item.temp)
                        .fontSize(12)
                        .fontWeight(FontWeight.Normal)
                        .fontColor(this.textPrimary)
                    }
                    .width(70)
                    .padding(6)
                    .backgroundColor(this.surfaceColor)
                    .borderRadius(10)
                    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
                  })
                }
              }
              .scrollable(ScrollDirection.Horizontal)
              .scrollBar(BarState.Off)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Column({ space: 10 }) {
              Text("7-Day Forecast")
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textPrimary)

              Column({ space: 6 }) {
                ForEach(this.weeklyForecast, (item: WeatherDay) => {
                  Row() {
                    Text(item.day)
                      .fontSize(12)
                      .fontColor(this.textPrimary)
                      .width(40)
                      .textAlign(TextAlign.Start)
                    
                    Circle({ width: 16, height: 16 })
                      .fill(item.color)
                    
                    Blank()
                    
                    Row({ space: 6 }) {
                      Text(item.high)
                        .fontSize(12)
                        .fontColor(this.textPrimary)
                      Text(item.low)
                        .fontSize(12)
                        .fontColor(this.textSecondary)
                    }
                  }
                  .width('100%')
                  .padding(14)
                  .backgroundColor(this.surfaceColor)
                  .borderRadius(6)
                  .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
                })
              }
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Row() {
              this.WeatherInfoItem("UV Index", "Moderate")
              Blank()
              this.WeatherInfoItem("Sunset", "7:45 PM")
              Blank()
              this.WeatherInfoItem("Visibility", "10 mi")
            }
            .width('100%')
            .padding(18)
            .backgroundColor(this.surfaceVariant)
            .borderRadius(10)
            .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
          }
          .width('100%')
          .padding({ left: 14, right: 14, bottom: 80 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()

        Column() {
          Row() {
            Blank()
            
            this.LocationButton("NY", this.currentLocation === "New York", () => { this.currentLocation = "New York" })
            Blank()
            
            this.LocationButton("London", this.currentLocation === "London", () => { this.currentLocation = "London" })
            Blank()
            
            this.LocationButton("Tokyo", this.currentLocation === "Tokyo", () => { this.currentLocation = "Tokyo" })
            Blank()
          }
          .width('100%')
          .padding({ top: 14, bottom: 14 })
          .backgroundColor(this.surfaceColor)
          .borderRadius({ topLeft: 14, topRight: 14 })
          .shadow({ radius: 5, color: '#1A000000', offsetX: 0, offsetY: -2 })
        }
      }
      .width('100%')
      .height('100%')
    }
  }

  @Builder
  WeatherInfoItem(title: string, value: string) {
    Column({ space: 4 }) {
      Text(title)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textSecondary)
      Text(value)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(this.textPrimary)
    }
  }

  @Builder
  LocationButton(title: string, isSelected: boolean, action: () => void) {
    Button({ type: ButtonType.Normal }) {
      Text(title)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? Color.White : this.textPrimary)
    }
    .onClick(() => {
      action();
    })
    .width(80)
    .height(32)
    .backgroundColor(isSelected ? this.primaryBlue : this.surfaceVariant)
    .borderRadius(10)
  }
}