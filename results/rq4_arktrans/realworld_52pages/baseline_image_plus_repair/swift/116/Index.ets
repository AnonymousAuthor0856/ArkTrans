import { BusinessError } from '@kit.BasicServicesKit';
import { common, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct CityListView {
  @State cities: City[] = [new City("Chambéry")];
  @State weathers: Map<string, Weather> = new Map();
  @State isPresentingModal: boolean = false;

  aboutToAppear() {
    this.fetchAllWeather();
  }

  build() {
    Column() {
      // Navigation Bar
      Row() {
        Text('Edit')
          .font({ size: 17, weight: 500 })
          .fontColor('#007AFF')
          .onClick(() => {
            // Handle edit action
          })

        Flex().layoutWeight(1)

        Text('Weather')
          .font({ size: 34, weight: 700 })
          .fontColor('#000000')

        Flex().layoutWeight(1)

        Button() {
          Image($r('app.media.ic_add'))
            .width(24)
            .height(24)
            .fillColor(Color.White)
        }
        .backgroundColor('#007AFF')
        .borderRadius(20)
        .width(40)
        .height(40)
        .onClick(() => {
          this.isPresentingModal = true;
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })

      // Content Area
      Column() {
        // Section Header
        Text('YOUR CITIES')
          .font({ size: 15, weight: 600 })
          .fontColor('#8E8E93')
          .letterSpacing(0.5)
          .margin({ top: 16, bottom: 8, left: 16 })

        // List Container
        Column() {
          ForEach(this.cities, (city: City) => {
            this.cityRow(city)
          }, (item: City) => item.name)
        }
        .backgroundColor(Color.White)
        .borderRadius(12)
        .margin({ left: 16, right: 16 })
        .shadow({ radius: 2, color: '#F2F2F7', offsetX: 0, offsetY: 1 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F2F7')
  }

  @Builder
  cityRow(city: City) {
    Row() {
      Text(city.name)
        .font({ size: 28, weight: 400 })
        .fontColor('#000000')
        .lineHeight(36)

      Flex().layoutWeight(1)

      if (this.weathers.has(city.id)) {
        const weatherData = this.weathers.get(city.id);
        if (weatherData) {
          Row() {
            Image($r('app.media.ic_weather_placeholder'))
              .width(24)
              .height(24)
              .fillColor('#8E8E93')
            
            Text(weatherData.current.temperature + '°')
              .font({ size: 28, weight: 400 })
              .fontColor('#8E8E93')
              .margin({ left: 8 })
          }
        }
      } else {
        // Loading Placeholder
        Row() {
          Rect()
            .fill('#E5E5EA')
            .borderRadius(4)
            .width(60)
            .height(24)
        }
      }

      Image($r('app.media.ic_arrow_right'))
        .width(14)
        .height(14)
        .fillColor('#C7C7CC')
        .margin({ left: 16 })
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 16, bottom: 16 })
    .onClick(() => {
      // Navigate to detail
    })
  }

  async fetchAllWeather() {
    for (let i = 0; i < this.cities.length; i++) {
      await this.fetchWeather(this.cities[i]);
    }
  }

  async fetchWeather(city: City) {
    // Simulate API call
    setTimeout(() => {
      const weather = new Weather(new CurrentWeather(15, "Sunny"));
      this.weathers.set(city.id, weather);
    }, 1000);
  }
}

class City {
  id: string;
  name: string;

  constructor(name: string) {
    this.id = Math.random().toString(36).substring(7);
    this.name = name;
  }
}

class Weather {
  current: CurrentWeather;

  constructor(current: CurrentWeather) {
    this.current = current;
  }
}

class CurrentWeather {
  temperature: number;
  condition: string;

  constructor(temperature: number, condition: string) {
    this.temperature = temperature;
    this.condition = condition;
  }
}