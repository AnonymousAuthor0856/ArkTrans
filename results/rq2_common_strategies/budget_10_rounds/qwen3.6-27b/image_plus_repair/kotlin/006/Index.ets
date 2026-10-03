// App.ets
import { UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
    console.info('EntryAbility onCreate');
  }

  onDestroy() {
    console.info('EntryAbility onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    console.info('EntryAbility onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        console.error('Failed to load content. Cause:' + JSON.stringify(err));
        return;
      }
      console.info('Succeeded in loading content. Data:' + JSON.stringify(data));
    });
  }

  onWindowStageDestroy() {
    console.info('EntryAbility onWindowStageDestroy');
  }

  onForeground() {
    console.info('EntryAbility onForeground');
  }

  onBackground() {
    console.info('EntryAbility onBackground');
  }
}

// pages/Index.ets
@Entry
@Component
struct WeatherApp {
  @State currentLocation: string = 'New York'
  @State temperature: string = '72°'
  @State condition: string = 'Sunny'
  @State feelsLike: string = '74°'
  @State humidity: string = '45%'
  @State wind: string = '5 mph'

  private hourlyForecast: Array<WeatherHour> = [
    { hour: 'Now', temp: '72°', condition: 'Sunny', color: '#FF9800' },
    { hour: '1 PM', temp: '74°', condition: 'Sunny', color: '#FF9800' },
    { hour: '2 PM', temp: '75°', condition: 'Sunny', color: '#FF9800' },
    { hour: '3 PM', temp: '76°', condition: 'Cloudy', color: '#2196F3' },
    { hour: '4 PM', temp: '74°', condition: 'Cloudy', color: '#2196F3' },
    { hour: '5 PM', temp: '72°', condition: 'Rain', color: '#4CAF50' },
    { hour: '6 PM', temp: '70°', condition: 'Rain', color: '#4CAF50' }
  ]

  private weeklyForecast: Array<WeatherDay> = [
    { day: 'Today', high: '76°', low: '62°', condition: 'Sunny', color: '#FF9800' },
    { day: 'Mon', high: '74°', low: '60°', condition: 'Cloudy', color: '#2196F3' },
    { day: 'Tue', high: '72°', low: '58°', condition: 'Rain', color: '#4CAF50' },
    { day: 'Wed', high: '70°', low: '56°', condition: 'Rain', color: '#4CAF50' },
    { day: 'Thu', high: '73°', low: '59°', condition: 'Cloudy', color: '#2196F3' },
    { day: 'Fri', high: '75°', low: '61°', condition: 'Sunny', color: '#FF9800' },
    { day: 'Sat', high: '77°', low: '63°', condition: 'Sunny', color: '#FF9800' }
  ]

  build() {
    Column() {
      // Header
      Text('Weather')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#263238')
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: 20, bottom: 16 })

