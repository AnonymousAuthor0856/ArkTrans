// Index.ets

interface LiveItem {
  id: number;
  title: string;
  viewers: number;
  price: string;
}

class AppTokens {
  static Colors = {
    primary: '#FF1E3A8A',
    secondary: '#FF3B82F6',
    tertiary: '#FF60A5FA',
    background: '#FFF5F8FF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE8EEFA',
    outline: '#FFCBD5E1',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF0B1220',
    onBackground: '#FF0B1220',
    onSurface: '#FF0B1220'
  };

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36
  };
}

@Entry
@Component
struct RootScreen {
  private liveList: LiveItem[] = [
    { id: 1, title: 'Smartphone Flash Deal', viewers: 1234, price: '$699' },
    { id: 2, title: 'Gaming Chair Special', viewers: 880, price: '$249' },
    { id: 3, title: 'Headphones Clearance', viewers: 1640, price: '$99' },
    { id: 4, title: 'Mechanical Keyboard', viewers: 512, price: '$129' }
  ];

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Header
        Text('Live Shop Events')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md });

        // List
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            ForEach(this.liveList, (item: LiveItem) => {
              Column() {
                // Image Placeholder
                Column()
                  .width('100%')
                  .height(160)
                  .backgroundColor(AppTokens.Colors.secondary)
                  .borderRadius(10)
                  .margin({ bottom: AppTokens.Spacing.sm });

                Text(item.title)
                  .fontSize(AppTokens.TypographyTokens.title.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .width('100%');

                Text(`${item.viewers} viewers`)
                  .fontSize(AppTokens.TypographyTokens.body.fontSize)
                  .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
                  .fontColor(AppTokens.Colors.tertiary)
                  .width('100%')
                  .margin({ bottom: AppTokens.Spacing.sm });

                // Price and Button Row
                Row() {
                  Text(item.price)
                    .fontSize(AppTokens.TypographyTokens.title.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
                    .fontColor(AppTokens.Colors.primary);

                  Blank();

                  Button('Join Live')
                    .fontSize(AppTokens.TypographyTokens.label.fontSize)
                    .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
                    .fontColor(AppTokens.Colors.onPrimary)
                    .backgroundColor(AppTokens.Colors.primary)
                    .borderRadius(10)
                    .height(36);
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center);
              }
              .width('100%')
              .padding(AppTokens.Spacing.lg)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(16)
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 });
            })
          }
          .width('100%')
          .padding({ bottom: 96 });
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .align(Alignment.Top);
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.background, 0.0],
          [AppTokens.Colors.surfaceVariant, 0.5],
          [AppTokens.Colors.background, 1.0]
        ]
      });

      // FAB
      Button('+')
        .width(56)
        .height(56)
        .fontSize(24)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(28)
        .shadow({ radius: 8, color: '#33000000', offsetX: 0, offsetY: 4 })
        .margin({ right: AppTokens.Spacing.lg, bottom: 80 });

      // Bottom Bar
      Row() {
        Text('Home')
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.primary)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);

        Text('Live')
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);

        Text('Cart')
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);

        Text('Profile')
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center);
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg });
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Bottom);
  }
}