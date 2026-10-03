class AppColors {
  static primary: string = '#38BDF8';
  static secondary: string = '#A78BFA';
  static tertiary: string = '#7DD3FC';
  static background: string = '#F1F5F9';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E2E8F0';
  static outline: string = '#CBD5E1';
  static success: string = '#22C55E';
  static warning: string = '#F59E0B';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#1E1E1E';
  static onTertiary: string = '#1E1E1E';
  static onBackground: string = '#1E1E1E';
  static onSurface: string = '#1E1E1E';
}

@Entry
@Component
struct Index {
  @State scrollY: number = 0;

  build() {
    Column() {
      Row() {
        Text('Glass Doc Reader')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.background)

      Stack() {
        Column() {
        }
        .width('100%')
        .height('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [AppColors.surfaceVariant + 'CC', 0.0],
            [AppColors.background, 0.5],
            [AppColors.surfaceVariant + 'CC', 1.0]
          ]
        })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.scrollY += event.offsetY;
            })
        )

        Column() {
          Text('Document Reader')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
            .margin({ bottom: 12 })

          ForEach([1, 2, 3, 4, 5, 6, 7, 8], (item: number) => {
            Text(`This is a sample line of text content number ${item}.`)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onSurface)
              .margin({ bottom: 8 })
          })
        }
        .width('90%')
        .height(400)
        .padding(16)
        .backgroundColor(AppColors.surface + 'B3')
        .borderRadius(20)
        .shadow({
          radius: 8,
          color: '#0000002E',
          offsetY: 4
        })
        .translate({ y: this.scrollY / 5 })
      }
      .width('100%')
      .layoutWeight(1)
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
