// V60GuideApp.ets

// MARK: - Parameter Item Component
@Component
struct ParameterItem {
  @Prop icon: Resource = $r('app.media.startIcon');
  @Prop value: string = '';
  @Prop label: string = '';

  build() {
    Column() {
      // Circular Icon
      Stack() {
        Circle()
          .width(64)
          .height(64)
          .fill(Color.Transparent)
          .stroke('#E6E6E6')
          .strokeWidth(1.5);

        Image(this.icon)
          .width(24)
          .height(24)
          .fillColor('#8A8A8A');
      }
      .width(64)
      .height(64)

      // Text Values
      Column() {
        Text(this.value)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ bottom: 4 });

        Text(this.label)
          .fontSize(13)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8A8A8A');
      }
      .margin({ top: 12 });
    }
    .width(80)
    .alignItems(HorizontalAlign.Center);
  }
}

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  build() {
    Column() {
      // MARK: Header Section
      Row() {
        Column() {
          Text('V60 Guide')
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .margin({ bottom: 4 });

          Text('Ethiopia Yirgacheffe')
            .fontSize(16)
            .fontColor('#8A8A8A');
        }
        .alignItems(HorizontalAlign.Start);

        Blank();

        Button() {
          // Action
        }
        .backgroundColor(Color.Transparent)
        .padding(0) {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor(Color.Black);
        }
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 30, bottom: 30 });

      Blank();

      // MARK: Timer Section
      Column() {
        Text('00:45')
          .fontSize(90)
          .fontWeight(FontWeight.Regular)
          .fontColor(Color.Black)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ bottom: 10 });

        Text('Target: 300g')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#8A8A8A');
      };

      Blank();

      // MARK: Parameters Grid
      Row() {
        ParameterItem({ icon: $r('app.media.startIcon'), value: '1:15', label: 'Ratio' });

        Blank();

        ParameterItem({ icon: $r('app.media.startIcon'), value: '20g', label: 'Beans' });

        Blank();

        ParameterItem({ icon: $r('app.media.startIcon'), value: '93°C', label: 'Temp' });
      }
      .width('100%')
      .padding({ left: 30, right: 30 });

      Blank();

      // Divider Line
      Divider()
        .color('#E6E6E6')
        .strokeWidth(1)
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 20 });

      // MARK: Brewing Steps Section
      Column() {
        Text('Brewing Steps')
          .fontSize(19)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .padding({ left: 24, right: 24, bottom: 15 });

        // Step Item Row
        Row() {
          // Checkmark Icon
          Image($r('app.media.startIcon'))
            .width(28)
            .height(28)
            .fillColor(Color.Black)
            .backgroundColor(Color.White)
            .borderRadius(14);

          // Step Content Background
          Row() {
            Blank();
          }
          .width('100%')
          .height(52)
          .backgroundColor('#F2F2F2')
          .borderRadius(10)
          .layoutWeight(1);
        }
        .width('100%')
        .padding({ left: 24, right: 24 });
      }
      .alignItems(HorizontalAlign.Start);

      Blank();

      // MARK: Start Button
      Button() {
        Row() {
          Image($r('app.media.startIcon'))
            .width(18)
            .height(18)
            .fillColor(Color.White)
            .margin({ right: 8 });

          Text('Start Brewing')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White);
        }
      }
      .width('100%')
      .height(60)
      .backgroundColor(Color.Black)
      .borderRadius(18)
      .padding({ left: 24, right: 24, bottom: 30 });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]);
  }
}