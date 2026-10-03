@Entry
@Component
struct Index {
  @State AQI: string = '0'
  @State aqi: number = 42
  @State val80: number = 0
  @State Excellent: string = '0'
  @State value: string = '0'
  @State label: string = '0'
  @State IconsFilledHome: string = '0'
  @State RoomAnalysis: string = '0'
  @State AirQualityMessage: string = '0'
  @State LivingRoom: string = '0'
  @State AeroSense: string = '0'
  @State IconsFilledSettings: string = '0'
  @State Menu: string = '0'
  @State icon: string = '0'
  @State IconsFilledRefresh: string = '0'
  @State RefreshData: string = '0'
  @State AddRoom: string = '0'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Main Content (LazyColumn equivalent)
      List({ space: 32 }) {
        ListItem() {
          // AirQualityCircle
          Stack({ alignContent: Alignment.Center }) {
            // Canvas placeholder
            Canvas().width(220).height(220)

            Column({ space: 0 }) {
              Text('AQI')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(2)
                .fontColor('#757575') // TextSecondary

              Text(`${this.aqi}`)
                .fontSize(80)
                .fontWeight(FontWeight.Medium)
                .fontColor('#212121') // TextPrimary

              Text('Excellent')
                .fontSize(16)
                .fontColor('#4CAF50') // AccentGreen
                .backgroundColor('#4CAF501A') // AccentGreen with alpha
                .borderRadius(16)
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            }.alignItems(HorizontalAlign.Center)
          }.width('100%').aspectRatio(1.2)
        }

        ListItem() {
          // Row Metric Cards 1
          Row({ space: 16 }) {
            // MetricCard Temp
            Column() {
              Column({ space: 0 }) {
                Row({ space: 0 }) {
                  Image($r('app.media.startIcon'))
                    .width(20)
                    .height(20)
                    .objectFit(ImageFit.Contain)
                }.width('100%')

                Column({ space: 0 }) {
                  Text('23°C')
                    .fontSize(24)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#212121')

                  Text('Temp')
                    .fontSize(12)
                    .fontColor('#757575')
                }
              }.width('100%').height('100%').padding(16)
            }
            .layoutWeight(1)
            .height(110)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })

            // MetricCard Humidity
            Column() {
              Column({ space: 0 }) {
                Row({ space: 0 }) {
                  Image($r('app.media.startIcon'))
                    .width(20)
                    .height(20)
                    .objectFit(ImageFit.Contain)
                }.width('100%')

                Column({ space: 0 }) {
                  Text('45%')
                    .fontSize(24)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#212121')

                  Text('Humidity')
                    .fontSize(12)
                    .fontColor('#757575')
                }
              }.width('100%').height('100%').padding(16)
            }
            .layoutWeight(1)
            .height(110)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
          }.width('100%')
        }

        ListItem() {
          Column() {
            Blank().height(16)
          }
        }

        ListItem() {
          // Row Metric Cards 2
          Row({ space: 16 }) {
            // MetricCard PM 2.5
            Column() {
              Column({ space: 0 }) {
                Row({ space: 0 }) {
                  Image($r('app.media.startIcon'))
                    .width(20)
                    .height(20)
                    .objectFit(ImageFit.Contain)
                }.width('100%')

                Column({ space: 0 }) {
                  Text('12')
                    .fontSize(24)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#212121')

                  Text('PM 2.5')
                    .fontSize(12)
                    .fontColor('#757575')
                }
              }.width('100%').height('100%').padding(16)
            }
            .layoutWeight(1)
            .height(110)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })

            // MetricCard CO2
            Column() {
              Column({ space: 0 }) {
                Row({ space: 0 }) {
                  Image($r('app.media.startIcon'))
                    .width(20)
                    .height(20)
                    .objectFit(ImageFit.Contain)
                }.width('100%')

                Column({ space: 0 }) {
                  Text('850')
                    .fontSize(24)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#212121')

                  Text('CO2')
                    .fontSize(12)
                    .fontColor('#757575')
                }
              }.width('100%').height('100%').padding(16)
            }
            .layoutWeight(1)
            .height(110)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
          }.width('100%')
        }

        ListItem() {
          // StatusBanner
          Column({ space: 0 }) {
            Row({ space: 0 }) {
              Image($r('app.media.startIcon'))
                .width(24)
                .height(24)
                .objectFit(ImageFit.Contain)
              
              Blank().width(12)
              
              Text('Room Analysis')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#212121')
            }.alignItems(VerticalAlign.Center)

            Blank().height(12)

            Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
              .fontSize(14)
              .lineHeight(22)
              .fontColor('#757575')
          }
          .width('100%')
          .padding(20)
          .borderRadius(20)
          .border({ width: 1, color: '#E0E0E0' })
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24, top: 16, bottom: 16 })

      // TopHeader
      Row({ space: 0 }) {
        Column({ space: 0 }) {
          Text('Living Room')
            .fontSize(16)
            .fontColor('#757575')
          
          Text('AeroSense')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#212121')
        }

        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
        }
        .width(48)
        .height(48)
        .backgroundColor('#F5F5F5')
        .borderRadius(24)
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })

      // BottomControlBar
      Column({ space: 0 }) {
        Divider().color('#E0E0E0')

        Row({ space: 0 }) {
          // ControlIcon Menu
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .border({ width: 1, color: '#E0E0E0' })

          // Refresh Button
          Button() {
            Row({ space: 8 }) {
              Image($r('app.media.startIcon'))
                .width(18)
                .height(18)
                .objectFit(ImageFit.Contain)
              
              Text('Refresh Data')
                .fontSize(14)
                .fontColor('#FFFFFF')
            }
          }
          .backgroundColor('#212121')
          .borderRadius(16)
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })

          // ControlIcon Add Room
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .objectFit(ImageFit.Contain)
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .border({ width: 1, color: '#E0E0E0' })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding(24)
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}