      // Current Weather Card
      Column() {
        Text(this.currentLocation)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#263238')
        
        Text(this.temperature)
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#263238')
          .margin({ top: 4 })
        
        Text(this.condition)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#263238')
          .opacity(0.7)
          .margin({ top: 4 })
        
        Row() {
          Column() {
            Text('Feels like')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#263238')
              .opacity(0.7)
            
            Text(this.feelsLike)
              .fontSize(12)
              .fontColor('#263238')
              .margin({ top: 2 })
          }
          
          Column() {
            Text('Humidity')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#263238')
              .opacity(0.7)
            
            Text(this.humidity)
              .fontSize(12)
              .fontColor('#263238')
              .margin({ top: 2 })
          }
          
          Column() {
            Text('Wind')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor('#263238')
              .opacity(0.7)
            
            Text(this.wind)
              .fontSize(12)
              .fontColor('#263238')
              .margin({ top: 2 })
          }
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
        .margin({ top: 16 })
      }
      .width('100%')
      .padding(14)
      .backgroundColor('#FFFFFF')
      .borderRadius(14)
      .shadow({ radius: 5, color: 'rgba(0,0,0,0.12)', offsetY: 2 })
      .alignItems(HorizontalAlign.Center)

      // Hourly Forecast
      Column() {
        Text('Hourly Forecast')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#263238')
          .width('100%')
          .margin({ top: 16, bottom: 10 })
        
        Scroll() {
          Row() {
            ForEach(this.hourlyForecast, (hour: WeatherHour) => {
              Column() {
                Text(hour.hour)
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#263238')
                
                Circle()
                  .width(20)
                  .height(20)
                  .fill(Color(hexToRgb(hour.color)))
                  .margin({ top: 4, bottom: 4 })
                
                Text(hour.temp)
                  .fontSize(12)
                  .fontColor('#263238')
              }
              .width(70)
              .padding(6)
              .backgroundColor('#FFFFFF')
              .borderRadius(10)
              .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
              .alignItems(HorizontalAlign.Center)
              .margin({ right: 6 })
            })
          }
        }
        .width('100%')
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
      }
      .width('100%')

      // 7-Day Forecast
      Column() {
        Text('7-Day Forecast')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#263238')
          .width('100%')
          .margin({ top: 16, bottom: 10 })
        
        ForEach(this.weeklyForecast, (day: WeatherDay) => {
          Row() {
            Text(day.day)
              .fontSize(12)
              .fontColor('#263238')
              .width(40)
            
            Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
              Circle()
                .width(16)
                .height(16)
                .fill(Color(hexToRgb(day.color)))
            }
            .flexGrow(1)
            
            Row() {
              Text(day.high)
                .fontSize(12)
                .fontColor('#263238')
              
              Text(day.low)
                .fontSize(12)
                .fontColor('#263238')
                .opacity(0.5)
                .margin({ left: 6 })
            }
          }
          .width('100%')
          .padding(10)
          .backgroundColor('#FFFFFF')
          .borderRadius(6)
          .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
          .margin({ bottom: 6 })
        })
      }
      .width('100%')

      // Additional Info Card
      Row() {
        Column() {
          Text('UV Index')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#263238')
            .opacity(0.7)
          
          Text('Moderate')
            .fontSize(12)
            .fontColor('#263238')
            .margin({ top: 2 })
        }
        
        Column() {
          Text('Sunset')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#263238')
            .opacity(0.7)
          
          Text('7:45 PM')
            .fontSize(12)
            .fontColor('#263238')
            .margin({ top: 2 })
        }
        
        Column() {
          Text('Visibility')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor('#263238')
            .opacity(0.7)
          
          Text('10 mi')
            .fontSize(12)
            .fontColor('#263238')
            .margin({ top: 2 })
        }
      }
      .width('100%')
      .padding(10)
      .backgroundColor('#E8F5E8')
      .borderRadius(10)
      .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 16 })

      Blank()

      // Bottom Navigation
      Row() {
        Button('NY')
          .onClick(() => {
            this.currentLocation = 'New York'
          })
          .backgroundColor(this.currentLocation === 'New York' ? '#2196F3' : '#E8F5E8')
          .fontColor(this.currentLocation === 'New York' ? '#FFFFFF' : '#263238')
          .borderRadius(10)
          .height(32)
          .width(80)
          .margin({ right: 10 })
        
        Button('London')
          .onClick(() => {
            this.currentLocation = 'London'
          })
          .backgroundColor(this.currentLocation === 'London' ? '#2196F3' : '#E8F5E8')
          .fontColor(this.currentLocation === 'London' ? '#FFFFFF' : '#263238')
          .borderRadius(10)
          .height(32)
          .width(80)
          .margin({ right: 10 })
        
        Button('Tokyo')
          .onClick(() => {
            this.currentLocation = 'Tokyo'
          })
          .backgroundColor(this.currentLocation === 'Tokyo' ? '#2196F3' : '#E8F5E8')
          .fontColor(this.currentLocation === 'Tokyo' ? '#FFFFFF' : '#263238')
          .borderRadius(10)
          .height(32)
          .width(80)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding(10)
      .backgroundColor('#FFFFFF')
      .borderRadius({ topLeft: 14, topRight: 14 })
      .shadow({ radius: 5, color: 'rgba(0,0,0,0.12)', offsetY: 2 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 10, right: 10 })
    .backgroundColor('#F5F7FA')
  }
}

interface WeatherHour {
  hour: string;
  temp: string;
  condition: string;
  color: string;
}

interface WeatherDay {
  day: string;
  high: string;
  low: string;
  condition: string;
  color: string;
}

function hexToRgb(hex: string): number {
  const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  return result ? 
    parseInt(result[1], 16) * 65536 + 
    parseInt(result[2], 16) * 256 + 
    parseInt(result[3], 16) : 0;
}