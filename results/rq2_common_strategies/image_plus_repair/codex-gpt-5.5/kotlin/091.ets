@Entry
@Component
struct MainPage {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  build() {
    Scroll() {
      Column({ space: 0 }) {
        Row() {
          Button('☰', { type: ButtonType.Normal })
            .fontSize(30)
            .fontColor('#8B8B8B')
            .backgroundColor(Color.Transparent)
            .width(48)
            .height(48)
            .padding(0);

          Column({ space: 4 }) {
            Text('LIVING ROOM')
              .fontSize(23)
              .fontWeight(FontWeight.Bold)
              .fontColor('#8B8B8B')
              .letterSpacing(3);
            Text(this.isPowerOn ? 'Active' : 'Off')
              .fontSize(20)
              .fontColor(this.isPowerOn ? '#4CAF50' : '#C8C8C8');
          }
          .alignItems(HorizontalAlign.Center)
          .layoutWeight(1);

          Button('⚙', { type: ButtonType.Normal })
            .fontSize(32)
            .fontColor('#8B8B8B')
            .backgroundColor(Color.Transparent)
            .width(48)
            .height(48)
            .padding(0);
        }
        .width('100%')
        .height(92)
        .padding({ left: 24, right: 24 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center);

        Stack({ alignContent: Alignment.Center }) {
          Column()
            .width(280)
            .height(280)
            .border({ width: 1, color: '#EEEEEE', style: BorderStyle.Solid })
            .borderRadius(140);

          Column({ space: 18 }) {
            Text(`${this.targetTemp}°`)
              .fontSize(96)
              .fontWeight(FontWeight.Lighter)
              .fontColor(this.isPowerOn ? Color.Black : '#D3D3D3')
              .lineHeight(105);
            Text(`CURRENT: ${this.currentTemp}°`)
              .fontSize(27)
              .fontColor('#8B8B8B');
          }
          .alignItems(HorizontalAlign.Center);

          Row() {
            Button('⌄', { type: ButtonType.Normal })
              .fontSize(32)
              .fontColor(Color.Black)
              .backgroundColor('#F5F5F5')
              .borderRadius(24)
              .width(48)
              .height(48)
              .padding(0)
              .onClick(() => {
                if (this.isPowerOn) {
                  this.targetTemp -= 1;
                }
              });
            Blank().layoutWeight(1);
            Button('+', { type: ButtonType.Normal })
              .fontSize(32)
              .fontColor(Color.Black)
              .backgroundColor('#F5F5F5')
              .borderRadius(24)
              .width(48)
              .height(48)
              .padding(0)
              .onClick(() => {
                if (this.isPowerOn) {
                  this.targetTemp += 1;
                }
              });
          }
          .width(232)
          .alignItems(VerticalAlign.Center);
        }
        .width('100%')
        .height(300);

        Column({ space: 14 }) {
          Text('MODE')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#8B8B8B');

          Row({ space: 26 }) {
            this.modeButton('⌂', 'Auto');
            this.modeButton('⟳', 'Fan');
            this.modeButton('★', 'Cool');
          }
          .alignItems(VerticalAlign.Top);
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .margin({ top: 12, bottom: 6 });

        Row({ space: 16 }) {
          this.infoCard('ⓘ', '45%', 'Humidity');
          this.infoCard('⌃', '12 kWh', 'Energy');
        }
        .width('100%')
        .height(150)
        .padding({ left: 24, right: 24 });

        Row() {
          Column({ space: 4 }) {
            Text('Master Power')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black);
            Text(this.isPowerOn ? 'System is running' : 'System is off')
              .fontSize(15)
              .fontColor('#8B8B8B');
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1);

          Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
            .selectedColor(Color.Black)
            .switchPointColor(Color.White)
            .onChange((value: boolean) => {
              this.isPowerOn = value;
            });
        }
        .width('calc(100% - 48vp)')
        .height(82)
        .padding({ left: 20, right: 20 })
        .backgroundColor('#F9F9F9')
        .borderRadius(16)
        .margin({ top: 18, bottom: 28 });
      }
      .width('100%')
      .padding({ top: 8, bottom: 8 })
      .alignItems(HorizontalAlign.Center);
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off);
  }

  @Builder
  modeButton(symbol: string, label: string) {
    Column({ space: 8 }) {
      Button(symbol, { type: ButtonType.Normal })
        .fontSize(31)
        .fontColor(this.selectedMode === label && this.isPowerOn ? Color.White : Color.Black)
        .backgroundColor(this.selectedMode === label && this.isPowerOn ? Color.Black : Color.White)
        .border({
          width: this.selectedMode === label && this.isPowerOn ? 0 : 1,
          color: '#E0E0E0',
          style: BorderStyle.Solid,
        })
        .borderRadius(60)
        .width(60)
        .height(60)
        .padding(0)
        .enabled(this.isPowerOn)
        .onClick(() => {
          this.selectedMode = label;
        });
      Text(label)
        .fontSize(19)
        .fontColor(this.isPowerOn ? '#8B8B8B' : '#D3D3D3');
    }
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  infoCard(icon: string, value: string, title: string) {
    Column({ space: 12 }) {
      Text(icon)
        .fontSize(22)
        .fontColor('#8B8B8B')
        .alignSelf(ItemAlign.Start);
      Text(value)
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .alignSelf(ItemAlign.Start);
      Text(title)
        .fontSize(22)
        .fontColor('#8B8B8B')
        .alignSelf(ItemAlign.Start);
    }
    .layoutWeight(1)
    .height('100%')
    .padding({ left: 16, top: 16, right: 12, bottom: 14 })
    .backgroundColor('#F9F9F9')
    .border({ width: 1, color: '#F0F0F0', style: BorderStyle.Solid })
    .borderRadius(16)
    .alignItems(HorizontalAlign.Start);
  }
}
