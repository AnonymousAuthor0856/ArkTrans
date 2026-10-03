@Entry
@Component
struct TransferWizard {
  @State private progress: number = 0.4;

  private readonly primary: ResourceColor = '#FFA500';
  private readonly secondary: ResourceColor = '#FFC300';
  private readonly background: ResourceColor = '#FFFBF2';
  private readonly surfaceVariant: ResourceColor = '#FFEED6';
  private readonly onPrimary: ResourceColor = '#FFFFFF';
  private readonly onSecondary: ResourceColor = '#1E1E1E';
  private readonly onSurface: ResourceColor = '#1E1E1E';

  private readonly markerX: number = 200;
  private readonly markerY: number = 400;

  private readonly spacingMd: number = 12;
  private readonly spacingLg: number = 16;
  private readonly spacingXl: number = 24;
  private readonly spacingXxl: number = 32;

  @Builder
  ProgressBar() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(8)
        .backgroundColor(this.surfaceVariant)
        .borderRadius(4)

      Row()
        .width(`${this.progress * 100}%`)
        .height(8)
        .backgroundColor(this.primary)
        .borderRadius(4)
    }
    .width('80%')
    .height(8)
  }

  @Builder
  CircleButton(label: string, bgColor: ResourceColor, fgColor: ResourceColor, clickHandler: () => void) {
    Stack({ alignContent: Alignment.Center }) {
      Text(label)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(fgColor)
        .textAlign(TextAlign.Center)
    }
    .width(64)
    .height(64)
    .borderRadius(32)
    .backgroundColor(bgColor)
    .onClick(clickHandler)
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        Stack({ alignContent: Alignment.Center }) {
          Text('Transfer Wizard')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.onSurface)
        }
        .width('100%')
        .height(56)
        .backgroundColor(this.background)

        Stack() {
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Circle({ width: 520, height: 520 })
                .fill(this.surfaceVariant)

              Circle({ width: 40, height: 40 })
                .fill(this.primary)
                .position({
                  x: this.markerX - 20,
                  y: this.markerY - 20
                })
            }
            .width('100%')
            .height('100%')
            .clip(true)
          }
          .width('100%')
          .height('100%')
          .padding(this.spacingXl)

          Column({ space: this.spacingLg }) {
            Text('Transfer Progress')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.onSurface)

            this.ProgressBar()

            Row({ space: this.spacingMd }) {
              this.CircleButton('+', this.primary, this.onPrimary, () => {
                this.progress = Math.min(this.progress + 0.1, 1.0);
              })

              this.CircleButton('-', this.secondary, this.onSecondary, () => {
                this.progress = Math.max(this.progress - 0.1, 0.0);
              })
            }
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.End)
          .padding({ bottom: this.spacingXxl })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.background)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['#33FFC300', 0.0],
        ['#FFFBF2', 0.5],
        ['#33FFA500', 1.0]
      ]
    })
  }
}