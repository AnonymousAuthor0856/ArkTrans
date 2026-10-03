class MetricItem {
  label: string;
  value: string;
  icon: string;
  color: string;

  constructor(label: string, value: string, icon: string, color: string) {
    this.label = label;
    this.value = value;
    this.icon = icon;
    this.color = color;
  }
}

@Entry
@Component
struct MainActivity {
  private metrics: MetricItem[] = [
    new MetricItem('Temp', '23°C', 'i', '#1A1A1A'),
    new MetricItem('Humidity', '45%', '✓', '#4CAF50'),
    new MetricItem('PM 2.5', '12', '✓', '#4CAF50'),
    new MetricItem('CO2', '850', '!', '#FF9800')
  ];

  @Builder
  TopHeader() {
    Row() {
      Column() {
        Text('Living Room')
          .fontSize(16)
          .fontColor('#757575')
        Text('AeroSense')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Text('⚙')
        .fontSize(24)
        .fontColor('#1A1A1A')
        .textAlign(TextAlign.Center)
        .width(48)
        .height(48)
        .lineHeight(48)
        .backgroundColor('#FAFAFA')
        .borderRadius(24)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 24 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  AirQualityCircle() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(220)
        .height(220)
        .fill(Color.Transparent)
        .stroke('#FAFAFA')
        .strokeWidth(40)
      Circle()
        .width(190)
        .height(190)
        .fill(Color.Transparent)
        .stroke('#4CAF50')
        .strokeWidth(22)
      Column() {
        Text('AQI')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
        Text('42')
          .fontSize(80)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1A1A1A')
        Text('Excellent')
          .fontSize(16)
          .fontColor('#4CAF50')
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#1A4CAF50')
          .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .aspectRatio(1.2)
  }

  @Builder
  MetricCard(item: MetricItem) {
    Column() {
      Text(item.icon)
        .fontSize(20)
        .fontColor(item.color)
        .width('100%')
      Column() {
        Text(item.value)
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#1A1A1A')
        Text(item.label)
          .fontSize(12)
          .fontColor('#757575')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .height(110)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FAFAFA')
    .borderRadius(24)
  }

  @Builder
  MetricsGrid() {
    Column({ space: 16 }) {
      Row({ space: 16 }) {
        this.MetricCard(this.metrics[0])
        this.MetricCard(this.metrics[1])
      }
      .width('100%')
      Row({ space: 16 }) {
        this.MetricCard(this.metrics[2])
        this.MetricCard(this.metrics[3])
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  StatusBanner() {
    Column() {
      Row({ space: 12 }) {
        Text('⌂')
          .fontSize(24)
          .fontColor('#1A1A1A')
        Text('Room Analysis')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
      }
      .alignItems(VerticalAlign.Center)
      Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
        .fontSize(14)
        .fontColor('#757575')
        .lineHeight(22)
        .width('100%')
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(20)
    .border({ width: 1, color: '#EEEEEE' })
    .borderRadius(20)
  }

  @Builder
  BottomControlBar() {
    Column() {
      Divider().color('#EEEEEE')
      Row() {
        Text('≡')
          .fontSize(24)
          .fontColor('#1A1A1A')
          .textAlign(TextAlign.Center)
          .width(48)
          .height(48)
          .lineHeight(48)
          .border({ width: 1, color: '#EEEEEE' })
          .borderRadius(24)
        Button('↻  Refresh Data')
          .fontSize(14)
          .fontColor('#FFFFFF')
          .height(52)
          .backgroundColor('#1A1A1A')
          .borderRadius(16)
          .padding({ left: 24, right: 24 })
        Text('+')
          .fontSize(24)
          .fontColor('#1A1A1A')
          .textAlign(TextAlign.Center)
          .width(48)
          .height(48)
          .lineHeight(48)
          .border({ width: 1, color: '#EEEEEE' })
          .borderRadius(24)
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
  }

  build() {
    Column() {
      this.TopHeader()
      Scroll() {
        Column({ space: 32 }) {
          this.AirQualityCircle()
          this.MetricsGrid()
          this.StatusBanner()
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
