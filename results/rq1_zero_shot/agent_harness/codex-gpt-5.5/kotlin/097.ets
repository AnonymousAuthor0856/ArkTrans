class QuickAction {
  icon: string;
  label: string;
  status: string;
  active: boolean;

  constructor(icon: string, label: string, status: string, active: boolean = false) {
    this.icon = icon;
    this.label = label;
    this.status = status;
    this.active = active;
  }
}

@Entry
@Component
struct MainActivity {
  @State targetTemp: number = 21.5;
  @State active: boolean = true;

  private actions: QuickAction[] = [
    new QuickAction('↻', 'Fan Speed', 'Auto'),
    new QuickAction('♥', 'Eco Mode', 'On', true),
    new QuickAction('i', 'Timer', 'Set 2h'),
    new QuickAction('⌂', 'Away', 'Off')
  ];

  private adjustTemp(delta: number): void {
    let next = this.targetTemp + delta;
    if (next < 16) {
      next = 16;
    }
    if (next > 30) {
      next = 30;
    }
    this.targetTemp = Math.round(next * 10) / 10;
  }

  @Builder
  HeaderSection() {
    Row() {
      Text('≡')
        .fontSize(24)
        .fontColor('#1C1C1E')
        .width(44)
        .textAlign(TextAlign.Center)
      Column() {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#8E8E93')
        Text('Connected')
          .fontSize(12)
          .fontColor('#007AFF')
      }
      .alignItems(HorizontalAlign.Center)
      Text('⚙')
        .fontSize(24)
        .fontColor('#1C1C1E')
        .width(44)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding({ top: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TemperatureDial() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(240)
          .height(240)
          .fill(Color.Transparent)
          .stroke('#F2F2F7')
          .strokeWidth(40)
        Circle()
          .width(202)
          .height(202)
          .fill(Color.Transparent)
          .stroke(this.active ? '#007AFF' : '#8E8E93')
          .strokeWidth(20)
        Circle()
          .width(20)
          .height(20)
          .fill(this.active ? '#007AFF' : '#8E8E93')
          .position({ x: `${40 + ((this.targetTemp - 16) / 14) * 36}%`, y: '12%' })
        Column() {
          Text(`${this.targetTemp.toFixed(1)}°`)
            .fontSize(44)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.active ? '#1C1C1E' : '#8E8E93')
          Text(this.active ? 'COOLING' : 'OFF')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#8E8E93')
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(280)
      .height(280)

      Row({ space: 32 }) {
        Text('⌄')
          .fontSize(28)
          .fontColor(this.active ? '#1C1C1E' : '#D1D1D6')
          .textAlign(TextAlign.Center)
          .width(56)
          .height(56)
          .lineHeight(56)
          .backgroundColor(this.active ? '#F2F2F7' : '#F9F9F9')
          .borderRadius(28)
          .border({ width: 1, color: this.active ? Color.Transparent : '#EEEEEE' })
          .onClick(() => {
            if (this.active) {
              this.adjustTemp(-0.5);
            }
          })
        Toggle({ type: ToggleType.Switch, isOn: this.active })
          .selectedColor('#1C1C1E')
          .onChange((value: boolean) => { this.active = value; })
        Text('⌃')
          .fontSize(28)
          .fontColor(this.active ? '#1C1C1E' : '#D1D1D6')
          .textAlign(TextAlign.Center)
          .width(56)
          .height(56)
          .lineHeight(56)
          .backgroundColor(this.active ? '#F2F2F7' : '#F9F9F9')
          .borderRadius(28)
          .border({ width: 1, color: this.active ? Color.Transparent : '#EEEEEE' })
          .onClick(() => {
            if (this.active) {
              this.adjustTemp(0.5);
            }
          })
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: 32 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  QuickActionCard(action: QuickAction) {
    Column() {
      Text(action.icon)
        .fontSize(24)
        .fontColor(action.active ? '#FFFFFF' : '#1C1C1E')
      Column() {
        Text(action.label)
          .fontSize(12)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(action.active ? '#FFFFFF' : '#1C1C1E')
        Text(action.status)
          .fontSize(12)
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .height(100)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(action.active ? '#1C1C1E' : '#F2F2F7')
    .borderRadius(20)
  }

  @Builder
  ControlGridSection() {
    Column() {
      Text('QUICK ACTIONS')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#8E8E93')
        .width('100%')
        .margin({ bottom: 16 })
      Row({ space: 16 }) {
        this.QuickActionCard(this.actions[0])
        this.QuickActionCard(this.actions[1])
      }
      .width('100%')
      Blank().height(16)
      Row({ space: 16 }) {
        this.QuickActionCard(this.actions[2])
        this.QuickActionCard(this.actions[3])
      }
      .width('100%')
    }
    .width('100%')
  }

  build() {
    Column() {
      this.HeaderSection()
      Blank().height(40)
      this.TemperatureDial()
      Blank().height(40)
      this.ControlGridSection()
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#FFFFFF')
  }
}
