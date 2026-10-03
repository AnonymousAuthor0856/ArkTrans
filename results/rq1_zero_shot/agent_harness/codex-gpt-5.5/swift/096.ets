const PURE_WHITE: string = '#FFFFFF';
const OFF_WHITE: string = '#FAFAFA';
const TEXT_PRIMARY: string = '#1A1A1A';
const TEXT_SECONDARY: string = '#757575';
const ACCENT_GREEN: string = '#4CAF50';
const ACCENT_WARNING: string = '#FF9800';
const DIVIDER_COLOR: string = '#EEEEEE';

@Entry
@Component
struct AeroSenseContentView {
  build() {
    Stack() {
      Column() {
        TopHeader()
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        MainContent()
          .padding({ left: 24, right: 24, bottom: 16 })
          .layoutWeight(1)
          .width('100%')
      }
      .backgroundColor(PURE_WHITE)
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        BottomControlBar()
      }
      .width('100%')
      .height('100%')
    }
    .backgroundColor(PURE_WHITE)
    .width('100%')
    .height('100%')
  }
}

@Component
struct TopHeader {
  build() {
    Row() {
      Column() {
        Text('Living Room')
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(TEXT_SECONDARY)

        Text('AeroSense')
          .fontSize(34)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_PRIMARY)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(TEXT_PRIMARY)
          .width(48)
          .height(48)
          .textAlign(TextAlign.Center)
      }
      .type(ButtonType.Circle)
      .backgroundColor(OFF_WHITE)
      .width(48)
      .height(48)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MainContent {
  build() {
    Scroll() {
      Column({ space: 32 }) {
        AirQualityCircle({ aqi: 42 })

        Column({ space: 16 }) {
          Row({ space: 16 }) {
            MetricCard({ label: 'Temp', value: '23°C', iconName: 'i', statusColor: TEXT_PRIMARY })
            MetricCard({ label: 'Humidity', value: '45%', iconName: '✓', statusColor: ACCENT_GREEN })
          }
          .width('100%')

          Row({ space: 16 }) {
            MetricCard({ label: 'PM 2.5', value: '12', iconName: '✓', statusColor: ACCENT_GREEN })
            MetricCard({ label: 'CO2', value: '850', iconName: '!', statusColor: ACCENT_WARNING })
          }
          .width('100%')
        }
        .width('100%')

        StatusBanner()
      }
      .padding({ top: 16, bottom: 16 })
      .width('100%')
    }
    .scrollBar(BarState.Off)
    .width('100%')
    .height('100%')
  }
}

@Component
struct AirQualityCircle {
  @Prop aqi: number;

  build() {
    Stack() {
      Progress({ value: 100, total: 100, type: ProgressType.Ring })
        .color(OFF_WHITE)
        .style({ strokeWidth: 40 })
        .width(220)
        .height(220)

      Progress({ value: this.aqi, total: 100, type: ProgressType.Ring })
        .color(ACCENT_GREEN)
        .style({ strokeWidth: 40 })
        .width(220)
        .height(220)

      Circle()
        .fill(PURE_WHITE)
        .width(12)
        .height(12)
        .translate({ x: 74, y: 24 })

      Column() {
        Text('AQI')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_SECONDARY)
          .letterSpacing(2)

        Text(`${this.aqi}`)
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor(TEXT_PRIMARY)

        Text('Excellent')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ACCENT_GREEN)
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#EAF7EA')
          .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(264)
  }
}

@Component
struct MetricCard {
  @Prop label: string;
  @Prop value: string;
  @Prop iconName: string;
  @Prop statusColor: string;

  build() {
    Column() {
      Row() {
        Text(this.iconName)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.statusColor)
        Blank()
      }
      .width('100%')

      Blank()

      Column({ space: 4 }) {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(TEXT_PRIMARY)

        Text(this.label)
          .fontSize(12)
          .fontColor(TEXT_SECONDARY)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .height(110)
    .layoutWeight(1)
    .backgroundColor(OFF_WHITE)
    .borderRadius(24)
  }
}

@Component
struct StatusBanner {
  build() {
    Column() {
      Row() {
        Text('home')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_PRIMARY)

        Blank()
          .width(12)

        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_PRIMARY)
      }
      .alignItems(VerticalAlign.Center)

      Blank()
        .height(12)

      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor(TEXT_SECONDARY)
        .lineHeight(22)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(20)
    .width('100%')
    .border({ width: 1, color: DIVIDER_COLOR })
    .borderRadius(20)
  }
}

@Component
struct BottomControlBar {
  build() {
    Column() {
      Divider()
        .color(DIVIDER_COLOR)

      Row() {
        ControlIcon({ iconName: '☰', description: 'Menu' })

        Blank()

        Button() {
          Row({ space: 8 }) {
            Text('↻')
              .fontSize(18)
              .fontColor(PURE_WHITE)
            Text('Refresh Data')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(PURE_WHITE)
          }
          .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        }
        .backgroundColor(TEXT_PRIMARY)
        .borderRadius(16)

        Blank()

        ControlIcon({ iconName: '+', description: 'Add Room' })
      }
      .padding(24)
      .width('100%')
      .backgroundColor(PURE_WHITE)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }
}

@Component
struct ControlIcon {
  @Prop iconName: string;
  @Prop description: string;

  build() {
    Button() {
      Text(this.iconName)
        .fontSize(24)
        .fontColor(TEXT_PRIMARY)
        .width(48)
        .height(48)
        .textAlign(TextAlign.Center)
    }
    .type(ButtonType.Circle)
    .backgroundColor(Color.Transparent)
    .border({ width: 1, color: DIVIDER_COLOR })
    .width(48)
    .height(48)
  }
}
