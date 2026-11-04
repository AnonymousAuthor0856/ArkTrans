class TransferColors {
  static primary: string = '#FFA500';
  static secondary: string = '#FFC300';
  static tertiary: string = '#FFE066';
  static background: string = '#FFFBF2';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#FFEED6';
  static outline: string = '#F1C27D';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#1E1E1E';
  static onSurface: string = '#1E1E1E';
}

@Entry
@Component
struct Index {
  @State progress: number = 40;

  @Builder
  TransferVisual() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(260)
        .height(260)
        .fill(TransferColors.surfaceVariant)
      Circle()
        .width(40)
        .height(40)
        .fill(TransferColors.primary)
        .translate({ x: -40, y: -80 })
    }
    .width('100%')
    .layoutWeight(1)
  }

  private updateProgress(delta: number) {
    let nextValue: number = this.progress + delta;
    if (nextValue > 100) {
      nextValue = 100;
    }
    if (nextValue < 0) {
      nextValue = 0;
    }
    this.progress = nextValue;
  }

  build() {
    Column() {
      Text('Transfer Wizard')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(TransferColors.onSurface)
        .lineHeight(34)
        .textAlign(TextAlign.Center)
        .width('100%')
        .padding({ top: 12, bottom: 12 })

      Stack({ alignContent: Alignment.Center }) {
        Column() {
          this.TransferVisual()
        }
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#33FFC300', 0.0], [TransferColors.background, 0.5], ['#33FFA500', 1.0]]
        })

        Column() {
          Text('Transfer Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(TransferColors.onSurface)
            .lineHeight(24)
          Progress({ value: this.progress, total: 100, type: ProgressType.Linear })
            .width('80%')
            .height(8)
            .color(TransferColors.primary)
            .backgroundColor(TransferColors.surfaceVariant)
            .margin({ top: 16 })
          Row({ space: 12 }) {
            Button('+')
              .fontSize(18)
              .fontColor(TransferColors.onPrimary)
              .width(56)
              .height(56)
              .backgroundColor(TransferColors.primary)
              .borderRadius(28)
              .onClick(() => {
                this.updateProgress(10);
              })
            Button('-')
              .fontSize(18)
              .fontColor(TransferColors.onSecondary)
              .width(56)
              .height(56)
              .backgroundColor(TransferColors.secondary)
              .borderRadius(28)
              .onClick(() => {
                this.updateProgress(-10);
              })
          }
          .alignItems(VerticalAlign.Center)
          .margin({ top: 16 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .position({ x: 0, y: 540 })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(TransferColors.background)
  }
}
